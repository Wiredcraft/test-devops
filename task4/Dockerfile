FROM python:2

WORKDIR /data

RUN pip install flask==1.1.2
RUN mkdir -p /data

COPY ./mock_api.py .

CMD [ "python", "/data/mock_api.py" ]