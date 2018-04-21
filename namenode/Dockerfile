FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#install and run namenode
RUN yum -y install hadoop-hdfs-namenode && yum clean all && rm -rf /var/cache/yum/* && \
         mkdir -p /hdfs/nm && \
         hdfs namenode -format

#supervisor config
ADD supervisord.conf /etc/supervisor/conf.d/

#expose namenode port
EXPOSE 8020

#start the supervisor
CMD ["supervisord", "-n"]
