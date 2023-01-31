# load required packages
library(rvest)
library(tidyverse)
library(stringr)
# library(xml2)
# library(XML)

# download the webpage
# Load the webpage
webpage_citywide <- read_html("https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct/folder/188715986606")
# webpage <- read_html("https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct")
webpage_area1 <- read_html("https://cityofoakland2.app.box.com/s/2gmg1912khb9t6nhalhl1rg6gscn4y86")
webpage_area2 <- read_html("https://cityofoakland2.app.box.com/s/xfa5h508r77eysje2etevwio80e1o0gk")
webpage_area3 <- read_html("https://cityofoakland2.app.box.com/s/x81lhgwlpsj7o8gn4iiw9oujhpfjgql9")
webpage_area4 <- read_html("https://cityofoakland2.app.box.com/s/ih1xz8vyo7btuhu8fb5qhy4wzbapy1t8")
webpage_area5 <- read_html("https://cityofoakland2.app.box.com/s/yfpjz8dw2zoum7cxoml0h908b6xme8ah")

# this works to get the names and id numbers of files
test_files_list <- webpage %>% html_elements(".is-loading") %>% html_text2()



# Define the input string
input_string <- test_files_list



# FIRST TO GET FILE IDs
# Extract the 12 characters after each instance of the pattern
extracted_text <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{12}")
# Convert the extracted text to a character vector
extracted_text <- unlist(extracted_text) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text
extracted_text$file_id <- substr(extracted_text$file_id,15,26)

# SECOND TO GET FILE NAMES
# Extract the 12 characters after each instance of the pattern
extracted_text2 <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector
extracted_text2 <- unlist(extracted_text2) %>% as.data.frame %>% rename("file_name" = ".")
# remove the extraneous text
extracted_text2$file_name <- substr(extracted_text2$file_name,28,102)
# remove the extraneous text
extracted_text2$file_name <- gsub("pdf.*","pdf",extracted_text2$file_name)

files_citywide <- cbind(extracted_text,extracted_text2) %>% filter
files_citywide <- files_citywide[str_detect(files_citywide$file_name, "Weekly Crime Report"), ]
files_citywide[1,1]
files_citywide[1,2]





