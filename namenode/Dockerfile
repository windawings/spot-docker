FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

# Copy & Run ENV Init
ADD config-env.sh /
RUN  chmod u+x config-env.sh && bash config-env.sh

#supervisor config
ADD supervisord.conf /etc/supervisor/conf.d/

#expose namenode port
EXPOSE 8020

#start the supervisor
CMD ["supervisord", "-n"]
