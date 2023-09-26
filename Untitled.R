library(rvest)
library(httr)

# Define the URL of the web page
url <- "https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct/file/1310170470248"

# Send an HTTP GET request to the URL
response <- GET(url)

# Check if the request was successful (status code 200)
if (http_status(response)$status == 200) {
  # Parse the HTML content of the page
  page <- read_html(content(response, "text"))
  
  # Extract the URL of the PDF file in the bottom left frame
  pdf_url <- page %>%
    html_element(xpath = '//*[@id="file_actions"]/ul/li[2]/a') %>%
    html_attr("href")
  
  # Download the PDF file
  pdf_filename <- "captured_pdf.pdf"
  GET(pdf_url, write_disk(pdf_filename))
  
  cat("PDF file downloaded successfully.")
} else {
  cat("Failed to retrieve the web page.")
}
