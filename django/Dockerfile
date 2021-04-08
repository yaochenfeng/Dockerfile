FROM python:3.7-alpine
MAINTAINER yaochenfeng <282696845@qq.com>
ENV PORT=8000 \
    TZ=Asia/Shanghai \
    PROJECT=website \
    DEBUG=false
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
    apk update  && apk add --no-cache mariadb-dev tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && mkdir -p /usr/django/app \
	&& mkdir -p /etc/gunicorn \
	&& addgroup -S django \
	&& adduser -D -S -h /usr/django/app -s /sbin/nologin -G django django  \
	&& pip install --upgrade pip --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ gunicorn django \
    && apk del tzdata

# FROM python:3.7-slim
# MAINTAINER yaochenfeng <282696845@qq.com>

# ENV PORT=8000 \
#     TZ=Asia/Shanghai \
#     GUNICORN_VERSION=19.9.0 \
#     PROJECT=website

# RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list &&\
# 	apt-get clean && apt-get update &&\
# 	apt-get -y install gcc default-libmysqlclient-dev &&\
# 	mkdir -p /var/www/static \
#     && mkdir -p /usr/django/app \
# 	&&mkdir -p /etc/gunicorn \
# 	&&groupadd -r django \
# 	&& useradd --no-log-init -r -g django django  &&\
# 	pip install --upgrade pip --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ mysqlclient gunicorn django

WORKDIR /usr/django/app
COPY gunicorn.conf /etc/gunicorn/
COPY start.sh /usr/django/

EXPOSE 8000
CMD bash /usr/django/start.sh