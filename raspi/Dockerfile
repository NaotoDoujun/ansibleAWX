FROM 2000cubits/raspbian:latest

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && apt-get clean all
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y cron curl openssh-server supervisor sudo bash-completion && apt-get clean all
RUN mkdir -p /var/run/sshd /var/log/supervisor

# add 'pi' user
RUN useradd -m -s /bin/bash pi && gpasswd -a pi sudo && echo "pi:raspberry" | chpasswd
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# PAM
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/cron

COPY supervisord.conf /etc/supervisor/conf.d/

EXPOSE 22
CMD ["/usr/bin/supervisord"]