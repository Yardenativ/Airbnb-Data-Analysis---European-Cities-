# Airbnb Price and Availability Analysis in Major European Cities

## Introduction

In recent years, the tourism industry has experienced a continuous rise in hotel and Airbnb prices, making it increasingly difficult for travelers to find accommodation that fits both their expectations and budget constraints. According to data from the European Travel Commission, the summer of 2024 is expected to surpass pre-2019 tourism levels across Europe, leading to increased demand, higher prices, and stronger competition for flights and short-term rentals.

The goal of this project is to assist Airbnb users in finding accommodation that matches their budget and preferences by providing a data-driven comparison across popular European destinations.

We focus on nine major European cities: **Amsterdam, Athens, Barcelona, Berlin, Budapest, Lisbon, Paris, Rome, and Vienna**. The analysis examines differences in accommodation prices, availability, guest satisfaction, and suitability for different group sizes.

---

## Data and Methods

The analysis is based on an Airbnb dataset obtained from **Kaggle**. The dataset includes information on listing prices, city, room type, guest satisfaction ratings, cleanliness ratings, availability, capacity (number of guests), and whether the stay is during a weekday or weekend.

The following methods were used:

* Exploratory Data Analysis (EDA)
* Log transformation of prices to improve distributional interpretability
* Bootstrap resampling to estimate confidence intervals for average prices
* Pearson correlation analysis
* Data visualization using density plots, bar charts, and boxplots

---

## Results

### Price Distribution Across Cities

To examine how nightly prices are distributed in each city, we used density plots based on the logarithm of prices. The log transformation helped reduce skewness and made cross-city comparisons clearer.

Budapest and Athens show tightly concentrated price distributions, indicating relatively low price variability. The most common nightly prices are approximately **€150** in Budapest and **€120** in Athens. In contrast, Amsterdam and Barcelona display wider distributions with multiple peaks, reflecting greater price variability. Amsterdam shows the highest overall price range, with common prices reaching **€400–€660** per night.

![Price Distribution](../figures/density_price_cities.jpg)

---

### Average Price: Weekday vs. Weekend

We estimated the average nightly price for weekdays and weekends using bootstrap resampling to assess uncertainty. The results indicate that weekend prices (€285 on average) are slightly higher than weekday prices (€275 on average). However, the confidence intervals overlap substantially, suggesting that the difference is not statistically significant.

When analyzed by city, most cities show only minor price differences between weekdays and weekends. Amsterdam is an exception, with noticeably higher weekday prices, while Athens shows virtually no difference.

![Weekday vs Weekend](figures/avg_price_weekday_weekend.jpg)

---

### Availability of Listings by City Size

We examined whether city size (in square kilometers) is associated with the number of available Airbnb listings. Pearson correlation analysis revealed a **weak positive correlation (r ≈ 0.33)**, indicating that city size alone does not strongly predict listing availability.

For example, Rome has both the largest area and the highest number of listings, while Paris—despite its relatively small size—has a high number of listings. This suggests that factors such as tourism demand and local regulations play a more important role than geographic size.

![Availability of Listings by City Size](figures/Num_of_units_available.jpg)
![Correlation between the City size to Number of Listings](figures/city_size_availability_pearson.jpg)

---

### Availability by Group Size

Most Airbnb listings across the sampled cities are suitable for **two guests**, making them ideal for couples or solo travelers. Listings suitable for larger groups (5–6 guests) are less common, especially in cities such as Amsterdam. Rome stands out as a destination with relatively high availability for larger groups.

![Availability by Group Size](figures/availability_by_beds.jpg)

---

### Guest Satisfaction by Room Type

We created a combined guest satisfaction score by averaging cleanliness ratings and normalized guest satisfaction scores. Entire apartments receive the highest average satisfaction ratings, followed closely by private rooms. Shared rooms show lower and more variable satisfaction levels, likely due to reduced privacy and comfort.

![Guest Satisfaction by Room Type](figures/guest_satisfaction_room_type.jpg)
---

## Discussion

This project addressed several practical questions relevant to Airbnb users. We found substantial differences in price levels between cities, with Amsterdam being the most expensive and Athens and Budapest the most affordable. Weekend pricing tends to be slightly higher, but the effect is generally small.

Contrary to expectations, city size does not strongly determine listing availability. Instead, tourism popularity and regulatory constraints appear to play a larger role. Guest satisfaction is highest for entire apartments, highlighting the value of privacy and space in short-term rentals.

---

## Conclusion

By integrating price analysis, availability metrics, and guest satisfaction data, this project provides practical insights for travelers seeking Airbnb accommodations in Europe. The findings support more informed decision-making and highlight the importance of considering multiple factors beyond price alone.

---

## Authors

* **Yarden Nativ**
* **Nave Lehavy**

## Academic Context

This project was completed as part of a Data Science course at **Ben-Gurion University of the Negev**.
