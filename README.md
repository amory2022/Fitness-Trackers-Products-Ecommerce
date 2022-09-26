# Fitness-Trackers-Products-Ecommerce
We applied the stages of data analysis to the fitness tracker product dataset.

In this project, we analyzed the fitness tracker product dataset and asked and 
answered questions in a structured and detailed manner. The dataset contains
different products of different brands with their specifications, ratings and 
reviews for the Indian market.

# In the first step we did We asked the following questions
--Determine which is more popular (desired) smart watch or fitness bracelet?
--What is the customer's most favorite brand for both fitness watch and bracelet producers?
--Determine the relationship between product specifications and customer evaluation?

# And in the second step then we downloaded the data from Kaggle
https://www.kaggle.com/datasets/devsubhash/fitness-trackers-products-ecommerce/code?select=Fitness_trackers_updated.csv

We did data exploration to understand the structure and type of data and descriptive statistics of the data.
We also explored the names and number of columns and rows of data.

# The third step cleaning Data
We first check the column names and modify them
We checked for duplicates
And then we discovered that we found the number of hours more than the number of bracelets, this leads to bias in the sample
The data contains 529 watches, while the data contains 77 smart bracelets.
Therefore, we delete part of the watch data so that its number is equal to the number of bracelets
Then we checked the missing values
Then we create new data and we replace the missing values with zero
Then we delete the columns we don't need in the analysis

# The fourth step is to analyze the data
As we mentioned earlier, the aim of the project is to answer the following questions:
-Determine which is more popular (desired) smart watch or fitness bracelet?
To answer the question, we will use descriptive analysis to analyze users' desire, which devices do they prefer watches or bracelets.
We use the ratings and reviews numbers to know which smartwatch or bracelet is best for.
Then we represented the results in a graph

-What is the customer's most favorite brand for both fitness watch and bracelet producers?
We'll start with descriptive data analytics
First, let's see the names of the companies in the data set
Then, we will calculate the number of devices for each brand
Then we calculated the total ratings that each brand got
Then we represented the rating data of the top 5 evaluating companies in a graph

-Determine the relationship between product specifications and customer evaluation?
We analyzed the correlation between specifications by comparing the classification and some specifications by creating a graph
We compare the color - the life of the battery - and the selling price compared to the classifications
First, we compared the colors and classifications, and we see which colors got the highest rating
We created a new data set to put the colors with the highest rating in order
Then we represent it in a graph

After that we compare the battery life and rating and see the relationship between them

Then we determined the relationship between selling price and customer rating

# The fifth step is to interpret the results
Then we interpreted the results of the analysis by answering the questions asked











