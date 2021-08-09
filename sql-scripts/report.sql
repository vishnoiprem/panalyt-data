# panalyt-data-interview
https://morioh.com/p/d8d9e7732952
# Overall Steps:

-- 1. Fork this repository
-- 2. Develop the SQL query to answer the business question.
-- 3. Create a docker image that does the following:
--    A. Starts PostgreSQL/MySQL.
--    B. Initializes table based on the file mounted in /opt/data/.
--    
-- 4. Executing docker run to start the container should run and print out the result of the SQL query stored in /opt/sql/report.sql.
-- 


-- # SQL Task:
-- 
-- Swan.com is a recruitment agency that is interested in figuring out key recruitment seasons for new candidates. 
-- At Swan, any month that has upwards of 1000 applications is considered a successful one. 
-- Furthermore, 
-- if 3 or more consecutive months are successful, they identify these consecutive months as a successful 'season' of applications. 
-- 
-- Recently, you're tasked with finding out all the successful seasons of applications that Swan has had over the last few years. You are provided with their ATS data : applications.csv
-- 
-- The CSV file has the following schema:


-- 
-- CREATE TABLE `applications` (
--   `appliedat` varchar(225) DEFAULT NULL,
--   `jobid` varchar(225) DEFAULT NULL,
--   `status` varchar(225) DEFAULT NULL,
--   `candidateid` varchar(225) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
-- 
-- -- applications
-- -- 
-- -- +------------±-------±----------±-------------±
-- -- | appliedat  | jobid | status   | candidateid |
-- -- +------------±-------±----------±-------------±
-- -- | 2021-01-01 | J001  | ACCEPTED | C001        |
-- -- | 2021-01-04 | J002  | REJECTED | C002        |
-- -- | 2021-01-03 | J003  | PENDING  | C003        |
-- -- 
-- 
-- 



SELECT *
           , period_diff(mon_end_date, lag(mon_end_date) over (order by mon_end_date) ) as mondiff

FROM (select mon
           , count(jobid)                                                                             as no_of_applications
           , row_number() over (ORDER BY MON)                                                         AS RM
,mon_end_date
      from (
               select LAST_DAY(appliedat)                                                      as mon,
                      jobid,
                      candidateid
                      ,date_format(appliedat, '%Y%m') as mon_end_date
                      ,row_number() over (partition by LAST_DAY(appliedat), jobid, candidateid) as rn
               from applications
           ) tmp
      where rn = 1
      group by mon,mon_end_date
      order by mon
     ) F
WHERE no_of_applications > 999
ORDER BY mon_end_date ASC
;

