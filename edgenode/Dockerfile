FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#copy test data and script
COPY cities.* /

#copy flume conf and start scripts
COPY flume/start_flume.sh /
COPY flume/flume_httpd.conf /usr/lib/apache-flume-1.6.0-bin/conf/

#install pig, hive, flume and scoop 
RUN yum -y install pig hive flume-ng sqoop2 spark-worker && \
         yum clean all && rm -rf /var/cache/yum/* && \
         chmod +x /start_flume.sh

#setup supervisor
ADD supervisord.conf /etc/supervisor/conf.d/

#start the supervisor
CMD ["supervisord", "-n"]