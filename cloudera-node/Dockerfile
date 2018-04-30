FROM centos:7

MAINTAINER windawings <windawings@foxmail.com>

# Cloudera ENV
ENV CM_VER=5.14.2 CDH_VER=5.14.2

# Java ENV
ENV JAVA_HOME /usr/java/latest
ENV CLASSPATH=.:$CLASSPTAH:$JAVA_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin

# Create Init Dir
RUN mkdir -p /cloudera-init/run

# Copy Shell
COPY cloudera-init/* /cloudera-init/run/

# Run Shell
RUN  chmod +x /cloudera-init/run/* && bash /cloudera-init/run/config-env.sh

# Expose Ports
EXPOSE 4434 7182 7191 9000 19001

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]