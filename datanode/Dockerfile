FROM windawings/cloudera-cdh:latest

MAINTAINER windawings<windawings@foxmail.com>

#init datanode directory
RUN mkdir -p /hdfs/data

#supervisor config
ADD supervisord.conf /etc/supervisor/conf.d/

#expose port
EXPOSE 50020 50075 8042

#start the supervisor
CMD ["supervisord", "-n"]
