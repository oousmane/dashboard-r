# Plotting for a particular year
itci_data <- readxl::read_excel(path = "iso-name-africa.xlsx") %>% 
  janitor::clean_names() %>% 
  gather(-(iso_a3:woe_id),key = "year",value = "itci",convert = TRUE) %>% 
  mutate(itci = as.numeric(as.character(itci))) %>% 
  mutate(itci = round(itci,1)) %>% 
  filter(year == "x2021")


hcmap(
     map = "custom/africa", data =itci_data,
    joinBy = "name", value = "itci", name = "ITCI"
  ) %>% 
  hc_colorAxis(
    stops = color_stops(colors = viridisLite::turbo(10, begin = 0.1))
  ) %>% 
  hc_credits(
    enabled = TRUE,
    text = "© Ousmane Sawadogo, Analyste Kacéto",
    href = "http://blogdsar.netlify.app"
  ) %>% 
  hc_title(
    text = "This is a title with <i>margin</i> and <b>Strong or bold text</b>",
    margin = 20,
    align = "center"
  ) %>% 
  hc_caption(text = "This is a caption text to show the style of this type of text") %>% 
  hc_subtitle(text = "this is subtitle") %>% 
  hc_add_theme(hc_thm = hc_theme_smpl()) 

# time series plot, for a particular country or country

  
data_bf <- readxl::read_excel(path = "iso-name-africa.xlsx") %>% 
  janitor::clean_names() %>% 
  gather(-(iso_a3:woe_id),key = "year",value = "itci",convert = TRUE) %>% 
  mutate(itci = as.numeric(as.character(itci))) %>% 
  mutate(itci = round(itci,1), year = gsub(x = year,pattern = "x",replacement = "")) %>% 
  filter(name %in% c( "Burkina Faso","Mali","Niger"))

hchart(
  data_bf,
  type= "spline",
  hcaes(x = year, y = itci,group = name,)
  ) %>% 
  hc_xAxis(title = list(text = "Années")) %>% 
  hc_yAxis(title = list(text = "ITCI index")) %>% 
  hc_title(text = "Evolution de l'indice ITCI",align = "left") %>% 
  hc_subtitle(text ="ITCI Afrique | 2012-2021", align = "left") %>% 
  hc_caption(text =" © Data source formmm www.itci.com") %>% 
  hc_colors(colors = ggokabeito::palette_okabe_ito()) %>% 
  hc_credits(enabled = TRUE,text = "www.kacéto.net")
  
# timeseries with controls an mean value

cntrl_data <- readxl::read_excel(path = "iso-name-africa.xlsx") %>% 
  janitor::clean_names() %>% 
  gather(-(iso_a3:woe_id),key = "year",value = "itci",convert = TRUE) %>% 
  mutate(itci = as.numeric(as.character(itci))) %>% 
  mutate(itci = round(itci,1), year = gsub(x = year,pattern = "x",replacement = "")) %>% 
  mutate(itci_mean = 24.27981804,
         cntrl_up = 51.33535347,
         cntrl_dwn = -2.775717382)

hchart(
  cntrl_data,
  type= "spline",
  hcaes(x = year, y = itci,group = name)
) %>% 
  hc_xAxis(title = list(text = "Années")) %>% 
  hc_yAxis(title = list(text = "ITCI index")) %>% 
  hc_title(text = "Evolution de l'indice ITCI",align = "left") %>% 
  hc_subtitle(text ="ITCI Afrique | 2012-2021", align = "left") %>% 
  hc_caption(text =" © Data source formmm www.itci.com") %>% 
  hc_colors(colors = ggokabeito::palette_okabe_ito()) %>% 
  hc_credits(enabled = TRUE,text = "www.kacéto.net") %>% 
  hc_add_series(data = cntrl_data$itci_mean,name ="moyenne afrique") %>% 
  hc_add_series(data = cntrl_data$cntrl_up,name = "contrôle supérieur") %>% 
  hc_add_series(data = cntrl_data$cntrl_dwn,name ="contrôle inférieur")


library(crosstalk)
cntrl_data$year <- as.numeric(cntrl_data$year)
shared_mtcars = SharedData$new(cntrl_data)
filter_checkbox("Pays", "Pays", shared_mtcars, ~name, inline = FALSE,columns = 2)
filter_slider("id","slide A",step = 1,shared_mtcars,~year,"100%")
filter_slider("mag", "Magnitude", 
              shared_mtcars, 
              column=~year, 
              step=1, width=250,min = 2012,max = 2021,sep = NULL)
hchart(
  shared_mtcars,
  type= "spline",
  hcaes(x = year, y = itci,group = name)
)
checkboxGroupInput(inputId = "in1",choices = cntrl_data$name,label = cnt)
