library(pdftools)
library(tidyverse)
library(tidyr)

### AREA 1 ###

# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD_2021_Area_1_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_oakland <- as.data.frame(past_crime_oakland)

# name the column temporarily
names(past_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_oakland$rawtext2 <- strsplit(past_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total17","total18","total19","total20","total21",
                              "change","average","change_21_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
                                        c("Homicide – 187(a)PC","Homicide – All Other *",
                                        "Aggravated Assault",
                                        "Assault with a firearm – 245(a)(2)PC",
                                        "Subtotal - Homicides + Firearm Assault",
                                        "Shooting occupied home or vehicle – 246PC",
                                        "Non-firearm aggravated assaults",
                                        "Rape","Robbery",
                                        "Firearm","Knife",
                                        "Strong-arm","Other dangerous weapon",
                                        "Residential robbery – 212.5(a)PC",
                                        "Carjacking – 215(a) PC",
                                        "Burglary","Auto","Residential","Commercial",
                                        "Other (includes boats, aircraft, and so on)",
                                        "Unknown","Motor Vehicle Theft",
                                        "Larceny",
                                        "Arson",
                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total17 <- gsub(",","",past_crime_oakland$total17)
past_crime_oakland$total18 <- gsub(",","",past_crime_oakland$total18)
past_crime_oakland$total19 <- gsub(",","",past_crime_oakland$total19)
past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)

past_crime_oakland$total17 <- as.numeric(past_crime_oakland$total17)
past_crime_oakland$total18 <- as.numeric(past_crime_oakland$total18)
past_crime_oakland$total19 <- as.numeric(past_crime_oakland$total19)
past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 1"
past_crime_area1 <- past_crime_oakland

### AREA 2 ###

# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD_2021_Area_2_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_oakland <- as.data.frame(past_crime_oakland)

# name the column temporarily
names(past_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_oakland$rawtext2 <- strsplit(past_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total17","total18","total19","total20","total21",
                              "change","average","change_21_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total17 <- gsub(",","",past_crime_oakland$total17)
past_crime_oakland$total18 <- gsub(",","",past_crime_oakland$total18)
past_crime_oakland$total19 <- gsub(",","",past_crime_oakland$total19)
past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)

past_crime_oakland$total17 <- as.numeric(past_crime_oakland$total17)
past_crime_oakland$total18 <- as.numeric(past_crime_oakland$total18)
past_crime_oakland$total19 <- as.numeric(past_crime_oakland$total19)
past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 2"
past_crime_area2 <- past_crime_oakland

### AREA 3 ###

# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD_2021_Area_3_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_oakland <- as.data.frame(past_crime_oakland)

# name the column temporarily
names(past_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_oakland$rawtext2 <- strsplit(past_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total17","total18","total19","total20","total21",
                              "change","average","change_21_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total17 <- gsub(",","",past_crime_oakland$total17)
past_crime_oakland$total18 <- gsub(",","",past_crime_oakland$total18)
past_crime_oakland$total19 <- gsub(",","",past_crime_oakland$total19)
past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)

past_crime_oakland$total17 <- as.numeric(past_crime_oakland$total17)
past_crime_oakland$total18 <- as.numeric(past_crime_oakland$total18)
past_crime_oakland$total19 <- as.numeric(past_crime_oakland$total19)
past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 3"
past_crime_area3 <- past_crime_oakland


### AREA 4 ###

# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD_2021_Area_4_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_oakland <- as.data.frame(past_crime_oakland)

# name the column temporarily
names(past_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_oakland$rawtext2 <- strsplit(past_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total17","total18","total19","total20","total21",
                              "change","average","change_21_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total17 <- gsub(",","",past_crime_oakland$total17)
past_crime_oakland$total18 <- gsub(",","",past_crime_oakland$total18)
past_crime_oakland$total19 <- gsub(",","",past_crime_oakland$total19)
past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)

past_crime_oakland$total17 <- as.numeric(past_crime_oakland$total17)
past_crime_oakland$total18 <- as.numeric(past_crime_oakland$total18)
past_crime_oakland$total19 <- as.numeric(past_crime_oakland$total19)
past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 4"
past_crime_area4 <- past_crime_oakland


### AREA 5 ###

# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD_2021_Area_5_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_oakland <- as.data.frame(past_crime_oakland)

# name the column temporarily
names(past_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_oakland$rawtext2 <- strsplit(past_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total17","total18","total19","total20","total21",
                              "change","average","change_21_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total17 <- gsub(",","",past_crime_oakland$total17)
past_crime_oakland$total18 <- gsub(",","",past_crime_oakland$total18)
past_crime_oakland$total19 <- gsub(",","",past_crime_oakland$total19)
past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)

past_crime_oakland$total17 <- as.numeric(past_crime_oakland$total17)
past_crime_oakland$total18 <- as.numeric(past_crime_oakland$total18)
past_crime_oakland$total19 <- as.numeric(past_crime_oakland$total19)
past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 5"
past_crime_area5 <- past_crime_oakland


### CITY WIDE ###

# Load the file we want for 2021 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD_2021_Citywide_WCR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- rbind(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
rm(rawtext1,rawtext2,rawtext3,rawtext4,rawtext5,rawtext6,rawtext7,rawtext8,rawtext9,rawtext10,rawtext11,rawtext12,rawtext13,rawtext14,rawtext15,rawtext16,rawtext17,rawtext18,rawtext19,rawtext20,rawtext21,rawtext22,rawtext23,rawtext24,rawtext25,rawtext26,rawtext27,rawtext28,rawtext29,rawtext30,rawtext31,rawtext32,rawtext33,rawtext34,rawtext35,rawtext36,rawtext37,rawtext38,rawtext39,rawtext40,rawtext41,rawtext42,rawtext43,rawtext44,rawtext45,rawtext46,rawtext47,rawtext48,rawtext49,rawtext50)
past_crime_oakland <- as.data.frame(past_crime_oakland)

# name the column temporarily
names(past_crime_oakland) <- c("rawtext")
# remove the long white space on each end of each line
past_crime_oakland$rawtext2 <- strsplit(past_crime_oakland$rawtext, "\\s+\\s+")
# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2)
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total17","total18","total19","total20","total21",
                              "change","average","change_21_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
                                                      c("Homicide – 187(a)PC","Homicide – All Other *",
                                                        "Aggravated Assault",
                                                        "Assault with a firearm – 245(a)(2)PC",
                                                        "Subtotal - Homicides + Firearm Assault",
                                                        "Shooting occupied home or vehicle – 246PC",
                                                        "Non-firearm aggravated assaults",
                                                        "Rape","Robbery",
                                                        "Firearm","Knife",
                                                        "Strong-arm","Other dangerous weapon",
                                                        "Residential robbery – 212.5(a)PC",
                                                        "Carjacking – 215(a) PC",
                                                        "Burglary","Auto","Residential","Commercial",
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total17 <- gsub(",","",past_crime_oakland$total17)
past_crime_oakland$total18 <- gsub(",","",past_crime_oakland$total18)
past_crime_oakland$total19 <- gsub(",","",past_crime_oakland$total19)
past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)

past_crime_oakland$total17 <- as.numeric(past_crime_oakland$total17)
past_crime_oakland$total18 <- as.numeric(past_crime_oakland$total18)
past_crime_oakland$total19 <- as.numeric(past_crime_oakland$total19)
past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Citywide"
past_crime_citywide <- past_crime_oakland


######

past_crime_all <- rbind(past_crime_citywide,past_crime_area1,past_crime_area2,past_crime_area3,past_crime_area4,past_crime_area5)
# names(past_crime_all) <- c("category","total2018_rev","total2019","district")

# save 2018-2019 annual file and rds archive
write_csv(past_crime_all, "data/output/annual/oakland_crime_annual.csv")
saveRDS(past_crime_all, "scripts/rds/oakland_crime_annual.rds")
rm(past_crime_citywide,past_crime_area1,past_crime_area2,past_crime_area3,past_crime_area4,past_crime_area5,past_crime_oakland)


