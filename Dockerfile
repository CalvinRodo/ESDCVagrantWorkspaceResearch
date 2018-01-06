FROM centos:6.8 As build

RUN yum -y install sudo
RUN sudo yum -y install epel-release
RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
run sudo yum -y install nodejs
run sudo npm install -g ionic
