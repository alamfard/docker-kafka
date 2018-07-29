FROM alpine:latest
MAINTAINER Vahid Alamfard alamfard@gmail.com

RUN apk add --no-cache bash openjdk8-jre-base
ENV JAVA_HOME /usr

RUN mkdir /data
WORKDIR /data

RUN mkdir -p /opt/kafka && \
    apk add --no-cache wget tar && \
    wget http://www-eu.apache.org/dist/kafka/1.1.1/kafka_2.12-1.1.1.tgz -qO- | \
	  tar zxvf - -C /opt/kafka --strip 1 && \
		rm -rf /opt/kafka/site-docs && \
    rm -rf /opt/kafka/config/server.properties && \
		apk del tar wget

ENV PATH /usr/lib/jvm/jre/bin:/opt/kafka/bin:$PATH

ADD start-kafka.sh /opt/kafka/bin/start-kafka
CMD [ "start-kafka" ]
