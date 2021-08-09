# Derived from official mysql image (our base image)
FROM mysql
# Add a database
ENV MYSQL_DATABASE company
# Add the content of the sql-scripts/ directory to your image
# All scripts in /opt/data/ are automatically
# executed during container startup
COPY ./sql-scripts/ /opt/data/

