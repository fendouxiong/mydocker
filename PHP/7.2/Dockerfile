FROM centos:latest
MAINTAINER fendouxiong<wuxiaofei8023@gmail.com>

RUN yum install -y autoconf automake libtool libxml2 xml2-config libxml2-devel  openssl openssl-devel libjpeg libjpeg-devel libpng libpng-devel freetype-devel mhash

ADD php-7.2.0.tar.gz /tmp
#RUN cd /tmp/php-7.2.0 && ./configure --help

RUN cd /tmp/php-7.2.0 && \
    ./configure --prefix=/usr/local/php --enable-fpm && \
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
