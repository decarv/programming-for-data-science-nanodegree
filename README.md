# udacity-projects

This is a personal repository for Udacity Programming For Data Science projects.

## 1st-project

### Overview

This project consisted in the exploration of a provided database movie rentals. The student had to run SQL queries and build visualizations to showcase the output of the student's queries. For the presentation component, the student had to create four slides, and each should have (a) a question of interest, (b) a supporting SQL query needed to answer the question, (c) a supporting visualization created using the final data of the SQL queries that answer the questions of interest, and (d) a small summary on each slide.

### Project Submission

You can download the Project Submission [here](https://drive.google.com/open?id=1sfcOviwrgdNjnhghi6N4IOobMzDNGz4w).

Question 1: How do the rentals for the 10 top renting countries compare to the other countries for each category? 
* [Query](https://github.com/decarvalhohenrique/programming-for-data-science-nanodegree/blob/master/1st-project/1st-presentation-query.sql).

Question 2: How are the movies distributed by the amount of times they were rented inside of a category? 
* [Query](https://github.com/decarvalhohenrique/programming-for-data-science-nanodegree/blob/master/1st-project/2nd-presentation-query.sql).

Question 3: How much did the top 10 paying customers spend on DVD rental over 2007? 
* [Query](https://github.com/decarvalhohenrique/programming-for-data-science-nanodegree/blob/master/1st-project/3rd-presentation-query.sql).

Question 4: How many customers have paid less in rentals compared to the previous month? 
* [Query](https://github.com/decarvalhohenrique/programming-for-data-science-nanodegree/blob/master/1st-project/4th-presentation-query.sql).

### Question Sets

A set of questions have also been provided by Udacity so that we were free to consider and include them in our Project Submission. These were solely provided for our convenience, and we were able to choose between any of the questions in these sets or none at all in your project submission.Despite having not used any of the questions provided by Udacity, I still chose to query each [question](https://github.com/decarvalhohenrique/programming-for-data-science-nanodegree/tree/master/1st-project/set-questions).


## 2nd-project

### Overview

In this project, the student had to make use of Python to explore data related to bike share systems for three major cities in the United States — Chicago, New York City, and Washington. The student had to write code to (a) import the data and answer interesting questions about it by computing descriptive statistics, and (b) write a script that takes in raw input to create an interactive experience in the terminal to present these statistics.

### Project Submission

The developed CLI program allows the user to explore an US bikeshare system database and retrieve statistics information from the database. The user is able filter the information by city, month and weekday, in order to visualize statistics information related to a specific subset of data. The user is also able to chose to view raw data and to sort this data by columns, in ascending or descending order.

[Project Submission](https://github.com/decarvalhohenrique/programming-for-data-science-nanodegree/blob/master/2nd-project/bikeshare.py).

#### Files Used

The required filed for running this program are: 

* washington.csv
* new_york_city.csv
* chicago.csv

You can download them [here](https://drive.google.com/open?id=1sfcOviwrgdNjnhghi6N4IOobMzDNGz4w).

#### Requirements

This program was written in Python (version 3.7.1) and relies on the following libraries:

pandas==0.23.4
numpy==1.15.4
Click==7.0
