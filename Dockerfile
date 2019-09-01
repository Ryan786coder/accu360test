FROM ubuntu
RUN apt update 
RUN apt install libffi-dev python-pip python-dev libssl-dev wkhtmltopdf curl git 
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | sudo bash -
RUN apt-get install gcc g++ make 
RUN apt-get install -y nodejs redis-server 
RUN npm install -g yarn
RUN apt install nginx
RUN systemctl stop nginx.service
RUN systemctl start nginx.service
RUN systemctl enable nginx.service
RUN apt-get install mariadb-server mariadb-client
RUN systemctl stop mariadb.service
RUN systemctl start mariadb.service
RUN systemctl enable mariadb.service
RUN mysql_secure_installation
RUN mysql -u root -p 
RUN CREATE DATABASE erpnext;
RUN CREATE USER 'erpnextuser'@'localhost' IDENTIFIED BY '1234';
RUN GRANT ALL ON erpnext.* TO 'erpnextuser'@'localhost' IDENTIFIED BY '1234' WITH GRANT OPTION;
RUN FLUSH PRIVILEGES;
RUN EXIT;
RUN useradd -m -s /bin/bash erpnextuser
RUN passwd erpnextuser
RUN usermod -aG sudo erpnextuser
RUN mkdir -p /opt/erpnext
RUN chown -R erpnextuser /opt/erpnext/
RUN su - erpnextuser
RUN cd /opt/erpnext
RUN git clone https://github.com/frappe/bench bench-repo
RUN pip install -e bench-repo
RUN bench init erpnext && cd erpnext
RUN bench new-site example.com
RUN bench start

EXPOSE 80









