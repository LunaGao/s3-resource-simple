FROM python:3.7.3

RUN apk add --update jq

RUN pip install --upgrade pip
RUN pip install --upgrade awscli

ADD assets/ /opt/resource/
