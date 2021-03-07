#!/bin/sh
set -e


# set internal field separator to split commands
IFS=';'
DJANGO_MANAGEMENT_JOB_ARRAY=(${DJANGO_MANAGEMENT_JOB})
DJANGO_MANAGEMENT_ON_START_ARRAY=(${DJANGO_MANAGEMENT_ON_START})
unset IFS

# install requirements.txt

# if [ -z "$SKIP_INSTALL" ]; then
#     echo "starting install)"
#         # Try auto install for composer
#     if [ -f "/usr/django/app/requirements.txt" ]; then
#         pip install --no-cache-dir -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
#     fi
    
# fi

executeManagementCommands() {
    COMMAND_ARRAY=("$@")
    for COMMAND in "${COMMAND_ARRAY[@]}"; do
        echo "executing python manage.py ${COMMAND}"
        python manage.py ${COMMAND}
    done
}

# run django management commands without starting gunicorn afterwards
if [ ${#DJANGO_MANAGEMENT_JOB_ARRAY[@]} -ne 0 ]; then
    executeManagementCommands "${DJANGO_MANAGEMENT_JOB_ARRAY[@]}"
    exit 0
fi

# run django management commands before starting gunicorn
if [ ${#DJANGO_MANAGEMENT_ON_START_ARRAY[@]} -ne 0 ]; then
    executeManagementCommands "${DJANGO_MANAGEMENT_ON_START_ARRAY[@]}"
fi

if [ -z "$PROJECT" ]; then
        # Try auto install for composer
    DJANGO_APP="website"
    django-admin startproject ${PROJECT} /usr/django/app
    sed -i "28 c\ALLOWED_HOSTS = ['*']" /usr/django/app/${PROJECT}/settings.py
    
fi
# 添加权限
if [ -z "$SKIP_DOCKER_WRITE" ]; then
    chmod 777 -R /usr/django/app
    cd /usr/django/app
fi
# start gunicorn
echo "starting gunicorn (PORT=${PORT}, RELOAD=${GUNICORN_RELOAD:-false}, APP=${PROJECT})"
if [ "$GUNICORN_RELOAD" == "true" ]; then
    gunicorn -c /etc/gunicorn/gunicorn.conf --bind 0.0.0.0:${PORT} --reload ${PROJECT}.wsgi
else
    gunicorn -c /etc/gunicorn/gunicorn.conf --bind 0.0.0.0:${PORT} ${PROJECT}.wsgi
fi
