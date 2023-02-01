# load required packages
library(rvest)
library(tidyverse)
library(stringr)
# library(xml2)
# library(XML)

# download the webpage
# Load the webpage
url_citywide <- "https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct"
url_area1 <- "https://cityofoakland2.app.box.com/s/2gmg1912khb9t6nhalhl1rg6gscn4y86"
url_area2 <- "https://cityofoakland2.app.box.com/s/xfa5h508r77eysje2etevwio80e1o0gk"
url_area3 <- "https://cityofoakland2.app.box.com/s/x81lhgwlpsj7o8gn4iiw9oujhpfjgql9"
url_area4 <- "https://cityofoakland2.app.box.com/s/ih1xz8vyo7btuhu8fb5qhy4wzbapy1t8"
url_area5 <- "https://cityofoakland2.app.box.com/s/yfpjz8dw2zoum7cxoml0h908b6xme8ah"

webpage_citywide <- read_html(url_citywide)
webpage_area1 <- read_html(url_area1)
webpage_area2 <- read_html(url_area2)
webpage_area3 <- read_html(url_area3)
webpage_area4 <- read_html(url_area4)
webpage_area5 <- read_html(url_area5)

# this works to get the names and id numbers of files
files_list_city <- webpage_citywide %>% html_elements(".is-loading") %>% html_text2()
files_list_area1 <- webpage_area1 %>% html_elements(".is-loading") %>% html_text2()
files_list_area2 <- webpage_area2 %>% html_elements(".is-loading") %>% html_text2()
files_list_area3 <- webpage_area3 %>% html_elements(".is-loading") %>% html_text2()
files_list_area4 <- webpage_area4 %>% html_elements(".is-loading") %>% html_text2()
files_list_area5 <- webpage_area5 %>% html_elements(".is-loading") %>% html_text2()

# CITYWIDE
# Define the input string; change for each area
input_string <- files_list_city
# GET FILE ID NUMBERS for every file
# Extract the 12 characters after each instance of the pattern
extracted_file <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{14}")
# Convert the extracted text to a character vector, df and then rename column
extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text from the string in that column
extracted_file$file_id <- substr(extracted_file$file_id,15,27)
# GET FILE NAMES
# Extract the 75 characters after instance of the pattern flagging the name
extracted_name <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector, df, and then rename column
extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
# remove extraneous text on front end and back end
extracted_name$file_name <- substr(extracted_name$file_name,28,102)
extracted_name$file_name <- gsub("pdf.*","pdf",extracted_name$file_name)
# bind into a simple df and filter to only keep Weekly Crime Report pdfs
files_citywide <- cbind(extracted_file,extracted_name)
files_citywide <- files_citywide[str_detect(files_citywide$file_name, "Weekly Crime Report"), ]
# files_citywide[1,1]
# files_citywide[1,2]


# POLICE AREA 1
# Define the input string; change for each area
input_string <- files_list_area1
# GET FILE ID NUMBERS for every file
# Extract the 12 characters after each instance of the pattern
extracted_file <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{14}")
# Convert the extracted text to a character vector, df and then rename column
extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text from the string in that column
extracted_file$file_id <- substr(extracted_file$file_id,15,27)
# GET FILE NAMES
# Extract the 75 characters after instance of the pattern flagging the name
extracted_name <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector, df, and then rename column
extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
# remove extraneous text on front end and back end
extracted_name$file_name <- substr(extracted_name$file_name,28,102)
extracted_name$file_name <- gsub("pdf.*","pdf",extracted_name$file_name)
# bind into a simple df and filter to only keep Weekly Crime Report pdfs
files_area1 <- cbind(extracted_file,extracted_name)
files_area1 <- files_area1[str_detect(files_area1$file_name, "Weekly Crime Report"), ]
# files_area1[1,1]
# files_area1[1,2]


# POLICE AREA 2
# Define the input string; change for each area
input_string <- files_list_area2
# GET FILE ID NUMBERS for every file
# Extract the 12 characters after each instance of the pattern
extracted_file <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{14}")
# Convert the extracted text to a character vector, df and then rename column
extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text from the string in that column
extracted_file$file_id <- substr(extracted_file$file_id,15,27)
# GET FILE NAMES
# Extract the 75 characters after instance of the pattern flagging the name
extracted_name <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector, df, and then rename column
extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
# remove extraneous text on front end and back end
extracted_name$file_name <- substr(extracted_name$file_name,28,102)
extracted_name$file_name <- gsub("pdf.*","pdf",extracted_name$file_name)
# bind into a simple df and filter to only keep Weekly Crime Report pdfs
files_area2 <- cbind(extracted_file,extracted_name)
files_area2 <- files_area2[str_detect(files_area2$file_name, "Weekly Crime Report"), ]
# files_area2[1,1]
# files_area2[1,2]


