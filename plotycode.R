library(tidyverse)
library(plotly)
library(sf)
library(rnaturalearth)
library(tmap)
library(readxl)


# itci data preparation 

itci_data <- readxl::read_excel(path = "iso-name-africa.xlsx") %>% 
  janitor::clean_names() %>% 
  gather(-(iso_a3:woe_id),key = "year",value = "itci",convert = TRUE) %>% 
  rename(shapeGroup = iso_a3,shapeName = name) %>% 
  mutate(itci = na_if(x = itci,y = "NA")) %>% 
  mutate(itci=as.numeric(itci)) %>% 
  select(shapeGroup,shapeName,year,itci) %>% 
  mutate(year = gsub(pattern = "x",replacement = "",year),year=as.numeric(year))

#tmap options

tmap_mode(mode = "view")

tmap_options(check.and.fix = TRUE)

# cedeao map function

tm_cedeao <- function(year=NULL){
  if (is.null(year)) year <- lubridate::year(Sys.Date())-1
  cedeao <- sf::st_read(dsn = "shapefiles",layer = "cedeao",quiet =TRUE)
  cedeao <- left_join(cedeao,itci_data,"shapeGroup")
  cedeao %>% 
    filter(year == 2021) %>% 
  tm_shape() +
  tm_polygons("itci", 
              style="pretty", 
              title="Indice\nITCI")+
  tm_layout(main.title = "Indice ITCI sur la zone CEDEAO - 2021")
}

# icpac map function

tm_igad <- function(year=NULL){

  if (is.null(year)) year <- lubridate::year(Sys.Date())-1
  igad <- sf::st_read(dsn = "shapefiles",layer = "IGAD",quiet =TRUE) %>% 
    rename(shapeName = COUNTRYAFF)
  igad <- left_join(igad,itci_data,"shapeName")
  igad %>% 
    filter(year == 2021) %>% 
    tm_shape() +
    tm_polygons("itci", 
                title =" ITCI",
                style="pretty", 
                title="Indice\nITCI",)+
    tm_layout(aes.palette = viridis::cividis(10))
   
}
