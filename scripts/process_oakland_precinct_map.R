library(tidyverse)
library(tidycensus)
library(leaflet)
library(leaflet.extras)
library(leaflet.providers)
library(sp)
library(sf)

# GEOGRAPHY
# Get Oakland police beats
download.file("https://data.oaklandca.gov/api/geospatial/78s7-673i?method=export&format=GeoJSON",
              "data/source/oakland/geo/oakland_police_beats.geojson")
# Get Oakland police districts
download.file("https://gisapps1.mapoakland.com/oakgis/rest/services/Prod/OPDDistrictsBdrysBeats/MapServer/0/query?where=0%3D0&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&queryByDistance=&returnExtentsOnly=false&datumTransformation=&parameterValues=&rangeValues=&f=geojson",
              "data/source/oakland/geo/oakland_police_districts.geojson")
# Get Oakland police areas
download.file("https://gisapps1.mapoakland.com/oakgis/rest/services/Prod/OPDDistrictsBdrysBeats/MapServer/2/query?where=0%3D0&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&queryByDistance=&returnExtentsOnly=false&datumTransformation=&parameterValues=&rangeValues=&f=geojson",
              "data/source/oakland/geo/oakland_police_areas.geojson")





# Read in geojson and then transform to sf format
beats_geo <- st_read("data/source/oakland/geo/oakland_police_beats.geojson") %>% st_transform(3857)
districts_geo <- st_read("data/source/oakland/geo/oakland_police_districts.geojson") %>% st_transform(3857)
areas_geo <- st_read("data/source/oakland/geo/oakland_police_areas.geojson") %>% st_transform(3857)



# Get demographic data for Census block groups to aggregate/apportion to precinct geography
# Also transforming to match the planar projection of NYPD's beats spatial file
# This also reduces us down to just the numeric population est and geometry
blocks <- get_decennial(geography = "block", 
                        year = 2020,
                        output = 'wide',
                        variables = "P1_001N", 
                        state = "CA",
                        county = c("Alameda"),
                        geometry = TRUE) %>%
  rename("population"="P1_001N") %>% 
  select(3) %>%
  janitor::clean_names() %>%
  st_transform(3857)

# Calculate the estimated population of police BEATS geographies/interpolate with tidycensus bgs
# Reminder: ext=true SUMS the population during interpolation
beats_withpop <- st_interpolate_aw(blocks, beats_geo, ext = TRUE)
# Drops geometry so it's not duplicated in the merge
beats_withpop <- st_drop_geometry(beats_withpop)
# Binds that new population column to the table
beats_geo <- cbind(beats_geo,beats_withpop)
# Cleans up unneeded calculation file
# rm(beats_withpop, blocks)

# Calculate the estimated population of police AREAS geographies/interpolate with tidycensus bgs
# Reminder: ext=true SUMS the population during interpolation
areas_withpop <- st_interpolate_aw(blocks, areas_geo, ext = TRUE)
# Drops geometry so it's not duplicated in the merge
areas_withpop <- st_drop_geometry(areas_withpop)
# Binds that new population column to the table
areas_geo <- cbind(areas_geo,areas_withpop)
# Cleans up unneeded calculation file
# rm(beats_withpop, blocks)

# Check total population assigned/estimated across all precincts
sum(beats_geo$population) # tally is 453321 
sum(areas_geo$population) # tally is 441881 

# Round the population figure; rounded to nearest thousand
beats_geo$population <- round(beats_geo$population,-3)
# Prep for tracker use
beats_geo <- beats_geo %>% st_transform(4326)
beats_geo <- st_make_valid(beats_geo)
beats_geo <- beats_geo %>% select(2,17)
names(beats_geo) <- c("beat","population","geometry")

# Round the population figure; rounded to nearest thousand
areas_geo$population <- round(areas_geo$population,-3)
# Prep for tracker use
areas_geo <- areas_geo %>% st_transform(4326)
areas_geo <- st_make_valid(areas_geo)
areas_geo <- areas_geo %>% select(1,5)
names(areas_geo) <- c("area","population","geometry")

# saving a clean geojson and separate RDS for use in tracker
file.remove("data/source/oakland/geo/oakland_beats.geojson")
st_write(beats_geo,"data/source/oakland/geo/oakland_beats.geojson")
saveRDS(beats_geo,"scripts/oakland/rds/oakland_beats.rds")

# saving a clean geojson and separate RDS for use in tracker
file.remove("data/source/oakland/geo/oakland_areas.geojson")
st_write(areas_geo,"data/source/oakland/geo/oakland_areas.geojson")
saveRDS(areas_geo,"scripts/oakland/rds/oakland_areas.rds")

# BARE PRECINCT MAP JUST FOR TESTING PURPOSES
# CAN COMMENT OUT ONCE FINALIZED
# Set bins for beats pop map
popbins <- c(0,1000, 10000,25000,50000,100000, Inf)
poppal <- colorBin("YlOrRd", beats_geo$population, bins = popbins)
poplabel <- paste(sep = "<br>", beats_geo$cp_beat,prettyNum(beats_geo$population, big.mark = ","))

oakland_beats_map <- leaflet(beats_geo) %>%
  setView(-122.25, 37.8, zoom = 11.5) %>% 
  addProviderTiles(provider = "Esri.WorldImagery") %>%
  addProviderTiles(provider = "Stamen.TonerLabels") %>%
  addPolygons(color = "white", popup = poplabel, weight = 1, smoothFactor = 0.5,
              opacity = 0.5, fillOpacity = 0.3,
              fillColor = ~poppal(`population`))
oakland_beats_map

# BARE AREAS MAP JUST FOR TESTING PURPOSES
# CAN COMMENT OUT ONCE FINALIZED
# Set bins for beats pop map
popbins <- c(0,75000,90000,10000,105000,200000, Inf)
poppal <- colorBin("YlOrRd", areas_geo$population, bins = popbins)
poplabel <- paste(sep = "<br>", areas_geo$area,prettyNum(areas_geo$population, big.mark = ","))

oakland_areas_map <- leaflet(areas_geo) %>%
  setView(-122.25, 37.8, zoom = 11.5) %>% 
  addProviderTiles(provider = "Esri.WorldImagery") %>%
  addProviderTiles(provider = "Stamen.TonerLabels") %>%
  addPolygons(color = "white", popup = poplabel, weight = 2, smoothFactor = 0.5,
              opacity = 0.5, fillOpacity = 0.3,
              fillColor = ~poppal(`population`))
oakland_areas_map


