library(tidyverse)
library(magrittr)

path = "data/"

data <- tibble(files = list.files(path, pattern = "*.csv"))

data

data %<>% 
  mutate(data = map(paste0(path,files), read_delim, delim = ";", skip = 1))

data

data %>% 
  unnest()

data %>% 
  unnest() %>% 
  ggplot(aes(x = nm, y = A)) +
  geom_line()

data %>% 
  unnest() %>% 
  filter(nm > 400) %>% 
  ggplot(aes(x = nm, y = A, color = files)) +
  geom_line() +
  labs(x = "Wavelength (nm)", "Absorption (a.u.)", color = "Sample") +
  facet_wrap(~files, scales = "free")

data %>% 
  unnest() %>% 
  mutate(region = ifelse(nm > 400, "Visible", "UV")) %>% 
  ggplot(aes(x = nm, y = A, color = files)) +
  geom_line() +
  labs(x = "Wavelength (nm)", "Absorption (a.u.)", color = "Sample") +
  facet_wrap(~region, ncol = 2, scales = "free")

ggsave("UVVis_example.png", width = 17.5, height = 6, units = "cm", dpi = 600)
