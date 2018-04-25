FROM windawings/centos7:latest

MAINTAINER windawings <windawings@foxmail.com>

# Cloudera ENV
ENV CM_VER=5.14.2 CDH_VER=5.14.2

# Java ENV
ENV JAVA_HOME /usr/java/latest
ENV CLASSPATH=.:$CLASSPTAH:$JAVA_HOME/lib
ENV PATH=$PATH:$JAVA_HOME/bin

# Copy Shell
COPY config-env.sh config-env.sh
COPY supervisord.service /usr/lib/systemd/system/supervisord.service

# Run Shell
RUN  chmod u+x config-env.sh && bash config-env.sh

# Expose Ports
EXPOSE 7180 7182 9000 19001

# Config Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]