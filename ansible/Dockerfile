FROM ubuntu:20.04

ARG AWX_VERSION="15.0.1"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y apt-transport-https wget gnupg python3 python3-pip python-dev tree libpq-dev sudo vim && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y gnupg software-properties-common docker.io curl ansible sshpass && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y docker-compose openssh-server supervisor && pip3 install docker-compose && apt-get clean all
RUN mkdir -p /var/run/sshd /var/log/supervisor /var/lib/awx/projects

# add 'awx-user' user
RUN useradd -m -s /bin/bash awx-user && gpasswd -a awx-user sudo && echo "awx-user:awx-user" | chpasswd
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# dont check host key
RUN sed -i 's/#host_key_checking = False/host_key_checking = False/' /etc/ansible/ansible.cfg

# allow ssh port forwarding
RUN sed -i 's/#GatewayPorts no/GatewayPorts yes/' /etc/ssh/sshd_config && \
  sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# download and extract target version archive
RUN wget -c https://github.com/ansible/awx/archive/${AWX_VERSION}.tar.gz -O - | tar -xz && mv awx-${AWX_VERSION} awx
COPY run.sh /root/run.sh
RUN chmod 755 /root/run.sh

# uncomment project data dir
RUN sed -i 's/#project_data_dir=\/var\/lib\/awx\/projects/project_data_dir=\/var\/lib\/awx\/projects/' /awx/installer/inventory

COPY supervisord.conf /etc/supervisor/conf.d/

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]