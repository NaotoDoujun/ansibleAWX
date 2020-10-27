FROM ubuntu:20.04

RUN apt update && export DEBIAN_FRONTEND=noninteractive && apt upgrade -y && apt clean all
RUN apt update && export DEBIAN_FRONTEND=noninteractive &&  apt install -y apt-transport-https wget gnupg python3 python3-pip python-dev tree libpq-dev && apt clean all
RUN apt update && export DEBIAN_FRONTEND=noninteractive &&  apt install -y gnupg software-properties-common && apt install -y docker.io curl ansible sshpass && apt-get clean all
RUN apt update && export DEBIAN_FRONTEND=noninteractive && apt install -y python3-pip docker-compose supervisor && pip3 install docker-compose && apt-get clean all

RUN git clone --depth 50 https://github.com/ansible/awx.git
RUN cd /var/lib && mkdir awx && cd awx && mkdir projects && cd /

COPY run.sh /root/run.sh
RUN chmod 755 /root/run.sh

RUN touch /etc/supervisord.conf
RUN echo '[supervisord]'  >> /etc/supervisord.conf
RUN echo 'nodaemon=true'  >> /etc/supervisord.conf
RUN echo '[program:dockerd]'             >> /etc/supervisord.conf
RUN echo 'command=/usr/bin/dockerd' >> /etc/supervisord.conf
RUN echo '[program:awx]'             >> /etc/supervisord.conf
RUN echo 'command=/root/run.sh' >> /etc/supervisord.conf
RUN echo 'stdout_logfile=/dev/fd/1' >> /etc/supervisord.conf
RUN echo 'stdout_logfile_maxbytes=0' >> /etc/supervisord.conf

EXPOSE 80
ENTRYPOINT /usr/bin/supervisord -c /etc/supervisord.conf