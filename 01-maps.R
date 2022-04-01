# subregion map function

tm_subregion_map <- function(year=NULL,subregion ="Western Africa"){
  
  if (is.null(year)) year <- lubridate::year(Sys.Date())-1
  pop.vars = c("Population"  ="pop_est", "ITCI "="itci")
  itci_data %>% 
    filter(year == !!year,subregion.x == !!subregion) %>% 
  tm_shape() +
  tm_polygons("itci", 
              style="pretty", 
              title="Indice\nITCI",
              id="name_fr",
              popup.vars=c("Population"="pop_est", "ITCI "="itci"),
              popup.format=list(itci=list(digits=2)))
}

