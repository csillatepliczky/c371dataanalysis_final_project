# c371dataanalysis Final Poject

1. Project Description

This is my final project about data transformation, data cleaning, data analysis and visualization. I used a PostegreSQL relational database about DVD rentals, which contains information about movies, actors, customers of a theoretical DVD rental company, rentals, payments and the different stores and staff of the company in 15 tables. I created a new database for the cleaned data in PgAdmin 4, cleaned and explored the dataset using the Psycopg2 connector for PostgreSQL with Pandas and visualized the data in Power BI.

2. Data cleaning

The original database contained 15 tables with some redundant data which I didn't plan to use in my analysis. So as the first step I created new tables in the create tables.sql file for the cleaned data, and I also created a trigger for the amount column of the payment table. This trigger activates before each insertion and if a negative value is to be inserted, it sets the value to 0, ensuring that no negative value can be inserted to this column. I also omitted two tables from the original dataset (tables containing store and staff information) and also some columns from the tables (mostly foreign keys referring to the omitted tables and a last_update column 
from each table containing only a timestamp of the last update).

In the clean_data.ipynb file I established a connection to both the old and the new database using the onnectToDatabase class, then I loaded all the tables one by one into a dataframe. I created a CleanData class which contains four functions to clean the data:
- one for removing the white spaces from the values
- one to replace NaN values from the numerical columns
- one that creates a full_name column from a first_name and last_name columns if the dataframe has first_name and last_name columns
- one that creates year, month and day columns from a date column that can be specified in the arguments
I ran the cleaning functions on all the dataframes and loaded them into the cleaned database after that.

3. Data Exploration

For the exploratory analysis of the dataset I created five dataframes in Pandas (in the dvdrental_exploratory_analysis.ipynb file) by joining different tables together: 
-	one containing information about the films and film categories
-	one containing information about rentals, payment amount and customers
-	one containing customer details
-	one containing information about the actors and which movies they were in
-	one about the rental and inventory information
For the exploration of these dataframes and for the general descriptive analysis of the data I used Pandas built-in methods, like: df.shape, df.head(), df.info(),df.isnull().sum(), df.describe(), df.nunique(), df.unique(). I also used groupby(), sort_values(), count() and value_counts() to get the distribution and value count of the different columns. I also created pivot tables with the df.pivot_table()
 method the gain deeper insight into the dataset (for example getting the number of active and inactive customers per country).


