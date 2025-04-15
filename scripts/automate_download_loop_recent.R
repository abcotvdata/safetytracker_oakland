# Load required packages
library(rvest)
library(tidyverse)
library(stringr)

# Get a list of files in the directory
dir_path <- "data/source/recent"
files <- list.files(dir_path, full.names = TRUE)
# Delete all files in the directory
file.remove(files)

# Function to extract file information from a URL
extract_files_info <- function(url) {
  webpage <- read_html(url)
  files_list <- webpage %>% html_elements(".is-loading") %>% html_text2()
  
  # Extract file IDs
  extracted_file <- str_extract_all(files_list, "\\{\\\"typedID\\\":\\\"f_.{14}")
  extracted_file <- unlist(extracted_file) %>% as.data.frame %>% rename("file_id" = ".")
  extracted_file$file_id <- substr(extracted_file$file_id, 15, 27)
  
  # Extract file names
  extracted_name <- str_extract_all(files_list, ",\"extension\":\"pdf\",\"name\":\".{75}")
  extracted_name <- unlist(extracted_name) %>% as.data.frame %>% rename("file_name" = ".")
  extracted_name$file_name <- substr(extracted_name$file_name, 28, 102)
  extracted_name$file_name <- gsub("pdf.*", "pdf", extracted_name$file_name)
  
  # Combine and filter
  files <- cbind(extracted_file, extracted_name)
  files <- files[str_detect(files$file_name, "Weekly Crime Report"), ]
  
  return(files)
}

# List of URLs
urls <- c(
  "https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct",
  "https://cityofoakland2.app.box.com/s/2gmg1912khb9t6nhalhl1rg6gscn4y86",
  "https://cityofoakland2.app.box.com/s/xfa5h508r77eysje2etevwio80e1o0gk",
  "https://cityofoakland2.app.box.com/s/x81lhgwlpsj7o8gn4iiw9oujhpfjgql9",
  "https://cityofoakland2.app.box.com/s/ih1xz8vyo7btuhu8fb5qhy4wzbapy1t8",
  "https://cityofoakland2.app.box.com/s/yfpjz8dw2zoum7cxoml0h908b6xme8ah",
  "https://cityofoakland2.app.box.com/s/sjiq7usfy27gy9dfe51hp8arz5l1ixad/folder/153744258933"
)

# Extract files information for each URL
files_list <- lapply(urls, extract_files_info)

# List of URLs that are the base for the download url in network traffic after pressing download button
baseurls <- c(
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=xqloqg6rpaljxz6h0cajle6skmoea5ct&file_id=f_",
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=2gmg1912khb9t6nhalhl1rg6gscn4y86&file_id=f_",
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=xfa5h508r77eysje2etevwio80e1o0gk&file_id=f_",
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=x81lhgwlpsj7o8gn4iiw9oujhpfjgql9&file_id=f_",
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=ih1xz8vyo7btuhu8fb5qhy4wzbapy1t8&file_id=f_",
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=yfpjz8dw2zoum7cxoml0h908b6xme8ah&file_id=f_",
  "https://cityofoakland2.app.box.com/index.php?rm=box_download_shared_file&shared_name=sjiq7usfy27gy9dfe51hp8arz5l1ixad&file_id=f_"
)

# Download files with the same name as they are named online
download.file(paste0(baseurls[1],files_list[[1]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[1]][["file_name"]][[1]]))
download.file(paste0(baseurls[2],files_list[[2]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[2]][["file_name"]][[1]]))
download.file(paste0(baseurls[3],files_list[[3]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[3]][["file_name"]][[1]]))
download.file(paste0(baseurls[4],files_list[[4]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[4]][["file_name"]][[1]]))
download.file(paste0(baseurls[5],files_list[[5]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[5]][["file_name"]][[1]]))
download.file(paste0(baseurls[6],files_list[[6]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[6]][["file_name"]][[1]]))
download.file(paste0(baseurls[7],files_list[[7]][["file_id"]][[1]]),paste0("data/source/recent/",files_list[[7]][["file_name"]][[1]]))

