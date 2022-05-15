FROM python:3.9-alpine

ENV FLASK_APP api.py
ENV FLASK_RUN_HOST 0.0.0.0

ADD . /usr/local/src
WORKDIR /usr/local/src

RUN pip3 install -r requirements

CMD ["flask","run"]