FROM centos:latest
MAINTAINER  fendouxiong <wuxiaofei8023@gmail.com>

ADD nginx-1.12.2.tar.gz /tmp

RUN yum -y install gcc pcre-devel openssl openssl-devel && yum clean all

#Nginx
RUN cd /tmp/nginx-1.12.2 && \
  ./configure \
    --prefix=/usr/local/nginx && \
    make && make install && \
  cd /tmp && rm -rf nginx-1*

COPY docker-entrypoin.sh /usr/local/bin/docker-entrypoin.sh
RUN chmod +x /usr/local/bin/docker-entrypoin.sh
RUN mkdir -p /usr/local/nginx/conf/Servers
RUN mkdir -p /Logs/nginx && touch /Logs/nginx/error.log && touch /Logs/nginx/access.log
RUN chmod 777 /Logs/nginx/error.log /Logs/nginx/access.log

EXPOSE 80 443

ENTRYPOINT ["docker-entrypoin.sh"]

#启动nginx
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]