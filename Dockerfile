FROM mhart/alpine-node 

MAINTAINER Calvin Rodo 

#Install the tools for the system
RUN apk add git
RUN apk add 