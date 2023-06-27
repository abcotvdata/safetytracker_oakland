library(pdftools)
library(tidyverse)
library(tidyr)
library(lubridate)

# Still not updated beyond Feb5 as of mar7 - in PDFs or data file

# citywide
# https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct
#1 https://cityofoakland2.app.box.com/s/2gmg1912khb9t6nhalhl1rg6gscn4y86
#2 https://cityofoakland2.app.box.com/s/xfa5h508r77eysje2etevwio80e1o0gk
#3 https://cityofoakland2.app.box.com/s/x81lhgwlpsj7o8gn4iiw9oujhpfjgql9
#4 https://cityofoakland2.app.box.com/s/ih1xz8vyo7btuhu8fb5qhy4wzbapy1t8
#5 https://cityofoakland2.app.box.com/s/yfpjz8dw2zoum7cxoml0h908b6xme8ah

dir_path <- "data/source/recent"

### AREA 1 ###

# Load the file we want for 2021 (December / Year End)
# pdftext <- pdf_text("data/source/recent/230626_Area 1 Weekly Crime Report 19Jun23 - 25Jun23.pdf") %>% strsplit(split = "\n")

# Find files containing "Area 1 Weekly" in their name
files <- list.files(dir_path, pattern = "Area 1 Weekly", full.names = TRUE)

# Load the first matching file
if (length(files) > 0) {
  pdftext <- pdf_text(files[1]) %>% strsplit(split = "\n")
}

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# Get latest date in our file and save for
# automating the updated date text in building tracker
asofdate <- sub(".* – ", "", rawtext6)
asofdate <- dmy(asofdate)
saveRDS(asofdate,"scripts/rds/asofdate.rds")

# Bind those into a one-column table
recent_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
recent_crime_oakland <- as.data.frame(recent_crime_oakland)

