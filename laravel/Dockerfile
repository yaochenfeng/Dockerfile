FROM richarvey/nginx-php-fpm:latest
MAINTAINER yaochenfeng <282696845@qq.com>


ENV WEBROOT=/var/www/html/public;
WORKDIR /app/code

RUN echo http://mirrors.aliyun.com/alpine/v3.6/main > /etc/apk/repositories; \
 apk add --update --no-cache git curl ;

COPY nginx.vh.default.conf /etc/nginx/sites-available/default.conf
ADD index.php /var/www/html/public/index.php
EXPOSE 443 80

CMD ["/start.sh"]
