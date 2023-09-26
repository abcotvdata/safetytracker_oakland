# Load packages
library(rvest)
library(webshot)

# URL to scrape
url <- "https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct/file/1310170470248"

# Read HTML content
page <- read_html(url)

# Extract target div 
div <- html_node(page, "div#target-div")

# Render just the div content as a webshot
webshot(
  url = "div.html", 
  vwidth = 800, vheight = 600,
  javascript = "document.body.innerHTML = '<html>' + document.getElementById('target-div').innerHTML + '</html>'"
)

# Save screenshot as PDF
webshot("div.pdf", file = "div.pdf", cliprect = "viewport")