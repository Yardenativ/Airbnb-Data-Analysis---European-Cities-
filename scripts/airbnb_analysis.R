# Airbnb Data Analysis
library(RColorBrewer)
library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(viridis)
#all this packages need to be installed before using this code
#upload the data base as df

#1- Price distribution for each city
ggplot(df, aes(x=log(Price), color = City))+geom_density()+facet_wrap(~City) +
  labs(
    title = "Price Per Night",
    x = "Price",
    y = "Density"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2") 


#2- Bootstrap by weekend and weekday
#2.1- Weekday price
weekday_prices <- df %>%
  filter(Day == "Weekday") %>%
  na.omit() %>%
  group_by(City) %>%
  summarize(avg_price = mean(Price)) %>%
  pull(avg_price)

mean_value_weekday <- mean(weekday_prices)
N_weekday <- length(weekday_prices)
B <- 2000
means_weekday <- vector("numeric", length = B)

set.seed(2024)
for (b in seq_len(B)) {
  Prices_boot <- sample(weekday_prices, size = N_weekday, replace = TRUE)
  means_weekday[b] <- mean(Prices_boot)
}
percentile_weekday <- quantile(means_weekday, probs = c(0.05, 0.95))

#2.2- Weekend price
weekend_prices <- df %>%
  filter(Day == "Weekend") %>%
  na.omit() %>%
  group_by(City) %>%
  summarize(avg_price = mean(Price)) %>%
  pull(avg_price)

mean_value_weekend <- mean(weekend_prices)
N_weekend <- length(weekend_prices)
means_weekend <- vector("numeric", length = B)
set.seed(2024)
for (b in seq_len(B)) {
  Prices_boot <- sample(weekend_prices, size = N_weekend, replace = TRUE)
  means_weekend[b] <- mean(Prices_boot)
}
percentile_weekend <- quantile(means_weekend, probs = c(0.05, 0.95))

#2.3- Weekday + Weekend 
result_table <- data.frame(
  Category = c("Weekday", "Weekend"),
  Mean = c(mean_value_weekday, mean_value_weekend),
  lower_percentile = c(percentile_weekday[1], percentile_weekend[1]),
  upper_percentile = c(percentile_weekday[2], percentile_weekend[2])
)
print(result_table)

#2.4- average price per night by day of the week
avg_per_night <- df %>% 
 na.omit() %>%
  group_by(City, Day) %>% 
  summarize(avg_price = mean(Price))

ggplot(avg_per_night, aes(x = Day, y = avg_price, color = City)) +
  geom_jitter(width = 0.2, height = 0, size = 3) +
  scale_color_viridis(discrete = TRUE, option = "C") +
  labs(
    title = "Average Price Per Night by City and Day",
    x = "Day of the Week",
    y = "Average Price (in EUR)",
    color = "City"
  ) +
  theme_minimal()


#3- Number of Airbnb listings per city
City_count <- df %>%
  group_by(City) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

ggplot(City_count, aes(x = reorder(City, -count), y = count, fill = count)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  theme_minimal() +
  labs(title = "Number of Airbnb Listings per City", x = "", y = "") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        plot.title = element_text(size = 16, face = "bold")) +
  guides(fill = FALSE)

#3.1- Calculate Pearson correlation
airbnb_listings <- data.frame(
  City = c("Rome", "Paris", "Lisbon", "Athens", "Budapest", "Vienna", "Barcelona", "Berlin", "Amsterdam"),
  Airbnb_Listings = c(9027, 6688, 5763, 5280, 4022, 3537, 2833, 2484, 2080)
)
city_info <- data.frame(
  City = c("Rome", "Paris", "Lisbon", "Athens", "Budapest", "Vienna", "Barcelona", "Berlin", "Amsterdam"),
  Area_km2 = c(1285, 105, 100, 39, 525, 415, 101, 891, 219)
)
combined_data <- merge(airbnb_listings, city_info, by = "City")
print(combined_data)
cor_matrix <- cor(combined_data[, c("Airbnb_Listings", "Area_km2")])
print(cor_matrix)

#3.2- Regression graph
ggplot(combined_data, aes(x = Area_km2, y = Airbnb_Listings, label = City)) +
  geom_point(aes(color = City), size = 5, shape = 16) +  
  geom_smooth(method = "lm", se = FALSE, color = "black") + 
  geom_text(vjust = -0.9, hjust = 0.5, size = 5, fontface = "bold", color = "black") +  
  labs(x = "City Size (Km²)", y = "Number of Airbnb Listings", 
       title = "City Size vs. Number of Airbnb Listings") +
  theme_minimal(base_size = 15) + 
  scale_color_brewer(palette = "Set3") +  
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 22), 
    axis.title.x = element_text(face = "bold", size = 18),
    axis.title.y = element_text(face = "bold", size = 18),
    legend.position = "none"
  )


#4- Available Airbnb listings for each person capacity 
person_capacity_df <- df %>% 
  group_by(Person.Capacity, City) %>%
  summarise(properties = n(), .groups = 'drop')

ggplot(person_capacity_df, aes(x = Person.Capacity, y = properties, fill = City)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Person Capacity by City",
       x = "Person Capacity",
       y = "Number of Properties",
       fill = "City") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3") +
  theme(
    plot.title = element_text(size = 18),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
  )

#4.1- Getting an Exact Number for properties with a capacity of 2
properties_with_capacity_2 <- person_capacity_df %>% 
  filter(Person.Capacity == 2)
total_properties_capacity_2 <- properties_with_capacity_2 %>%
  summarise(total_properties = sum(properties))
print(total_properties_capacity_2)


#5- Guest satisfaction by room type
room_type_rating <- df %>% 
  na.omit() %>% 
  group_by(City, Room.Type) %>% 
  summarise(Cleanliness_rating = mean(Cleanliness.Rating), guest_satisfaction = mean(Guest.Satisfaction)/10) %>% 
  mutate(
  combined_data = ((Cleanliness_rating + guest_satisfaction) / 2) 
)
 ggplot(room_type_rating, aes(x = Room.Type, y = combined_data, fill = Room.Type)) +
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "black", fill = "black") +
  labs(title = " Total Guest Satisfaction by Room Type",
       x = "Room Type",
       y = "Total Guest Satisfaction") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3") +
  theme(
     plot.title = element_text(size = 20),
     axis.title.x = element_text(size = 16),
     axis.title.y = element_text(size = 16),
     axis.text.x = element_text(size = 14),
     axis.text.y = element_text(size = 14),
     legend.title = element_text(size = 14),
     legend.text = element_text(size = 12)
   )
 
#5.1- Table shown the average total guest satisfaction by room type
total_guest_satisfaction_by_room <- room_type_rating %>%
   group_by(Room.Type) %>%
   summarise(avg_rating = mean(combined_data, na.rm = TRUE)) %>%
   arrange(desc(avg_rating))
print(total_guest_satisfaction_by_room)
 
#5.2- Table shown the median of the total guest satisfaction by room type
guest_Satisfaction_by_room_type_median <- room_type_rating %>%
   group_by(Room.Type) %>%
   summarise(median_guest_satisfaction = median(combined_data, na.rm = TRUE)) %>%
   arrange(desc(median_guest_satisfaction))
 print(guest_Satisfaction_by_room_type_median)
