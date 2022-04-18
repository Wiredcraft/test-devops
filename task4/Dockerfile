FROM python:3.7-alpine
MAINTAINER Michael

ENV FLASK_APP apicode.py
ENV FLASK_RUN_HOST 0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers

COPY . /apicode
WORKDIR /apicode
RUN pip3 install -r requirements.txt

CMD ["flask", "run"]
