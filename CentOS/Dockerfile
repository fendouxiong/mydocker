FROM centos
MAINTAINER fendouxiong <wu880810@aliyun.com>

ENV TZ "Asia/Shanghai"

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN cd /tmp && touch aa.log && echo "11" >> /tmp/aa.log