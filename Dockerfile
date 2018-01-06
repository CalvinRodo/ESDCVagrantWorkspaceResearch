FROM centos:6.8 As build

MAINTAINER Calvin Rodo <calvin.rodo@hrsdc-rhdcc.gc.ca>

#update image
RUN yum -y update; yum clean all


#Install tools
RUN yum -y install sudo
RUN sudo yum -y install epel-release
RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
RUN sudo yum -y install nodejs
RUN sudo yum -y install openssh-server passwd; yum clean all

RUN sudo npm install -g cordova ionic

#Start SSH
ADD ./start.sh ./start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

RUN chmod 755 /start.sh

EXPOSE 22
RUN ./start.sh


ENTRYPOINT ["/usr/sbin/sshd", "-D"]
