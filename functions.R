library(sf)
library(tidyverse)
library(highcharter)
library(geojsonsf)

# itci data
itci_data <- readxl::read_excel(path = "iso-name-africa.xlsx") %>% 
  janitor::clean_names() %>% 
  gather(-(iso_a3:woe_id),key = "year",value = "itci",convert = TRUE) %>% 
  mutate(itci = na_if(x = itci,y = "NA")) %>% 
  mutate(itci=as.numeric(itci)) %>% 
  select(iso_a3,name,year,itci) %>% 
  mutate(year = gsub(pattern = "x",replacement = "",year),year=as.numeric(year))

options(highcharter.download_map_data = TRUE)


cedeao <- st_read(dsn = "./dashboard-r/shapefiles",layer = "cedeao")

cedeao <- rjson::toJSON(cedeao)
highchart(type = "map")
clcla
list(cedeao)
