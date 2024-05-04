# Load necessary libraries
library(dplyr)
library(tidyr)
library(ggplot2)

# Read the data
data <- read.csv("C:/Users/danie/OneDrive/Documents/SB5001 Assignment/data_pollingindicator.csv")

# Filter data for 2024
data <- data %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y")) %>%
  filter(format(date, "%Y") == "2024")

# Select columns excluding '_hi' and '_lo' and those with no data
selected_data <- data %>%
  select(-contains("_hi"), -contains("_lo")) %>%
  select_if(~any(!is.na(.))) %>%
  select(-cycle)  # Exclude the 'cycle' column

# Change date format to DD/MM/YYYY
selected_data$date <- as.Date(selected_data$date, format = "%m/%d/%Y")

# Melt the data for easier plotting
melted_data <- selected_data %>%
  pivot_longer(cols = -date, names_to = "Political Party", values_to = "Popularity")

# Multiply Popularity by 100 to convert to percentages
melted_data$Popularity <- melted_data$Popularity * 100

# Plot using ggplot2
ggplot(melted_data, aes(x = date, y = Popularity, colour = `Political Party`, group = `Political Party`)) +
  geom_line(size = 1.5) +
  labs(title = "Popularity of Political Parties in 2024",
       x = "Date",
       y = "Popularity (%)",
       colour = "Political Party") +
  scale_colour_manual(values = c("FF" = "#66bb66", "FG" = "#6699ff", "LAB" = "#cc0000", 
                                 "PD" = "#581845", "WP" = "#355C7D", "OTH" = "darkgrey", 
                                 "GP" = "#22ac6f", "DL" = "#8c7ae6", "SF" = "#326760", 
                                 "SD" = "#752f8b", "SPBP" = "#8e2420", "AU" = "orange")) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "#eaecf0"),
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        legend.position = "bottom") +
  scale_x_date(date_breaks = "1 week", date_labels = "%d/%m/%Y")