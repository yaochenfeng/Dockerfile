FROM python:3.7
MAINTAINER yaochenfeng <282696845@qq.com>

# set default port for gunicorn
ENV PORT=8000 \
    TZ=Asia/Shanghai \
    GUNICORN_VERSION=19.9.0 \
    PROJECT=website

# create user which will be used to run gunicorn
# install gunicorn, django
RUN mkdir -p /var/www/static \
    && mkdir -p /usr/django/app \
	&&mkdir -p /etc/gunicorn \
	&&groupadd -r django \
	&& useradd --no-log-init -r -g django django 

RUN pip install --upgrade pip --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ mysqlclient gunicorn django

# add gunicorn config
COPY gunicorn.conf /etc/gunicorn/
COPY start.sh /usr/django/
WORKDIR /usr/django/app
ONBUILD COPY requirements.txt /usr/django/
ONBUILD RUN pip install --upgrade pip --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ -r /usr/django/requirements.txt
ONBUILD COPY . /usr/django/app

EXPOSE $PORT
CMD bash /usr/django/start.sh