FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#copy test data and script
COPY cities.* /

#copy flume conf and start scripts
COPY flume/start_flume.sh /

#install pig, hive, flume and scoop 
RUN yum -y install pig hive flume-ng sqoop2 spark-worker && \
         yum clean all && rm -rf /var/cache/yum/* && \
         chmod u+x /start_flume.sh

#setup supervisor
ADD supervisord.conf /etc/supervisor/supervisord.conf

#start the supervisor
CMD ["supervisord", "-n"]