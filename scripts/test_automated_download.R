# load required packages
library(rvest)
library(xml2)
library(XML)



# download the webpage
# Load the webpage
webpage <- read_html("https://cityofoakland2.app.box.com/s/xqloqg6rpaljxz6h0cajle6skmoea5ct")

html <- webpage %>% 
  html_node(xpath = '//*[@id="contextmenutarget344"]')

