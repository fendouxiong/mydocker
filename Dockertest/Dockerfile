FROM centos:latest

MAINTAINER fendouxiong <wuxiaofei8023@gmail.com>

RUN cd /tmp && mkdir wuxiaofei
RUN echo "hello docker"
RUN yum install -y zip unzip && yum clean all

ADD librdkafka-master.zip /tmp