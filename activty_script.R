# Set-up ------------------------------------------------------

# Load the Gapminder dataset.
# It contains country-level data on population, GDP per capita,
# life expectancy, continent, and year.
library(gapminder)

# Load the tidyverse.
# You will use it mainly for data cleaning with pipes (%>%),
# filter(), and mutate().
library(tidyverse)

# Open the help file for the Gapminder dataset.
# Use this to inspect the variables before deciding what to model.
?gapminder 


# Prepare the working dataset -------------------------------

# Keep only one year so that we are comparing countries
# at the same point in time.

# Create logged GDP per capita.
# GDP per capita is highly skewed, so logging it usually makes
# the relationship easier to model and interpret.

df <- gapminder %>% 
  filter(year == 2002) %>% 
  mutate(
    log_gdp = log(gdpPercap)
  )

# From here, your group needs to decide:

# what outcome to explain,
# what interaction to test,
# what mechanism could justify it,
# and how to interpret the result.

# ----------------------------