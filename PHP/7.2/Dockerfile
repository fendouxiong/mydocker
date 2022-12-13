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
##安装新版本automake#ADD automake-1.14.tar.gz /tmp

#RUN yum -y remove automake && \
#    cd /tmp/automake-1.14 && \
#    ./configure --prefix=/usr && \
#    make && make install && \
#    rm -rf /tmp/automake-1.14*

##编译安装php7.2
RUN cd /tmp/php-7.2.0 && \
    ./configure --prefix=/usr/local/php --enable-fpm --with-openssl --with-curl --with-gd --enable-mbstring \
    --with-pdo-mysql  --enable-zip --with-pear --enable-mysqlnd --enable-sockets && \
    make -j 4 && make install
RUN cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
EXPOSE 9000
RUN mkdir -p /data/wwwroot
RUN mkdir -p /Logs/php && touch /Logs/php/error_log.log && chmod 777 /Logs/php/error_log.log
RUN echo "error_log=/Logs/php/error_log.log" >> /usr/local/php/lib/php.ini
RUN cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
RUN sed -i -e 's/listen = 127.0.0.1:9000/listen = 9000/' /usr/local/php/etc/php-fpm.d/www.conf
##PHP加入全局变量
RUN cp /usr/local/php/bin/php /usr/local/bin
##安装composer
RUN cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
##安装http2
ADD nghttp2-1.31.0.tar.gz /tmp
RUN cd /tmp/nghttp2-1.31.0 && ./configure && make && make install

RUN yum install -y wget

##安装依赖
RUN cd /tmp && wget https://github.com/redis/hiredis/archive/v0.13.3.tar.gz
RUN cd /tmp && tar -xzf v0.13.3.tar.gz
RUN cd /tmp/hiredis-0.13.3 && make && make install

#RUN yum install -y re2c

##编译安装redis扩展
ADD redis-4.0.2.tgz /tmp
RUN cd /tmp/redis-4.0.2 && \
    /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config  && make -j 4 && make install
RUN echo "extension=redis.so" >> /usr/local/php/lib/php.ini

##编译安装swoole扩展
ADD swoole-src-2.1.1.tar.gz /tmp
RUN cd /tmp/swoole-src-2.1.1 && \
    /usr/local/php/bin/phpize && ./configure  --with-php-config=/usr/local/php/bin/php-config \
    && make -j 4 && make install
RUN echo "extension=swoole.so" >> /usr/local/php/lib/php.ini
EXPOSE 9501
COPY docker-entrypoin.sh  /usr/local/bin/docker-entrypoin.sh
RUN chmod +x /usr/local/bin/docker-entrypoin.sh
ENTRYPOINT ["docker-entrypoin.sh"]

#ENTRYPOINT ["php",  "/data/wwwroot/easyswoole/easyswoole", "start"]
#ENTRYPOINT ["/usr/local/php/sbin/php-fpm", "-F", "-c", "/usr/local/php/lib/php.ini"]
