FROM debian:bullseye

RUN apt-get update -y && apt-get  upgrade -y

RUN apt install nginx -y

RUN mkdir -p /etc/nginx/ssl && mkdir -p /var/run/nginx

RUN apt install vim -y && apt install curl -y && apt install openssl -y

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=ES/ST=IDF/L=Malaga/O=42/OU=42/CN=ezhou.42.fr/UID=ezhou"

COPY conf/default /etc/nginx/sites-available/default

RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]