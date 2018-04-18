FROM windawings/cloudera-cdh:latest

MAINTAINER windawings <windawings@foxmail.com>

#install pig, hive, flume and scoop 
RUN yum -y install pig hive flume-ng sqoop2 spark-worker && rm -rf /var/cache/yum/*

#copy test data and script
COPY cities.* /

#copy flume conf and start scripts
COPY flume/* /
RUN chmod +x /start_flume.sh

#setup supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#create a staging disk to send/get data to/from the cluster
RUN mkdir /staging

VOLUME /staging

#start the supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]