library(pdftools)
library(tidyverse)
library(tidyr)

# This is for adding more years to the year by year tracking charts

### AREA 1 ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Area_1_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                        "Other (includes boats, aircraft, and so on)",
                                        "Unknown","Motor Vehicle Theft",
                                        "Larceny",
                                        "Arson",
                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 1"
past_crime_area1 <- past_crime_oakland

### AREA 2 ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Area_2_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 2"
past_crime_area2 <- past_crime_oakland

### AREA 3 ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Area_3_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 3"
past_crime_area3 <- past_crime_oakland


### AREA 4 ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Area_4_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 4"
past_crime_area4 <- past_crime_oakland


### AREA 5 ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Area_5_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 5"
past_crime_area5 <- past_crime_oakland

### AREA 6 ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Area_6_ACR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext2, names_sep = "_")
# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Area 6"
past_crime_area6 <- past_crime_oakland


### CITY WIDE ###

# Load the file we want for 2024 (December / Year End)
pdftext <- pdf_text("data/source/annual/OPD6_2024_Citywide_WCR_end_of_year_report_PUBLIC_SNF001.pdf") %>% strsplit(split = "\n")

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
past_crime_oakland$rawtext2 <- sub("\\s+\\s+.*", "", past_crime_oakland$rawtext)
past_crime_oakland$rawtext3 <- sub(".*?\\s+\\s+",'',past_crime_oakland$rawtext)
past_crime_oakland$rawtext3 <- past_crime_oakland$rawtext3 %>% trimws()
past_crime_oakland$rawtext3 <- strsplit(past_crime_oakland$rawtext3, "\\s+")
# past_crime_oakland$rawtext2 <- strsplit (past_crime_oakland$rawtext, "\\s+")

# flatten the list this creates in processed column
past_crime_oakland <- past_crime_oakland %>% unnest_wider(rawtext3, names_sep = "_") %>% select(1:10)

# name the columns temporarily
names(past_crime_oakland) = c("rawtext","category",
                              "total20","total21","total22","total23", "total24",
                              "change","average","change_24_vs_avg")

past_crime_oakland <- past_crime_oakland %>% filter(category %in% 
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
                                                        "Other (includes boats, aircraft, and so on)",
                                                        "Unknown","Motor Vehicle Theft",
                                                        "Larceny",
                                                        "Arson",
                                                        "Total"))

past_crime_oakland <- past_crime_oakland %>% select(2:7)

past_crime_oakland$total20 <- gsub(",","",past_crime_oakland$total20)
past_crime_oakland$total21 <- gsub(",","",past_crime_oakland$total21)
past_crime_oakland$total22 <- gsub(",","",past_crime_oakland$total22)
past_crime_oakland$total23 <- gsub(",","",past_crime_oakland$total23)
past_crime_oakland$total24 <- gsub(",","",past_crime_oakland$total24)

past_crime_oakland$total20 <- as.numeric(past_crime_oakland$total20)
past_crime_oakland$total21 <- as.numeric(past_crime_oakland$total21)
past_crime_oakland$total22 <- as.numeric(past_crime_oakland$total22)
past_crime_oakland$total23 <- as.numeric(past_crime_oakland$total23)
past_crime_oakland$total24 <- as.numeric(past_crime_oakland$total24)

past_crime_oakland[is.na(past_crime_oakland)] <- 0

past_crime_oakland$district <- "Citywide"
past_crime_citywide <- past_crime_oakland

# Combine past crime all files and prepare for storing/processing for trackers
past_crime_all <- rbind(past_crime_citywide,past_crime_area1,past_crime_area2,past_crime_area3,past_crime_area4,past_crime_area5,past_crime_area6)

# change field name for recoding crime categories and types for consistency
past_crime_all$description <- past_crime_all$category

