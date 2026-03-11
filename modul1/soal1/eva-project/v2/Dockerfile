FROM ubuntu:latest

RUN apt update && apt install -y nginx

WORKDIR /var/www/html
RUN rm -rf /var/www/html/*

COPY index.html .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]