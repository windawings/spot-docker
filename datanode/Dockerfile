FROM windawings/cloudera-cdh:latest

MAINTAINER windawings<windawings@foxmail.com>

#init datanode directory
RUN mkdir -p /hdfs/data

#setup supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#expose port
EXPOSE 50020 50075 8042

#define HDFS volume to enable to persist datanode data (hdfs files) between restart
VOLUME /hdfs

#start the supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
