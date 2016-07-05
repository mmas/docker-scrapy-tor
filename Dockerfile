FROM debian:jessie

MAINTAINER mmast

RUN apt-get update

RUN apt-get install -y tor privoxy
ADD privoxy.conf /etc/privoxy/config

RUN echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential curl python python-dev libffi-dev libssl-dev libxml2-dev libxslt-dev
RUN curl -LO https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm -rf get-pip.py
WORKDIR /opt
RUN pip install Scrapy==1.0.3

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod 700 /usr/bin/entrypoint.sh

EXPOSE 6800 8118 9050

VOLUME /opt

ENV http_proxy http://127.0.0.1:8118
ENV https_proxy http://127.0.0.1:8118

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
