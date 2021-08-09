# panalyt-data-interview

# Overall Steps:

1. Fork this repository
2. Develop the SQL query to answer the business question.
3. Create a docker image that does the following:
   A. Starts PostgreSQL/MySQL.
   B. Initializes table based on the file mounted in `/opt/data/`.
   
4. Executing `docker run` to start the container should run and print out the result of the SQL query stored in `/opt/sql/report.sql`.



# SQL Task:

Swan.com is a recruitment agency that is interested in figuring out key recruitment seasons for new candidates. At Swan, any month that has upwards of 1000 applications is considered a successful one. Furthermore, if 3 or more consecutive months are successful, they identify these consecutive months as a successful 'season' of applications. 

Recently, you're tasked with finding out all the successful seasons of applications that Swan has had over the last few years. You are provided with their ATS data : applications.csv

The CSV file has the following schema:



```
applications

+------------±-------±----------±-------------±
| appliedAt  | jobId | status   | candidateId |
+------------±-------±----------±-------------±
| 2021-01-01 | J001  | ACCEPTED | C001        |
| 2021-01-04 | J002  | REJECTED | C002        |
| 2021-01-03 | J003  | PENDING  | C003        |
```

Write a SQL query that provides the following output:


```
result

+------------±-------------±
| month      | applications|
+------------±-------------±
| 2021-01-31 | 1500        |
| 2021-02-28 | 2000        |
| 2021-03-31 | 4000        |
| 2021-06-30 | 2500        |
| 2021-07-31 | 3000        |
| 2021-08-31 | 4950        | 
| 2021-09-30 | 1000        |
+-----------±--------------±
```
This result should contain all their successful seasons ordered by month where each successful season consists of at least 3 or more consecutive months when the total number of applications per job per candidate is at least 1000. In the example above we have two seasons.
