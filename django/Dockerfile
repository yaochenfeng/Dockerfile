FROM python:3.7
MAINTAINER yaochenfeng <282696845@qq.com>

# create user which will be used to run gunicorn
RUN mkdir -p /var/www/static \
    && mkdir -p /usr/django/app \
	&&mkdir -p /etc/gunicorn \
	&&groupadd -r django \
	&& useradd --no-log-init -r -g django django


VOLUME /var/www/static
# VOLUME /usr/django/app



# set default port for gunicorn
ENV PORT=8000

# add gunicorn config
COPY gunicorn.conf /etc/gunicorn/

# run start.sh on container start
COPY start.sh /usr/django/
WORKDIR /usr/django/app

EXPOSE $PORT
CMD bash /usr/django/start.sh

# install gunicorn, django and pytz
ENV GUNICORN_VERSION=19.9.0
ENV DJANGO_VERSION=2.0.7
ENV PYTZ_VERSION=2018.5
RUN pip install gunicorn==$GUNICORN_VERSION
RUN pip install django==$DJANGO_VERSION
RUN pip install pytz==$PYTZ_VERSION
