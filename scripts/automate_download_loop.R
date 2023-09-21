# Load required packages
library(rvest)
library(tidyverse)
library(stringr)
library(RSelenium)

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
  "https://cityofoakland2.app.box.com/s/yfpjz8dw2zoum7cxoml0h908b6xme8ah"
)

# Extract files information for each URL
files_list <- lapply(urls, extract_files_info)

# Set the download directory
download_dir <- file.path(getwd(), "data/source/recent/")

# Create a custom Firefox profile
fprof <- makeFirefoxProfile(list(
  "browser.download.dir" = download_dir,
  "browser.download.folderList" = 2L,
  "browser.helperApps.neverAsk.saveToDisk" = "application/pdf", # MIME type of file to download
  "pdfjs.disabled" = TRUE
))

# Start the RSelenium driver with the custom profile
rD <- rsDriver(browser = "firefox", port = 99L, verbose = F, extraCapabilities = fprof)
remDr <- rD[["client"]]

# Download files from each URL
for (i in 1:length(urls)) {
  url <- urls[i]
  file_info <- files_list[[i]]
  if (nrow(file_info) > 0) {
    download_url <- paste0(url, "/file/", file_info[1, "file_id"])
    remDr$navigate(download_url)
    Sys.sleep(5) # Wait for page to load
    btn <- remDr$findElement('xpath', '//*[@id="app"]/div[5]/span/div/span/div/header/div[2]/button[2]')
    btn$clickElement()
    Sys.sleep(5) # Wait for download
  }
}

# Stop the RSelenium driver
rD$server$stop()
