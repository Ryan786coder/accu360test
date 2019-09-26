FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt -y install libffi-dev python-pip python-dev libssl-dev wkhtmltopdf curl git 
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y install gcc g++ make
RUN apt-get install -y nodejs redis-server
RUN npm install -g yarn
RUN apt install -y nginx


RUN apt-get install -y mariadb-server mariadb-client


COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start \
   && mysql --user="root" --execute="CREATE DATABASE erpnext;" \
   && mysql --user="root" --execute="CREATE USER 'erpnextuser'@'localhost' IDENTIFIED BY '1234';" \
   && mysql --user="root" --execute="GRANT ALL ON erpnext.* TO 'erpnextuser'@'localhost' IDENTIFIED BY '1234' WITH GRANT OPTION;" \
   && mysql --user="root" --execute="FLUSH PRIVILEGES;" \
   && mysql --user="root" --execute="\q;"
   



RUN useradd -m -s /bin/bash erpnextuser -p 1234
#RUN passwd erpnextuser
RUN usermod -aG sudo erpnextuser
RUN mkdir -p /opt/erpnext
#RUN chown -R erpnextuser /opt/erpnext/
RUN chown -R 777 /opt/erpnext
RUN su - erpnextuser 
RUN cd /opt/erpnext
RUN git clone https://github.com/frappe/bench bench-repo
RUN pip install -e bench-repo
RUN bench init erpnext  \
  && cd erpnext
RUN bench new-site example.com 
RUN bench start 

EXPOSE 8000-8005 9000-9005 3306-3307
   
   






