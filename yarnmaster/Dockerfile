FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#setup supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#expose ressourcemanager port
EXPOSE 8032 8080

#start the supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
