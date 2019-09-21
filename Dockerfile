FROM debian:9.6-slim
RUN apt-get -y update
RUN apt -y install libffi-dev python-pip python-dev libssl-dev wkhtmltopdf curl git 
RUN mkdir -p /opt/erpnext
RUN cd /opt/erpnext
RUN git clone https://github.com/frappe/bench bench-repo
RUN pip install -e bench-repo
RUN bench setup production frappe

EXPOSE 8000-8005 9000-9005 3306-3307
   
   