past_crime_all$description <- case_when(past_crime_all$description == "Homicide – 187(a)PC" ~ "Murder",
                                          past_crime_all$description == "Homicide – All Other *" ~ "All Other Homicides",
                                          past_crime_all$description == "Aggravated Assault" ~ "Aggravated Assault",
                                          past_crime_all$description == "Assault with a firearm – 245(a)(2)PC" ~ "Aggravated Assault (Firearm)",
                                          past_crime_all$description == "Subtotal - Homicides + Firearm Assault" ~ "Combined subtotal of homicides and firearms-related aggravated assaults",
                                          past_crime_all$description == "Shooting occupied home or vehicle – 246PC" ~ "Aggravated Assault (Shooting occupied home or vehicle)",
                                          past_crime_all$description == "Shooting unoccupied home or vehicle – 247(b)PC" ~ "Aggravated Assault (Shooting unoccupied home or vehicle)",
                                          past_crime_all$description == "Non-firearm aggravated assaults" ~ "Aggravated Assault (Non Firearm)",
                                          past_crime_all$description == "Rape" ~ "Sexual Assault",
                                          past_crime_all$description == "Robbery" ~ "Robbery",
                                          past_crime_all$description == "Firearm" ~ "Robbery (Firearm)",
                                          past_crime_all$description == "Knife" ~ "Robbery (Knife)",
                                          past_crime_all$description == "Strong-arm" ~ "Robbery (Strong-arm)",
                                          past_crime_all$description == "Other dangerous weapon" ~ "Robbery (other dangerous weapon)",
                                          past_crime_all$description == "Residential robbery – 212.5(a)PC" ~ "Residential Robbery",
                                          past_crime_all$description == "Carjacking – 215(a) PC" ~ "Carjacking",
                                          past_crime_all$description == "Burglary" ~ "Burglary",
                                          past_crime_all$description == "Auto" ~ "Burglary (Motor Vehicle)",
                                          past_crime_all$description == "Residential" ~ "Burglary (Residential)",
                                          past_crime_all$description == "Commercial" ~ "Burglary (Commercial)",
                                          past_crime_all$description == "Other (includes boats, aircraft, and so on)" ~ "Burglary (Boats, Aircraft, Other)",
                                          past_crime_all$description == "Unknown" ~ "Burglary (Unknown)",
                                          past_crime_all$description == "Motor Vehicle Theft" ~ "Motor Vehicle Theft",
                                          past_crime_all$description == "Larceny" ~ "Larceny",
                                          past_crime_all$description == "Arson" ~ "Arson",
                                          past_crime_all$description == "Total" ~ "Total",
                                          TRUE ~ past_crime_all$description)

past_crime_all$category <- case_when(past_crime_all$description == "Murder" ~ "Murder",
                                       past_crime_all$description == "Aggravated Assault" ~ "Aggravated Assault",
                                       past_crime_all$description == "Sexual Assault" ~ "Sexual Assault",
                                       past_crime_all$description == "Robbery" ~ "Robbery",
                                       past_crime_all$description == "Burglary" ~ "Burglary",
                                       past_crime_all$description == "Motor Vehicle Theft" ~ "Motor Vehicle Theft",
                                       past_crime_all$description == "Larceny" ~ "Larceny",
                                       past_crime_all$description == "Arson" ~ "Arson",
                                       TRUE ~ "Total/Subcategory")

past_crime_all$type <- case_when(past_crime_all$category == "Murder" ~ "Violent",
                                   past_crime_all$category == "Aggravated Assault" ~ "Violent",
                                   past_crime_all$category == "Sexual Assault" ~ "Violent",
                                   past_crime_all$category == "Robbery" ~ "Violent",
                                   past_crime_all$category == "Burglary" ~ "Property",
                                   past_crime_all$category == "Motor Vehicle Theft" ~ "Property",
                                   past_crime_all$category == "Larceny" ~ "Property",
                                   past_crime_all$category == "Arson" ~ "Property",
                                   TRUE ~ "Total/Subcategory")

# save annual file and rds archive
write_csv(past_crime_all, "data/output/annual/oakland_crime_annual.csv")
saveRDS(past_crime_all, "scripts/rds/oakland_crime_annual.rds")
rm(pdftext,past_crime_citywide,past_crime_area1,past_crime_area2,past_crime_area3,past_crime_area4,past_crime_area5,past_crime_area6,past_crime_oakland)


