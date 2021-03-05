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
	&& useradd --no-log-init -r -g django django 

RUN pip install --upgrade pip --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ mysqlclient gunicorn==$GUNICORN_VERSION django==${DJANGO_VERSION}

# add gunicorn config
COPY gunicorn.conf /etc/gunicorn/

# run start.sh on container start
COPY start.sh /usr/django/
WORKDIR /usr/django/app

ONBUILD COPY . /usr/django/app
ONBUILD RUN if test -e requirements.txt; then \
			pip install --upgrade pip --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt; \
		fi

EXPOSE $PORT
CMD bash /usr/django/start.sh