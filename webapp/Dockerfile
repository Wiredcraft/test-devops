FROM node:latest
MAINTAINER bearice@icybear.net

ADD . /opt/app
WORKDIR /opt/app
CMD node lib/main
RUN make -C /opt/app
