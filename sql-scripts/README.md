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



--step -1 start docker


vishnoiprem:panalyt-data vishnoiprem$ docker build -t my-mysql .
Sending build context to Docker daemon  5.222MB
Step 1/3 : FROM mysql
latest: Pulling from library/mysql
33847f680f63: Pull complete 
5cb67864e624: Pull complete 
1a2b594783f5: Pull complete 
b30e406dd925: Pull complete 
48901e306e4c: Pull complete 
603d2b7147fd: Pull complete 
802aa684c1c4: Pull complete 
715d3c143a06: Pull complete 
6978e1b7a511: Pull complete 
f0d78b0ac1be: Pull complete 
35a94d251ed1: Pull complete 
36f75719b1a9: Pull complete 
Digest: sha256:8b928a5117cf5c2238c7a09cd28c2e801ac98f91c3f8203a8938ae51f14700fd
Status: Downloaded newer image for mysql:latest
 ---> c60d96bd2b77
Step 2/3 : ENV MYSQL_DATABASE company
 ---> Running in 59c0e6d77c54
Removing intermediate container 59c0e6d77c54
 ---> 05097d7f14ae
Step 3/3 : COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
 ---> 621052686f9d
Successfully built 621052686f9d
Successfully tagged my-mysql:latest
vishnoiprem:panalyt-data vishnoiprem$ 


--2.And start your MySQL container from the image:

 docker run -d -p 3306:3306 --name my-mysql \
-e MYSQL_ROOT_PASSWORD=supersecret my-mysql



step. 3

docker exec -it my-mysql bash

vishnoiprem:panalyt-data vishnoiprem$ 
vishnoiprem:panalyt-data vishnoiprem$ docker exec -it my-mysql bash
root@395c1e60aab4:/# mysql -uroot -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.26 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective




step: 4

docker run -d -p 3306:3306 --name my-mysql \
-v ~/sql-scripts:/opt/data/ \
-e MYSQL_ROOT_PASSWORD=supersecret \
-e MYSQL_DATABASE=company \
mysql

