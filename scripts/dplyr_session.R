## Learning dplyr

rm(list=ls())

library(dplyr)
library(ggplot2)

gapminder <- read.csv("data/gapminder_data.csv")
str(gapminder)

# using select function to pick certain columns
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)
str(year_country_gdp)  

# using filter function to pick certain rows
year_country_gdp_euro <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(year,country,gdpPercap)
str(year_country_gdp_euro)

# using dplyr for grouping variables
gdp_by_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdp = mean(gdpPercap))
gdp_by_continent

# Calculate the average life expectancy per country. 
lifeExp_byCountry <- gapminder %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp))
str(lifeExp_byCountry)

# Which has the longest average life expectancy and which has the shortest average life expectancy?
max(lifeExp_byCountry$mean_lifeExp) # still don't know which country

lifeExp_byCountry %>% filter(mean_lifeExp == max(mean_lifeExp) | 
                               mean_lifeExp == min(mean_lifeExp))

## integrating ggplot and dplyr
gapminder %>% 
  group_by(country,year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x=year,y=mean_lifeExp)) + geom_point()
