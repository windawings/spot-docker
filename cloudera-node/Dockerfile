FROM centos:7

MAINTAINER windawings <windawings@foxmail.com>

# Cloudera ENV
ENV CM_VER=5.14.2 CDH_VER=5.14.2

# Java ENV
ENV JAVA_HOME /usr/java/latest
ENV CLASSPATH=.:$CLASSPTAH:$JAVA_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin

# Create Init Dir
RUN mkdir /cloudera-init

# Copy Shell
COPY cloudera-init/* /cloudera-init/

# Copy Supervisor Service
COPY supervisord.service /lib/systemd/system/supervisord.service

# Run Shell
RUN  chmod +x /cloudera-init/* && bash /cloudera-init/config-env.sh

# Expose Ports
EXPOSE 7180 7182 9000 19001

# Config Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]