# Airbnb Price and Availability Analysis in European Cities
## Overview
This project explores Airbnb listings across major European cities with the goal of helping travelers
identify cost-effective and suitable accommodation options based on price, availability, group size, and guest satisfaction.

The analysis focuses on understanding price distributions, weekday vs. weekend pricing,
listing availability, and how guest satisfaction varies by room type.

## Cities Included
- Amsterdam  
- Athens  
- Barcelona  
- Berlin  
- Budapest  
- Lisbon  
- Paris  
- Rome  
- Vienna  

## Research Questions
- How are Airbnb prices distributed across different European cities?
- Are weekend prices significantly higher than weekday prices?
- Is there a relationship between city size and the number of available Airbnb listings?
- How does listing availability vary by group size?
- How does guest satisfaction differ by room type?

## Data
The dataset was obtained from **Kaggle** and contains Airbnb listing information, including:
- Nightly prices
- City and location
- Room type
- Guest satisfaction and cleanliness ratings
- Capacity (number of guests)
- Weekday vs. weekend classification

## Methods
The analysis includes:
- Exploratory Data Analysis (EDA)
- Log-transformed price distributions
- Bootstrap confidence intervals for average prices
- Pearson correlation analysis
- Data visualization (density plots, bar charts, boxplots)

## Key Findings
- Amsterdam is the most expensive city, while Athens and Budapest are the most affordable.
- Weekend prices are slightly higher than weekday prices, but the difference is generally small.
- City size shows only a weak correlation with the number of Airbnb listings.
- Most available listings are suitable for 2 guests; larger groups have fewer options.
- Entire apartments receive the highest guest satisfaction ratings, followed by private rooms.

## Tools and Technologies
- R
- ggplot2
- dplyr
- tidyr
- Bootstrap resampling

## Authors
- **Yarden Nativ**  
- **Nave Lehavy**

## Academic Context
This project was completed as part of a Data Science course at Ben-Gurion University of the Negev.

