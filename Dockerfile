FROM alpine

MAINTAINER Vitty
ENV http_proxy http://10.1.1.10:8080
ENV https_proxy http://10.1.1.10:8080

RUN mkdir -p /run/nginx
RUN mkdir -p /usr/share/nginx/html
RUN apk add --update
RUN apk add php7 php7-fpm php7-opcache \
             php7-gd php7-mysqli php7-zlib php7-curl \
			 php7-mbstring php7-gd nginx supervisor \
			 php7-json \
			 openssh \
			 git \
			 nano \
			 grep \
			 sed \
			 curl \
			 wget \ 
                         bash
# apk search php7 | grep -i gd

COPY ./start.ini /etc/supervisor.d/
COPY ./www.conf /etc/php-fpm.d/www.conf
COPY ./php.ini /etc/php.ini
COPY ./nginx.conf /etc/nginx/
RUN rm /etc/nginx/conf.d/default.conf
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf

EXPOSE 80
WORKDIR /usr/share/nginx
 
CMD [ "supervisord"]

