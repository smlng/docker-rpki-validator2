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

RUN addgroup -S -g 323 rpki && adduser -S -u 323 -G rpki rpki
RUN chown -R rpki:rpki /opt/docker

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
USER rpki

CMD /opt/docker/startup.sh