# POLICE AREA 3
# Define the input string; change for each area
input_string <- files_list_area3
# GET FILE ID NUMBERS for every file
# Extract the 12 characters after each instance of the pattern
extracted_file <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{14}")
# Convert the extracted text to a character vector, df and then rename column
extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text from the string in that column
extracted_file$file_id <- substr(extracted_file$file_id,15,27)
# GET FILE NAMES
# Extract the 75 characters after instance of the pattern flagging the name
extracted_name <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector, df, and then rename column
extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
# remove extraneous text on front end and back end
extracted_name$file_name <- substr(extracted_name$file_name,28,102)
extracted_name$file_name <- gsub("pdf.*","pdf",extracted_name$file_name)
# bind into a simple df and filter to only keep Weekly Crime Report pdfs
files_area3 <- cbind(extracted_file,extracted_name)
files_area3 <- files_area3[str_detect(files_area3$file_name, "Weekly Crime Report"), ]
# files_area3[1,1]
# files_area3[1,2]


# POLICE AREA 4
# Define the input string; change for each area
input_string <- files_list_area4
# GET FILE ID NUMBERS for every file
# Extract the 12 characters after each instance of the pattern
extracted_file <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{14}")
# Convert the extracted text to a character vector, df and then rename column
extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text from the string in that column
extracted_file$file_id <- substr(extracted_file$file_id,15,27)
# GET FILE NAMES
# Extract the 75 characters after instance of the pattern flagging the name
extracted_name <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector, df, and then rename column
extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
# remove extraneous text on front end and back end
extracted_name$file_name <- substr(extracted_name$file_name,28,102)
extracted_name$file_name <- gsub("pdf.*","pdf",extracted_name$file_name)
# bind into a simple df and filter to only keep Weekly Crime Report pdfs
files_area4 <- cbind(extracted_file,extracted_name)
files_area4 <- files_area4[str_detect(files_area4$file_name, "Weekly Crime Report"), ]
# files_area4[1,1]
# files_area4[1,2]


# POLICE AREA 5
# Define the input string; change for each area
input_string <- files_list_area5
# GET FILE ID NUMBERS for every file
# Extract the 12 characters after each instance of the pattern
extracted_file <- str_extract_all(input_string, "\\{\\\"typedID\\\":\\\"f_.{14}")
# Convert the extracted text to a character vector, df and then rename column
extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
# remove the extraneous text from the string in that column
extracted_file$file_id <- substr(extracted_file$file_id,15,27)
# GET FILE NAMES
# Extract the 75 characters after instance of the pattern flagging the name
extracted_name <- str_extract_all(input_string, ",\"extension\":\"pdf\",\"name\":\".{75}")
# Convert the extracted text to a character vector, df, and then rename column
extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
# remove extraneous text on front end and back end
extracted_name$file_name <- substr(extracted_name$file_name,28,102)
extracted_name$file_name <- gsub("pdf.*","pdf",extracted_name$file_name)
# bind into a simple df and filter to only keep Weekly Crime Report pdfs
files_area5 <- cbind(extracted_file,extracted_name)
files_area5 <- files_area5[str_detect(files_area5$file_name, "Weekly Crime Report"), ]
# files_area5[1,1]
# files_area5[1,2]

# Build a list of URLs for the six latest files for the week
download_citywide <- paste0(url_citywide,"/file/",files_citywide[1,1])
download_area1 <- paste0(url_area1,"/file/",files_area1[1,1])
download_area2 <- paste0(url_area2,"/file/",files_area2[1,1])
download_area3 <- paste0(url_area3,"/file/",files_area3[1,1])
download_area4 <- paste0(url_area4,"/file/",files_area4[1,1])
download_area5 <- paste0(url_area5,"/file/",files_area5[1,1])

# Clean up the debris
rm(extracted_file,extracted_name,files_area1,files_area2,files_area3,
   files_area4,files_area5,files_citywide,webpage_area1,
   webpage_area2,webpage_area3,webpage_area4,webpage_area5,webpage_citywide,
   files_list_area1,files_list_area2,files_list_area3,files_list_area4,
   files_list_area5,files_list_city,input_string,url_area1,url_area2,
   url_area3,url_area4,url_area5,url_citywide)

library(RSelenium)

rs <- rsDriver(port = 4441L, browser = "firefox")

remDr$open()

# Navigate to website
remDr$navigate("https://cityofoakland2.app.box.com/s/2gmg1912khb9t6nhalhl1rg6gscn4y86/file/1126937986327")

Sys.sleep(3)   # slight delay to let page load

# Find button by CSS path and click it
btn <- remDr$findElement('xpath', '//*[@id="app"]/div[5]/span/div/span/div/header/div[2]/button[2]')
btn$clickElement()

Sys.sleep(3) # slight delay to let page load

rs$server$stop()

# mime type for pdf
# application/pdf
