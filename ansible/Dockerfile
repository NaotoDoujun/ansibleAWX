FROM ubuntu:20.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y apt-transport-https wget gnupg python3 python3-pip python-dev tree libpq-dev && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y gnupg software-properties-common docker.io curl ansible sshpass && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y docker-compose supervisor && pip3 install docker-compose && apt-get clean all
RUN mkdir -p /var/log/supervisor /var/lib/awx/projects

RUN git clone --depth 50 https://github.com/ansible/awx.git

COPY run.sh /root/run.sh
RUN chmod 755 /root/run.sh

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]