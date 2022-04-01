library(rnaturalearth)
library(readxl)
library(janitor)

afr <- ne_countries(
  scale = 10,
  type = "sovereignty", 
  continent = "Africa",
  returnclass = "sf"
)

# Data read in part

itci_data <- read_excel("iso-name-africa.xlsx", 
                        col_types = c("text", "text", "text", 
                                      "text", "text", "numeric", "text", 
                                      "text", "text", "numeric", "text", 
                                      "text", "numeric", "numeric", "numeric", 
                                      "numeric", "numeric", "numeric", 
                                      "numeric", "numeric", "numeric", 
                                      "numeric", "numeric", "numeric"), 
                        na = "NA")%>% 
  clean_names() %>% 
  left_join(afr,.,"iso_a3") %>% 
  select(featurecla:geometry,x2012:x2021) %>% 
  pivot_longer(cols = starts_with("x"),
               names_to = "year",
               values_to = "itci",
               names_prefix = "x"
               )

  
