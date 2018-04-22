FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#supervisor config
ADD supervisord.conf /etc/supervisor/supervisord.conf

#expose ressourcemanager port
EXPOSE 8032 8080

#start the supervisor
CMD ["supervisord", "-n"]
