FROM centos:7

MAINTAINER windawings <windawings@foxmail.com>

# Cloudera ENV
ENV CM_VER=5.14.3 CDH_VER=5.14.2

# Java ENV
ENV JAVA_HOME /usr/java/latest
ENV CLASSPATH=.:$CLASSPTAH:$JAVA_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin

# HADOOP ENV
ENV HADOOP_HOME /usr/lib/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop/conf
ENV HADOOP_COMMON_HOME /usr/lib/hadoop
ENV HADOOP_HDFS_HOME /usr/lib/hadoop-hdfs
ENV HADOOP_YARN_HOME /usr/lib/hadoop-yarn
ENV HADOOP_MAPRED_HOME /usr/lib/hadoop-mapreduce

# Copy & Run ENV Init
COPY config-env.sh config-env.sh
RUN  chmod u+x config-env.sh && bash config-env.sh

EXPOSE 2181 2888 3888

CMD ["/usr/sbin/init"]