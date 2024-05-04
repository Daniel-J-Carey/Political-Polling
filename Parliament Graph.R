library(ggparliament)
library(ggplot2)

# Define the seat allocation data with parties in the desired order
seats <- data.frame(
  party = factor(c("SPBP", "SD", "GP", "LAB", "SF", "FF", "FG", "AU", "OTH_IND")),  # Convert party to factor
  seats = c(3, 4, 6, 5, 27, 16, 20, 3, 16)
)

# Define the party colours in the desired order
party_colours <- c(
  "SPBP" = "#8e2420", 
  "SD" = "#752f8b", 
  "GP" = "#22ac6f", 
  "LAB" = "#cc0000", 
  "SF" = "#326760", 
  "FF" = "#66bb66",
  "FG" = "#6699ff",  
  "AU" = "orange", 
  "OTH_IND" = "darkgrey"
)

# Prepare the data for plotting
parliament_data <- parliament_data(seats, parl_rows = 5, type = "horseshoe")

# Create a plot for parliamentary representation
p <- ggplot(parliament_data, aes(x, y, colour = party, fill = party)) +
  geom_parliament_seats() +
  scale_colour_manual(values = party_colours, guide = FALSE) +  # Disable colour legend
  scale_fill_manual(values = party_colours) +  # Set party fill colours for circles
  labs(title = "Potential Dáil") +  # Updated graph title
  theme_minimal() +  # Use a clean minimal theme
  theme(axis.text = element_blank(),  # Hide axis text
        axis.ticks = element_blank(),  # Hide axis ticks
        panel.grid = element_blank(),  # Hide grid lines
        axis.title.x = element_blank(),  # Hide x-axis title
        axis.title.y = element_blank(),  # Hide y-axis title
        legend.position = "bottom",  # Place legend at the bottom
        legend.title = element_text(size = 12, face = "bold"),  # Customise legend title appearance
        legend.key.size = unit(2, "lines"),  # Increase size of legend keys
        legend.key = element_rect(color = "black", fill = "white", size = 0.5))  # Customise legend keys

# Display the modified plot with a single legend for party colours
p + guides(colour = guide_legend(override.aes = list(fill = party_colours)))  # Override colour legend with custom fill colours
