FROM centos:6.8 As build

MAINTAINER Calvin Rodo <calvin.rodo@hrsdc-rhdcc.gc.ca>

#update image
RUN yum -y update; yum clean all


#Install tools
RUN yum -y install epel-release
RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | bash -
RUN yum -y install nodejs
RUN yum -y install openssh-server passwd; yum clean all
RUN yum -y install sudo; yum clean all;

#Start SSH
ADD ./start.sh ./start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN chmod 755 /start.sh

EXPOSE 22
RUN ./start.sh

RUN usermod -aG wheel vagrant

ENTRYPOINT ["/usr/sbin/sshd", "-D"]

#add wheel group to sudoers file
RUN echo '%wheel         ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
