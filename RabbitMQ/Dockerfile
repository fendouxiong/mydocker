FROM fendouxiong/java18:latest
MAINTAINER fendouxiong <xiaofei8023@gmail.com>

RUN wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -ivh epel-release-latest-7.noarch.rpm
RUN yum -y install erlang
RUN wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.4/rabbitmq-server-3.7.4-1.el7.noarch.rpm
RUN rpm -ivh rabbitmq-server-3.7.4-1.el7.noarch.rpm
RUN yum install -y rabbitmq
RUN yum clean all
RUN chkconfig rabbitmq-server on

EXPOSE 5672 5671 15672

CMD ["/sbin/service", "rabbitmq-server", "start"]