# name the column temporarily
names(recent_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
recent_crime_oakland$rawtext2 <- strsplit(recent_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
recent_crime_oakland <- recent_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(recent_crime_oakland) = c("rawtext","category",
                              "weekly_total","ytd21","ytd22","ytd23",
                              "ytd_change","threeyr_ytd_average","ytd23_vs_3yr_avg")

recent_crime_oakland <- recent_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Shooting unoccupied home or vehicle – 247(b)PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (Includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

recent_crime_oakland <- recent_crime_oakland %>% select(2:9)

recent_crime_oakland$weekly_total <- gsub(",","",recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- gsub(",","",recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- gsub(",","",recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- gsub(",","",recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- gsub(",","",recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- gsub(",","",recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- gsub(",","",recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland$weekly_total <- as.numeric(recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- as.numeric(recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- as.numeric(recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- as.numeric(recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- as.numeric(recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- as.numeric(recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- as.numeric(recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland[is.na(recent_crime_oakland)] <- 0

recent_crime_oakland$district <- "Area 1"
recent_crime_area1 <- recent_crime_oakland

### AREA 2 ###

# Load the file we want for 2021 (December / Year End)
# pdftext <- pdf_text("data/source/recent/230626_Area 2 Weekly Crime Report 19Jun23 - 25Jun23.pdf") %>% strsplit(split = "\n")

# Find files containing "Area 1 Weekly" in their name
files <- list.files(dir_path, pattern = "Area 2 Weekly", full.names = TRUE)

# Load the first matching file
if (length(files) > 0) {
  pdftext <- pdf_text(files[1]) %>% strsplit(split = "\n")
}

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# Bind those into a one-column table
recent_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
recent_crime_oakland <- as.data.frame(recent_crime_oakland)

# name the column temporarily
names(recent_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
recent_crime_oakland$rawtext2 <- strsplit(recent_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
recent_crime_oakland <- recent_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(recent_crime_oakland) = c("rawtext","category",
                                "weekly_total","ytd21","ytd22","ytd23",
                                "ytd_change","threeyr_ytd_average","ytd23_vs_3yr_avg")

recent_crime_oakland <- recent_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Shooting unoccupied home or vehicle – 247(b)PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (Includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

recent_crime_oakland <- recent_crime_oakland %>% select(2:9)

recent_crime_oakland$weekly_total <- gsub(",","",recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- gsub(",","",recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- gsub(",","",recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- gsub(",","",recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- gsub(",","",recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- gsub(",","",recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- gsub(",","",recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland$weekly_total <- as.numeric(recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- as.numeric(recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- as.numeric(recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- as.numeric(recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- as.numeric(recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- as.numeric(recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- as.numeric(recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland[is.na(recent_crime_oakland)] <- 0

recent_crime_oakland$district <- "Area 2"
recent_crime_area2 <- recent_crime_oakland

### AREA 3 ###

# Load the file we want for 2021 (December / Year End)
# pdftext <- pdf_text("data/source/recent/230626_Area 3 Weekly Crime Report 19Jun23 - 25Jun23.pdf") %>% strsplit(split = "\n")

# Find files containing "Area 1 Weekly" in their name
files <- list.files(dir_path, pattern = "Area 3 Weekly", full.names = TRUE)

# Load the first matching file
if (length(files) > 0) {
  pdftext <- pdf_text(files[1]) %>% strsplit(split = "\n")
}

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# Bind those into a one-column table
recent_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
recent_crime_oakland <- as.data.frame(recent_crime_oakland)

# name the column temporarily
names(recent_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
recent_crime_oakland$rawtext2 <- strsplit(recent_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
recent_crime_oakland <- recent_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(recent_crime_oakland) = c("rawtext","category",
                                "weekly_total","ytd21","ytd22","ytd23",
                                "ytd_change","threeyr_ytd_average","ytd23_vs_3yr_avg")

recent_crime_oakland <- recent_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Shooting unoccupied home or vehicle – 247(b)PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (Includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

recent_crime_oakland <- recent_crime_oakland %>% select(2:9)

recent_crime_oakland$weekly_total <- gsub(",","",recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- gsub(",","",recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- gsub(",","",recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- gsub(",","",recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- gsub(",","",recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- gsub(",","",recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- gsub(",","",recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland$weekly_total <- as.numeric(recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- as.numeric(recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- as.numeric(recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- as.numeric(recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- as.numeric(recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- as.numeric(recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- as.numeric(recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland[is.na(recent_crime_oakland)] <- 0

recent_crime_oakland$district <- "Area 3"
recent_crime_area3 <- recent_crime_oakland


### AREA 4 ###

# Load the file we want for 2021 (December / Year End)
# pdftext <- pdf_text("data/source/recent/230626_Area 4 Weekly Crime Report 19Jun23 - 25Jun23.pdf") %>% strsplit(split = "\n")

# Find files containing "Area 1 Weekly" in their name
files <- list.files(dir_path, pattern = "Area 4 Weekly", full.names = TRUE)

# Load the first matching file
if (length(files) > 0) {
  pdftext <- pdf_text(files[1]) %>% strsplit(split = "\n")
}

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# Bind those into a one-column table
recent_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
recent_crime_oakland <- as.data.frame(recent_crime_oakland)

# name the column temporarily
names(recent_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
recent_crime_oakland$rawtext2 <- strsplit(recent_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
recent_crime_oakland <- recent_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(recent_crime_oakland) = c("rawtext","category",
                                "weekly_total","ytd21","ytd22","ytd23",
                                "ytd_change","threeyr_ytd_average","ytd23_vs_3yr_avg")

recent_crime_oakland <- recent_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Shooting unoccupied home or vehicle – 247(b)PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (Includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

recent_crime_oakland <- recent_crime_oakland %>% select(2:9)

recent_crime_oakland$weekly_total <- gsub(",","",recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- gsub(",","",recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- gsub(",","",recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- gsub(",","",recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- gsub(",","",recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- gsub(",","",recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- gsub(",","",recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland$weekly_total <- as.numeric(recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- as.numeric(recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- as.numeric(recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- as.numeric(recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- as.numeric(recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- as.numeric(recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- as.numeric(recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland[is.na(recent_crime_oakland)] <- 0

recent_crime_oakland$district <- "Area 4"
recent_crime_area4 <- recent_crime_oakland


### AREA 5 ###

# Load the file we want for 2021 (December / Year End)
# pdftext <- pdf_text("data/source/recent/230626_Area 5 Weekly Crime Report 19Jun23 - 25Jun23.pdf") %>% strsplit(split = "\n")

# Find files containing "Area 1 Weekly" in their name
files <- list.files(dir_path, pattern = "Area 5 Weekly", full.names = TRUE)

# Load the first matching file
if (length(files) > 0) {
  pdftext <- pdf_text(files[1]) %>% strsplit(split = "\n")
}

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# Bind those into a one-column table
recent_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
recent_crime_oakland <- as.data.frame(recent_crime_oakland)

# name the column temporarily
names(recent_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
recent_crime_oakland$rawtext2 <- strsplit(recent_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
recent_crime_oakland <- recent_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(recent_crime_oakland) = c("rawtext","category",
                                "weekly_total","ytd21","ytd22","ytd23",
                                "ytd_change","threeyr_ytd_average","ytd23_vs_3yr_avg")

recent_crime_oakland <- recent_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Shooting unoccupied home or vehicle – 247(b)PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (Includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

recent_crime_oakland <- recent_crime_oakland %>% select(2:9)

recent_crime_oakland$weekly_total <- gsub(",","",recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- gsub(",","",recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- gsub(",","",recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- gsub(",","",recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- gsub(",","",recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- gsub(",","",recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- gsub(",","",recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland$weekly_total <- as.numeric(recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- as.numeric(recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- as.numeric(recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- as.numeric(recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- as.numeric(recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- as.numeric(recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- as.numeric(recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland[is.na(recent_crime_oakland)] <- 0

recent_crime_oakland$district <- "Area 5"
recent_crime_area5 <- recent_crime_oakland


### CITY WIDE ###

# Load the file we want for 2021 (December / Year End)
# pdftext <- pdf_text("data/source/recent/230626_Citywide Weekly Crime Report 19Jun23 - 25Jun23.pdf") %>% strsplit(split = "\n")

# Find files containing "Area 1 Weekly" in their name
files <- list.files(dir_path, pattern = "Citywide Weekly", full.names = TRUE)

# Load the first matching file
if (length(files) > 0) {
  pdftext <- pdf_text(files[1]) %>% strsplit(split = "\n")
}

# Grab individual text values for Page 1
rawtext1 <- pdftext[[1]][1] %>% trimws()
rawtext2 <- pdftext[[1]][2] %>% trimws()
rawtext3 <- pdftext[[1]][3] %>% trimws()
rawtext4 <- pdftext[[1]][4] %>% trimws()
rawtext5 <- pdftext[[1]][5] %>% trimws()
rawtext6 <- pdftext[[1]][6] %>% trimws()
rawtext7 <- pdftext[[1]][7] %>% trimws()
rawtext8 <- pdftext[[1]][8] %>% trimws()
rawtext9 <- pdftext[[1]][9] %>% trimws()
rawtext10 <- pdftext[[1]][10] %>% trimws()
rawtext11 <- pdftext[[1]][11] %>% trimws()
rawtext12 <- pdftext[[1]][12] %>% trimws()
rawtext13 <- pdftext[[1]][13] %>% trimws()
rawtext14 <- pdftext[[1]][14] %>% trimws()
rawtext15 <- pdftext[[1]][15] %>% trimws()
rawtext16 <- pdftext[[1]][16] %>% trimws()
rawtext17 <- pdftext[[1]][17] %>% trimws()
rawtext18 <- pdftext[[1]][18] %>% trimws()
rawtext19 <- pdftext[[1]][19] %>% trimws()
rawtext20 <- pdftext[[1]][20] %>% trimws()
rawtext21 <- pdftext[[1]][21] %>% trimws()
rawtext22 <- pdftext[[1]][22] %>% trimws()
rawtext23 <- pdftext[[1]][23] %>% trimws()
rawtext24 <- pdftext[[1]][24] %>% trimws()
rawtext25 <- pdftext[[1]][25] %>% trimws()
rawtext26 <- pdftext[[1]][26] %>% trimws()
rawtext27 <- pdftext[[1]][27] %>% trimws()
rawtext28 <- pdftext[[1]][28] %>% trimws()
rawtext29 <- pdftext[[1]][29] %>% trimws()
rawtext30 <- pdftext[[1]][30] %>% trimws()
rawtext31 <- pdftext[[1]][31] %>% trimws()
rawtext32 <- pdftext[[1]][32] %>% trimws()
rawtext33 <- pdftext[[1]][33] %>% trimws()
rawtext34 <- pdftext[[1]][34] %>% trimws()
rawtext35 <- pdftext[[1]][35] %>% trimws()
rawtext36 <- pdftext[[1]][36] %>% trimws()
rawtext37 <- pdftext[[1]][37] %>% trimws()
rawtext38 <- pdftext[[1]][38] %>% trimws()
rawtext39 <- pdftext[[1]][39] %>% trimws()
rawtext40 <- pdftext[[1]][40] %>% trimws()
rawtext41 <- pdftext[[1]][41] %>% trimws()
rawtext42 <- pdftext[[1]][42] %>% trimws()
rawtext43 <- pdftext[[1]][43] %>% trimws()
rawtext44 <- pdftext[[1]][44] %>% trimws()
rawtext45 <- pdftext[[1]][45] %>% trimws()
rawtext46 <- pdftext[[1]][46] %>% trimws()
rawtext47 <- pdftext[[1]][47] %>% trimws()
rawtext48 <- pdftext[[1]][48] %>% trimws()
rawtext49 <- pdftext[[1]][49] %>% trimws()
rawtext50 <- pdftext[[1]][50] %>% trimws()

# automating the updated date text in building tracker
asofdate <- sub(".* – ", "", rawtext6)
asofdate <- dmy(asofdate)
saveRDS(asofdate,"scripts/rds/asofdate.rds")

# Bind those into a one-column table
recent_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
recent_crime_oakland <- as.data.frame(recent_crime_oakland)

# name the column temporarily
names(recent_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
recent_crime_oakland$rawtext2 <- strsplit(recent_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
recent_crime_oakland <- recent_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(recent_crime_oakland) = c("rawtext","category",
                                "weekly_total","ytd21","ytd22","ytd23",
                                "ytd_change","threeyr_ytd_average","ytd23_vs_3yr_avg")

recent_crime_oakland <- recent_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Shooting unoccupied home or vehicle – 247(b)PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (Includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

recent_crime_oakland <- recent_crime_oakland %>% select(2:9)

recent_crime_oakland$weekly_total <- gsub(",","",recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- gsub(",","",recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- gsub(",","",recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- gsub(",","",recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- gsub(",","",recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- gsub(",","",recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- gsub(",","",recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland$weekly_total <- as.numeric(recent_crime_oakland$weekly_total)
recent_crime_oakland$ytd21 <- as.numeric(recent_crime_oakland$ytd21)
recent_crime_oakland$ytd22 <- as.numeric(recent_crime_oakland$ytd22)
recent_crime_oakland$ytd23 <- as.numeric(recent_crime_oakland$ytd23)
recent_crime_oakland$ytd_change <- as.numeric(recent_crime_oakland$ytd_change)
recent_crime_oakland$threeyr_ytd_average <- as.numeric(recent_crime_oakland$threeyr_ytd_average)
recent_crime_oakland$ytd23_vs_3yr_avg <- as.numeric(recent_crime_oakland$ytd23_vs_3yr_avg)

recent_crime_oakland[is.na(recent_crime_oakland)] <- 0

recent_crime_oakland$district <- "Citywide"
recent_crime_citywide <- recent_crime_oakland

# Combine and prepare file for storing and processing for trackers
recent_crime_all <- rbind(recent_crime_citywide,recent_crime_area1,recent_crime_area2,recent_crime_area3,recent_crime_area4,recent_crime_area5)

recent_crime_all$description <- recent_crime_all$category

recent_crime_all$description <- case_when(recent_crime_all$description == "Homicide – 187(a)PC" ~ "Murder",
                                          recent_crime_all$description == "Homicide – All Other *" ~ "All Other Homicides",
                                          recent_crime_all$description == "Aggravated Assault" ~ "Aggravated Assault",
                                          recent_crime_all$description == "Assault with a firearm – 245(a)(2)PC" ~ "Aggravated Assault (Firearm)",
                                          recent_crime_all$description == "Subtotal - Homicides + Firearm Assault" ~ "Combined subtotal of homicides and firearms-related aggravated assaults",
                                          recent_crime_all$description == "Shooting occupied home or vehicle – 246PC" ~ "Aggravated Assault (Shooting occupied home or vehicle)",
                                          recent_crime_all$description == "Shooting unoccupied home or vehicle – 247(b)PC" ~ "Aggravated Assault (Shooting unoccupied home or vehicle)",
                                          recent_crime_all$description == "Non-firearm aggravated assaults" ~ "Aggravated Assault (Non Firearm)",
                                          recent_crime_all$description == "Rape" ~ "Sexual Assault",
                                          recent_crime_all$description == "Robbery" ~ "Robbery",
                                          recent_crime_all$description == "Firearm" ~ "Robbery (Firearm)",
                                          recent_crime_all$description == "Knife" ~ "Robbery (Knife)",
                                          recent_crime_all$description == "Strong-arm" ~ "Robbery (Strong-arm)",
                                          recent_crime_all$description == "Other dangerous weapon" ~ "Robbery (other dangerous weapon)",
                                          recent_crime_all$description == "Residential robbery – 212.5(a)PC" ~ "Residential Robbery",
                                          recent_crime_all$description == "Carjacking – 215(a) PC" ~ "Carjacking",
                                          recent_crime_all$description == "Burglary" ~ "Burglary",
                                          recent_crime_all$description == "Auto" ~ "Burglary (Motor Vehicle)",
                                          recent_crime_all$description == "Residential" ~ "Burglary (Residential)",
                                          recent_crime_all$description == "Commercial" ~ "Burglary (Commercial)",
                                          recent_crime_all$description == "Other (Includes boats, aircraft, and so on)" ~ "Burglary (Boats, Aircraft, Other)",
                                          recent_crime_all$description == "Unknown" ~ "Burglary (Unknown)",
                                          recent_crime_all$description == "Motor Vehicle Theft" ~ "Motor Vehicle Theft",
                                          recent_crime_all$description == "Larceny" ~ "Larceny",
                                          recent_crime_all$description == "Arson" ~ "Arson",
                                          recent_crime_all$description == "Total" ~ "Total",
                                          TRUE ~ recent_crime_all$description)

recent_crime_all$category <- case_when(recent_crime_all$description == "Murder" ~ "Murder",
                                       recent_crime_all$description == "Aggravated Assault" ~ "Aggravated Assault",
                                       recent_crime_all$description == "Sexual Assault" ~ "Sexual Assault",
                                       recent_crime_all$description == "Robbery" ~ "Robbery",
                                       recent_crime_all$description == "Burglary" ~ "Burglary",
                                       recent_crime_all$description == "Motor Vehicle Theft" ~ "Motor Vehicle Theft",
                                       recent_crime_all$description == "Larceny" ~ "Larceny",
                                       recent_crime_all$description == "Arson" ~ "Arson",
                                       TRUE ~ "Total/Subcategory")

recent_crime_all$type <- case_when(recent_crime_all$category == "Murder" ~ "Violent",
                                   recent_crime_all$category == "Aggravated Assault" ~ "Violent",
                                   recent_crime_all$category == "Sexual Assault" ~ "Violent",
                                   recent_crime_all$category == "Robbery" ~ "Violent",
                                   recent_crime_all$category == "Burglary" ~ "Property",
                                   recent_crime_all$category == "Motor Vehicle Theft" ~ "Property",
                                   recent_crime_all$category == "Larceny" ~ "Property",
                                   recent_crime_all$category == "Arson" ~ "Property",
                                   TRUE ~ "Total/Subcategory")

recent_crime_all$updated <- asofdate

# save the recent YTD annual file and rds archive
write_csv(recent_crime_all, "data/output/recent/oakland_crime_recent.csv")
saveRDS(recent_crime_all, "scripts/rds/oakland_crime_recent.rds")
rm(pdftext,recent_crime_oakland,recent_crime_citywide,recent_crime_area1,recent_crime_area2,recent_crime_area3,recent_crime_area4,recent_crime_area5)