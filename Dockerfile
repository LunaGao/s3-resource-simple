FROM python:3.7.3

RUN sudo apt-get install jq

RUN pip install --upgrade pip
RUN pip install --upgrade awscli

ADD assets/ /opt/resource/
