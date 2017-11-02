FROM alpine:latest
MAINTAINER Yuankun Zhu (zhuy@email.chop.edu)

ENV PICARD_VERSION 2.14.0

RUN apk add --update --no-cache openjdk8-jre ca-certificates wget; \
wget https://github.com/broadinstitute/picard/releases/download/${PICARD_VERSION}/picard.jar; \
apk del ca-certificates wget
