FROM windawings/cloudera-node:latest

MAINTAINER windawings <windawings@foxmail.com>

# Copy Shell
COPY cloudera-init/* /cloudera-init/

# Run Shell
RUN  chmod u+x /cloudera-init/config-env.sh /cloudera-init/start.sh && bash /cloudera-init/config-env.sh

# Expose Ports
EXPOSE 7180 7182 9000 19001

# Config Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]