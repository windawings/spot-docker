FROM windawings/cloudera-node:5.14.2

MAINTAINER windawings <windawings@foxmail.com>

# Copy Shell
COPY cloudera-init/* /cloudera-init/run/

# Config Supervisor
COPY supervisord.service /usr/lib/systemd/system/supervisord.service

# Run Shell
RUN  chmod +x cloudera-init/run/* && bash /cloudera-init/run/config-env.sh

# Setup Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Expose Ports
EXPOSE 7180 7182 7191 19001

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]