FROM centos:7

MAINTAINER windawings <windawings@foxmail.com>

# Java ENV
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Cloudera ENV
ENV CM_VER=5.14.2 CDH_VER=5.14.2

#set HADOOP_* environement variables
ENV HADOOP_HOME /usr/lib/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop/conf
ENV HADOOP_COMMON_HOME /usr/lib/hadoop
ENV HADOOP_HDFS_HOME /usr/lib/hadoop-hdfs
ENV HADOOP_YARN_HOME /usr/lib/hadoop-yarn
ENV HADOOP_MAPRED_HOME /usr/lib/hadoop-mapreduce

#Install jdk isn't in the base repo
#Install hadoop so that the derived images will not be too fat
RUN wget http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo && mv cloudera-cdh5.repo /etc/yum.repos.d && \
         wget http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo && mv cloudera-manager.repo /etc/yum.repos.d && \
        sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VER\/"/ /etc/yum.repos.d/cloudera-cdh5.repo && \
        sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VER\/"/ /etc/yum.repos.d/cloudera-manager.repo && \
        yum makecache && yum -y update && yum -y upgrade && \
        yum -y install java-1.8.0-openjdk-devel hadoop zookeeper wget python-pip ntp && yum clean all && rm -rf /var/cache/yum/* && \
        pip install --upgrade pip && pip install supervisor && \
        mkdir -p /etc/supervisor/conf.d/ && mkdir /cloudera_init && mkdir -p /hdfs/tmp && \
        ntpdate us.pool.ntp.org

EXPOSE 2181 2888 3888

CMD ["hadoop", "version"]