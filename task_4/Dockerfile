FROM python:3.6.4

RUN mkdir /code
COPY websrv.py /code
COPY requirements.txt /code
RUN pip install -r /code/requirements.txt -i https://pypi.douban.com/simple
WORKDIR /code

CMD ["python3","websrv.py"]