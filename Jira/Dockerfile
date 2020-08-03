FROM atlassian/jira-software:8.0
# set default port for gunicorn
ENV TZ=Asia/Shanghai
USER root
# 将代理破解包加入容器
COPY "atlassian-agent.jar" /opt/atlassian/jira/
COPY "mysql-connector-java-8.0.21.jar" /opt/atlassian/jira/lib/
# 设置启动加载代理包
RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/jira/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/jira/bin/setenv.sh
