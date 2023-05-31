# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

RUN apt-get update && \
    apt-get install -y locales && \
    sed -i -e 's/# it_IT.UTF-8 UTF-8/IT_IT.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

ENV LANG it_IT.UTF-8
ENV LC_ALL it_IT.UTF-8
ENV TZ Europe/Rome

WORKDIR /app

ADD VERSION .

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY ssbo.py .
COPY dbhelper.py .

RUN mkdir /data
RUN mkdir /logs

CMD [ "python3", "./ssbo.py"]
