FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

# Copy & Run ENV Init
RUN yum -y install hadoop-hdfs-namenode && yum clean all && rm -rf /var/cache/yum/*

# make dir
RUN  mkdir -p /hdfs/nm

# init hadoop
RUN hdfs namenode -format

#supervisor config
ADD supervisord.conf /etc/supervisor/supervisord.conf

#expose namenode port
EXPOSE 8020

#start the supervisor
CMD ["supervisord", "-n"]
