# load required packages
library(rvest)
library(tidyverse)
library(xml2)
library(XML)

# download the webpage
# Load the webpage
webpage <- read_html("https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct/folder/188715986606")
webpage <- read_html("https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct")


# this works to get the names and id numbers of files
test_files_list <- webpage %>% html_elements(".is-loading") %>% html_text2()

# we need to capture everything starting with this
# keeping the part after the opening bracket
# ]}},{"typedID":"f_
test_files_list <- gsub('.*\\]\\}\\},\\{"typedID"\\:"f_', '{"typedID":"f_', test_files_list) 

# gsub(".*\\.", "", x)

# we need to drop everything after this and replace with just close bracket
# ],"folder":{"typedID":"d_
test_files_list <- gsub(',"folder"\\:\\{"typedID"\\:"d_.*', "", test_files_list) 


# Remove all \ from the string
#test_files_list <- gsub('\\"', "'", test_files_list) 
#test_files_list <- gsub("'", '"', test_files_list) 

library("rjson")
result <- toJSON(test_files_list)
Writing the JSON object created to a file named "myJSON". We use write() function to do so.


write(test_files_list, "test_files_list.json")
write(test_files_list, "test_files_list.txt")


result <- fromJSON(test_files_list)
json_data_frame <- as.data.frame(result)
library(sf)
result2 <- st_read("test_files_list.json")