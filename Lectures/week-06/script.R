library(sf)
library(tidyverse)
library(here)

# Load Boston housing data
boston <- read_csv(here("data/boston.csv"))

# Quick look at the data
glimpse(boston)

# Simple model: Predict price from living area
baseline_model <- lm(SalePrice ~ LivingArea, data = boston)
summary(baseline_model)

#Add number of bathrooms
better_model <- lm(SalePrice ~ LivingArea + R_FULL_BTH, data = boston)
summary(better_model)

# Compare models
cat("Baseline R²:", summary(baseline_model)$r.squared, "\n")
cat("With bathrooms R²:", summary(better_model)$r.squared, "\n")

# Convert boston data to sf object
boston.sf <- boston %>%
  st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326) %>%
  st_transform('ESRI:102286')  # MA State Plane (feet)

# Check it worked
head(boston.sf)

class(boston.sf)  # Should show "sf" and "data.frame"
