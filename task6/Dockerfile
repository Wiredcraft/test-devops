#VERSION 1
#Author:hua
#Base image
FROM centos

MAINTAINER hua hua@139.com
RUN mkdir /usr/local/Software

#put the API script into /usr/local/Software
ADD main_Linux.exe /usr/local/Software
RUN chmod a+x /usr/local/Software/main_Linux.exe

#Set the workdir to /usr/local/Software
WORKDIR /usr/local/Software
#Set the port which is arriavable from outside
EXPOSE 8008

#Run the script after the docker is build
ENTRYPOINT ["./main_Linux.exe"]