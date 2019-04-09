# udacity-projects

This is a personal repository for Udacity Programming For Data Science projects.

## 1st-project

### Overview

In this project, the student had to use SQL to explore a database related to movie rentals. We had to write SQL code to run SQL queries and answer interesting questions about the provided database. 

As part of the Project Submission, the student had to run SQL queries and build visualizations to showcase the output of the student's queries.

The Project Submission is a presentation, which will be reviewed, and for which you will need to meet the criteria as specified in the Rubric to pass. For the presentation component, the student had to create four slides. Each slide should have (a) a question of interest, (b) a supporting SQL query needed to answer the question, (c) a supporting visualization created using the final data of the SQL queries that answer the questions of interest, and (d) a small summary on each slide. Go to Project Submission.

### Question Sets

A set of questions have been provided by Udacity so that we were free to consider and include them in our Project Submission. These were solely provided for our convenience, and we were able to choose between any of the questions in these sets or none at all in your project submission.

Despite having not used any of the questions provided by Udacity, I still chose to query each question as shown below.

#### Question Set 1

Question 1: We want to understand more about the movies that families are watching. The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music. Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out. Solution.

Question 2: Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into. Solution.

Question 3: Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category. The resulting table should have three columns: Category, Rental length category and Count. Solution.

#### Question Set 2

Question 1: We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month. Solution.

Question 2: We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007, and what was the amount of the monthly payments. Can you write a query to capture the customer name, month and year of payment, and total payment amount for each month by these top 10 paying customers? Solution.

Question 3: Finally, for each of these top 10 paying customers, I would like to find out the difference across their monthly payments during 2007. Please go ahead and write a query to compare the payment amounts in each successive month. Repeat this for each of these 10 paying customers. Also, it will be tremendously helpful if you can identify the customer name who paid the most difference in terms of payments. Solution.

### Chosen Questions

Question 1: How do the rentals for the 10 top renting countries compare to the other countries for each category? Solution.

Question 2: How are the movies distributed by the amount of times they were rented inside of a category? Solution.

Question 3: How much did the top 10 paying customers spend on DVD rental over 2007? Solution.

Question 4: How many customers have paid less in rentals compared to the previous month? Solution.

### Project Submission

You can find the project submission here.

## 2nd-project

### Overview

In this project, the student had to make use of Python to explore data related to bike share systems for three major cities in the United States — Chicago, New York City, and Washington. The student had to write code to (a) import the data and answer interesting questions about it by computing descriptive statistics, and (b) write a script that takes in raw input to create an interactive experience in the terminal to present these statistics.

### Project Submission

The developed CLI program allows the user to explore an US bikeshare system database and retrieve statistics information from the database. The user is able filter the information by city, month and weekday, in order to visualize statistics information related to a specific subset of data. The user is also able to chose to view raw data and to sort this data by columns, in ascending or descending order.

Project Submission.

#### Files Used

The required filed for running this program are: 

* washington.csv
* new_york_city.csv
* chicago.csv

You can download them here.

#### Requirements

This program was written in Python (version 3.7.1) and relies on the following libraries:

pandas==0.23.4
numpy==1.15.4
Click==7.0
