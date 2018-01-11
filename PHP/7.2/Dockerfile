FROM centos:latest
MAINTAINER fendouxiong<wuxiaofei8023@gmail.com>

RUN yum install -y autoconf automake libtool libxml2 xml2-config libxml2-devel  openssl openssl-devel libjpeg libjpeg-devel libpng libpng-devel freetype-devel mhash
RUN yum install -y curl curl-devel
ADD php-7.2.0.tar.gz /tmp
#RUN cd /tmp/php-7.2.0 && ./configure --help

#fix error: mcrypt.h not found
#ADD libmcrypt-2.5.7.tar.gz /tmp
#RUN cd /tmp/libmcrypt-2.5.7  && \
#    ./configure --prefix=/usr/local/libmcrypt  && \
#    make && make install && \
#    rm -rf /tmp/libmcrypt-2.5.7*
#
##安装新版本automake
#ADD automake-1.14.tar.gz /tmp
#RUN yum -y remove automake && \
#    cd /tmp/automake-1.14 && \
#    ./configure --prefix=/usr && \
#    make && make install && \
#    rm -rf /tmp/automake-1.14*

RUN cd /tmp/php-7.2.0 && \
    ./configure --prefix=/usr/local/php --enable-fpm --with-openssl --with-curl --with-gd --enable-mbstring \
    --with-pdo-mysql  --enable-zip --with-pear --enable-mysqlnd && \
    make && make install

RUN cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
#RUN sed -i -e 's/listen = 127.0.0.1:9000/listen = 9000/' /usr/local/php/etc/php-fpm.conf
EXPOSE 9000

RUN mkdir -p /data/wwwroot

RUN mkdir -p /Logs/php && touch /Logs/php/error_log.log && chmod 777 /Logs/php/error_log.log

RUN echo "error_log=/Logs/php/error_log.log" >> /usr/local/php/lib/php.ini

RUN cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
RUN sed -i -e 's/listen = 127.0.0.1:9000/listen = 9000/' /usr/local/php/etc/php-fpm.d/www.conf

ENTRYPOINT ["/usr/local/php/sbin/php-fpm", "-F", "-c", "/usr/local/php/lib/php.ini"]
