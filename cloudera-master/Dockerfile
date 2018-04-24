FROM windawings/cloudera-node:latest

MAINTAINER windawings <windawings@foxmail.com>

# Copy Shell
COPY config-env.sh config-env.sh
COPY cmd.sh cmd.sh

# Run Shell
RUN  chmod u+x config-env.sh cmd.sh && bash config-env.sh

# Expose Ports
EXPOSE 7180 7182 9000 19001

# Config Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Start Supervisor
CMD ["supervisord", "-n"]