FROM python:3.7
MAINTAINER yaochenfeng <282696845@qq.com>

# set default port for gunicorn
ENV PORT=8000 \
    TZ=Asia/Shanghai \
    GUNICORN_VERSION=19.9.0 \
    DJANGO_VERSION=2.2.2

# create user which will be used to run gunicorn
# install gunicorn, django
RUN mkdir -p /var/www/static \
    && mkdir -p /usr/django/app \
	&&mkdir -p /etc/gunicorn \
	&&groupadd -r django \
	&& useradd --no-log-init -r -g django django \
	&&pip install --no-cache-dir gunicorn==$GUNICORN_VERSION \
	&&pip install --no-cache-dir django==$DJANGO_VERSION \
	&&pip install --no-cache-dir mysqlclient


# add gunicorn config
COPY gunicorn.conf /etc/gunicorn/

# run start.sh on container start
COPY start.sh /usr/django/
WORKDIR /usr/django/app

EXPOSE $PORT
CMD bash /usr/django/start.sh

