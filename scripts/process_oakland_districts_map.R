library(tidyverse)
library(tidycensus)
library(leaflet)
library(leaflet.extras)
library(leaflet.providers)
library(sp)
library(sf)

# Get Oakland police districts (city interchangeably calls these 'police areas')
download.file("https://gisapps1.mapoakland.com/oakgis/rest/services/Prod/OPDDistrictsBdrysBeats/MapServer/2/query?where=0%3D0&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&queryByDistance=&returnExtentsOnly=false&datumTransformation=&parameterValues=&rangeValues=&f=geojson",
              "data/source/geo/oakland_police_districts.geojson")

# Read in geojson and then transform to sf format
districts_geo <- st_read("data/source/geo/oakland_police_districts.geojson") %>% st_transform(3857)

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

# Calculate the estimated population of police AREAS geographies/interpolate with tidycensus bgs
# Reminder: ext=true SUMS the population during interpolation
districts_withpop <- st_interpolate_aw(blocks, districts_geo, ext = TRUE)
# Drops geometry so it's not duplicated in the merge
districts_withpop <- st_drop_geometry(districts_withpop)
# Binds that new population column to the table
districts_geo <- cbind(districts_geo,districts_withpop)
# Cleans up unneeded calculation file
# rm(beats_withpop, blocks)

# Check total population assigned/estimated across all districts
sum(districts_geo$population) # tally is 441881 

# Round the population figure; rounded to nearest thousand
districts_geo$population <- round(districts_geo$population,-3)
# Prep for tracker use
districts_geo <- districts_geo %>% st_transform(4326)
districts_geo <- st_make_valid(districts_geo)
districts_geo <- districts_geo %>% select(2,5,6)
names(districts_geo) <- c("district","population","geometry")
st_geometry(districts_geo$geometry)
  
# saving a clean geojson and separate RDS for use in tracker
file.remove("data/output/geo/oakland_districts.geojson")
st_write(districts_geo,"data/output/geo/oakland_districts.geojson")
saveRDS(districts_geo,"scripts/rds/oakland_districts.rds")

# BARE PRECINCT MAP JUST FOR TESTING PURPOSES
# CAN COMMENT OUT ONCE FINALIZED
# Set bins for beats pop map
popbins <- c(0,75000,90000,10000,105000,200000, Inf)
poppal <- colorBin("YlOrRd", districts_geo$population, bins = popbins)
poplabel <- paste(sep = "<br>", districts_geo$district,prettyNum(districts_geo$population, big.mark = ","))

oakland_districts_map <- leaflet(districts_geo) %>%
  setView(-122.25, 37.8, zoom = 11.5) %>% 
  addProviderTiles(provider = "Esri.WorldImagery") %>%
  addProviderTiles(provider = "Stamen.TonerLabels") %>%
  addPolygons(color = "white", popup = poplabel, weight = 2, smoothFactor = 0.5,
              opacity = 0.5, fillOpacity = 0.3,
              fillColor = ~poppal(`population`))
oakland_districts_map