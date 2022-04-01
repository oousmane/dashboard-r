
hc_subregion_lnp <- function(subregion ="Western Africa"){
  
  subregion.fr <- case_when( subregion == "Western Africa" ~ "Afrique de l'Ouest",
                             subregion == "Northern Africa" ~ "Afrique du Nord",
                             subregion == "Southern Africa" ~ "Afrique Australe",
                             subregion == "Eastern Africa" ~ "Afrique de l'Est",
                             TRUE~"Afrique Centrale"
                             )
  
  
  itci_data %>% 
    filter(subregion.x == !!subregion) %>% 
    hchart(
    type= "spline",
    hcaes(x = year, y = round(itci,2),group = name_fr)) %>%
    hc_xAxis(title = list(text = "Années")) %>% 
    hc_yAxis(title = list(text = "Indice ITCI")) %>% 
    hc_title(text = "<b>Evolution dans le temps de l'indice ITCI<b>",align = "left") %>% 
    hc_subtitle(text =paste0(subregion.fr," | 2012-2021"), align = "left") %>% 
   # hc_caption(text =" © Data source formmm www.itci.com") %>% 
    hc_colors(colors = ggokabeito::palette_okabe_ito())# %>% 
    #hc_credits(enabled = TRUE,text = "www.kacéto.net") #%>% 
    # hc_add_series(data = cntrl_data$itci_mean,name ="moyenne afrique") %>% 
    # hc_add_series(data = cntrl_data$cntrl_up,name = "contrôle supérieur") %>% 
    # hc_add_series(data = cntrl_data$cntrl_dwn,name ="contrôle inférieur")
  
}


