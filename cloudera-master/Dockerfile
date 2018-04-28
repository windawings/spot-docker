FROM windawings/cloudera-node:latest

MAINTAINER windawings <windawings@foxmail.com>

# Copy Shell
COPY cloudera-init/* /cloudera-init/run/

# Run Shell
RUN  chmod +x cloudera-init/run/* && bash /cloudera-init/run/config-env.sh

# Expose Ports
EXPOSE 7180 7182 9000 19001

# Init Centos
ENTRYPOINT ["/usr/sbin/init"]