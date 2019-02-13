FROM alpine:latest

LABEL maintainer "Sebastian Meiling <s@mlng.net>"

RUN apk --no-cache add \
        bash \
        openjdk8 \
        rsync

RUN mkdir -p /opt/docker/conf

WORKDIR /opt/docker
ADD rpki-validator-app-*-dist.tar.gz .
COPY startup.sh .

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

CMD /opt/docker/startup.sh
