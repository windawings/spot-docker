FROM windawings/cloudera-node:latest

MAINTAINER windawings <windawings@foxmail.com>

# Copy Shell
COPY config-env.sh config-env.sh
COPY mysql.sql /etc/supervisor/mysql.sql
COPY start.sh /etc/supervisor/start.sh

# Run Shell
RUN  chmod u+x config-env.sh /etc/supervisor/start.sh && bash config-env.sh

# Expose Ports
EXPOSE 7180 7182 9000 19001

# Config Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]