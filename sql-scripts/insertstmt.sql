SET @@GLOBAL.`local_infile` := 1;
LOAD DATA LOCAL INFILE '../applications.csv' 
INTO TABLE applications 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
;