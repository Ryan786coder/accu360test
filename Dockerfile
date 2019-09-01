FROM ubuntu
RUN sudo apt update && sudo apt install libffi-dev python-pip python-dev libssl-dev wkhtmltopdf curl git && sudo curl --silent --location https://deb.nodesource.com/setup_8.x | sudo bash -
RUN sudo apt-get install gcc g++ make && sudo apt-get install -y nodejs redis-server && sudo npm install -g yarn
RUN sudo apt install nginx
RUN sudo systemctl stop nginx.service
RUN sudo systemctl start nginx.service
RUN sudo systemctl enable nginx.service
RUN sudo apt-get install mariadb-server mariadb-client
RUN sudo systemctl stop mariadb.service
RUN sudo systemctl start mariadb.service
RUN sudo systemctl enable mariadb.service
RUN sudo mysql_secure_installation
RUN sudo mysql -u root -p 
RUN CREATE DATABASE erpnext;
RUN CREATE USER 'erpnextuser'@'localhost' IDENTIFIED BY '1234';
RUN GRANT ALL ON erpnext.* TO 'erpnextuser'@'localhost' IDENTIFIED BY '1234' WITH GRANT OPTION;
RUN FLUSH PRIVILEGES;
RUN EXIT;
RUN sudo useradd -m -s /bin/bash erpnextuser
RUN sudo passwd erpnextuser
RUN sudo usermod -aG sudo erpnextuser
RUN sudo mkdir -p /opt/erpnext
RUN sudo chown -R erpnextuser /opt/erpnext/
RUN su - erpnextuser
RUN cd /opt/erpnext
RUN git clone https://github.com/frappe/bench bench-repo
RUN sudo pip install -e bench-repo
RUN bench init erpnext && cd erpnext
RUN bench new-site example.com
RUN bench start

EXPOSE 80









