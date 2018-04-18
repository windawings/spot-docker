FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#init namenode directory
RUN mkdir -p /hdfs/nm

#install the namenode stuff
RUN yum -y install hadoop-hdfs-namenode && rm -rf /var/cache/yum/*

#format the namenode
RUN hdfs namenode -format

#setup supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#expose namenode port
EXPOSE 8020

#define HDFS volume to enable to persist namenode fsimage between restart
VOLUME /hdfs

#start the supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
