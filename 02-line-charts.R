library(highcharter)

# data line plot
cedeao_countries <-  sf::st_read(dsn = "shapefiles",
                                 layer = "cedeao",quiet =TRUE) %>% 
  pluck("shapeISO")


# timeseries with controls an mean value

cntrl_data <- readxl::read_excel(path = "iso-name-africa.xlsx") %>% 
  janitor::clean_names() %>% 
  gather(-(iso_a3:woe_id),key = "year",value = "itci",convert = TRUE) %>% 
  mutate(itci = as.numeric(as.character(itci))) %>% 
  mutate(itci = round(itci,1), year = gsub(x = year,pattern = "x",replacement = "")) #%>% 
  # mutate(itci_mean = 24.27981804,
  #        cntrl_up = 51.33535347,
  #        cntrl_dwn = -2.775717382)

# line maps
ln_cedeao <- function(){
  
  cntrl_data_cedeao <- filter(cntrl_data,iso_a3 %in% cedeao_countries)
  
  hchart(
    cntrl_data_cedeao,
    type= "spline",
    hcaes(x = year, y = itci,group = name)
  ) %>% 
    hc_xAxis(title = list(text = "Années")) %>% 
    hc_yAxis(title = list(text = "ITCI index")) %>% 
    hc_title(text = "Evolution de l'indice ITCI",align = "left") %>% 
    hc_subtitle(text ="ITCI Afrique | 2012-2021", align = "left") %>% 
    hc_caption(text =" © Data source formmm www.itci.com") %>% 
    hc_colors(colors = ggokabeito::palette_okabe_ito()) %>% 
    hc_credits(enabled = TRUE,text = "www.kacéto.net") #%>% 
    # hc_add_series(data = cntrl_data$itci_mean,name ="moyenne afrique") %>% 
    # hc_add_series(data = cntrl_data$cntrl_up,name = "contrôle supérieur") %>% 
    # hc_add_series(data = cntrl_data$cntrl_dwn,name ="contrôle inférieur")
  
}