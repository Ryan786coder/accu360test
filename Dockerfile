FROM debian:9.6-slim

RUN bench setup production frappe

EXPOSE 8000-8005 9000-9005 3306-3307
   
   






