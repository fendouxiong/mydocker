FROM centos:latest
MAINTAINER fendouxiong <wuxiaofei8023@gmail.com>

ENV TZ "Asia/Shanghai"

ENV QCONF_ZOOKEEPER "zookeeper.test=172.16.60.8:2181"

ENV QCONF_MODE "dev"

ENV PHP_INI_CONF ""

#Dir
RUN mkdir -p /data/wwwroot

#Yum
RUN yum install -y gcc wget curl curl-devel  autoconf tar make cmake git zip unzip automake libxml2 xml2-config libxml2-devel  openssl openssl-devel libjpeg libjpeg-devel libpng libpng-devel freetype-devel mhash

RUN  yum clean all

#fix error: mcrypt.h not found
ADD libmcrypt-2.5.7.tar.gz /tmp
RUN cd /tmp/libmcrypt-2.5.7  && \
    ./configure --prefix=/usr/local/libmcrypt  && \
    make && make install && \
    rm -rf /tmp/libmcrypt-2.5.7*

#安装新版本automake
ADD automake-1.14.tar.gz /tmp
RUN yum -y remove automake && \
    cd /tmp/automake-1.14 && \
    ./configure --prefix=/usr && \
    make && make install && \
    rm -rf /tmp/automake-1.14*

#php安装
ADD php-5.4.45.tar.gz /tmp
RUN cd /tmp/php-5.4.45 && \
   ./configure \
      --prefix=/usr/local/php \
      --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-simplexml --enable-xml  --enable-bcmath --enable-soap --enable-zip --with-curl --enable-fpm --with-fpm-user=nobody --with-fpm-group=nobody --enable-mbstring --enable-sockets --with-mcrypt=/usr/local/libmcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash && \
      make && \
      make install

#复制文件
RUN cp /tmp/php-5.4.45/php.ini-production /usr/local/php/lib/php.ini && \
    cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    cd /tmp && rm -rf php-5.4.45*



#opcache扩展
ADD zendopcache-7.0.5.tgz /tmp
RUN cd /tmp/zendopcache-7.0.5 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    echo "zend_extension=usr/local/php/lib/php/extensions/no-debug-non-zts-20100525/opcache.so" >> /usr/local/php/lib/php.ini && \
    rm -rf /tmp/zendopcache-7.0.5*

#redis扩展
ADD redis-3.1.4RC3.tgz /tmp
RUN cd /tmp/redis-3.1.4RC3 && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    echo "extension=redis.so" >> /usr/local/php/lib/php.ini && \
    rm -rf /tmp/redis-3.1.4RC3*

#mongoDb扩展
ADD mongodb-1.2.11.tgz /tmp
RUN cd /tmp/mongodb-1.2.11 && \
     /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    echo "extension=mongodb.so" >> /usr/local/php/lib/php.ini && \
    cd /tmp && rm -rf  mongodb-1.2.11*

#mongo扩展
ADD mongo-1.6.16.tgz /tmp
RUN cd /tmp/mongo-1.6.16 && \
     /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    echo "extension=mongo.so" >> /usr/local/php/lib/php.ini && \
    rm -rf /tmp/mongo-1.6.16*

#ssdb扩展
RUN cd /tmp && \
    git clone https://github.com/jonnywang/phpssdb.git && \
    cd phpssdb && \
     /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    echo "extension=ssdb.so" >> /usr/local/php/lib/php.ini && \
    rm -rf /tmp/phpssdb

#xdebug扩展
ADD xdebug-2.3.3.tgz /tmp
RUN cd /tmp/xdebug-2.3.3 && \
     /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    echo "zend_extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so">>/usr/local/php/lib/php.ini && \
    rm -rf /tmp/xdebug-2.3.3*

#下载phpunit
RUN cd /usr/local/src && \
    wget https://phar.phpunit.de/phpunit-4.8.phar && \
    mv phpunit-4.8.phar /usr/bin/phpunit && \
    chmod +x /usr/bin/phpunit

RUN yum install -y texinfo gcc-c++ && yum clean all

#qconf客户端安装
RUN cd /tmp && \
    git clone https://github.com/Qihoo360/QConf.git && \
    cd QConf/ && \
    mkdir -p build && \
    cmake . && \
    make && make install

#qconf扩展
RUN cd /tmp/QConf/driver/php && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config \
                --with-libqconf-dir=/usr/local/qconf/include \
                --enable-static LDFLAGS=/usr/local/qconf/lib/libqconf.a && \
    make && make install && \
    echo "extension=qconf.so" >> /usr/local/php/lib/php.ini && \
    rm -rf /tmp/QConf

#安装supervisor
RUN yum install -y python-setuptools && \
    easy_install supervisor && \
    mkdir /etc/supervisor && \
    echo_supervisord_conf > /etc/supervisor/supervisord.conf && \
    mkdir /etc/supervisor/conf.d && \
    sed -i -e 's/\;\[include\]/\[include\]/' /etc/supervisor/supervisord.conf && \
    sed -i -e 's/tmp\/supervisor.sock/var\/run\/supervisor.sock/' /etc/supervisor/supervisord.conf && \
    echo "files = conf.d/*.conf" >> /etc/supervisor/supervisord.conf

#加入qconf_agent 执行脚本
RUN chmod +x /usr/local/qconf/bin/agent-cmd.sh

RUN sed -i -e 's/listen = 127.0.0.1:9000/listen = 9000/' /usr/local/php/etc/php-fpm.conf

#安装 libzookeeper_mt
ADD zookeeper-3.4.6.tar.gz /tmp
RUN cd /tmp/zookeeper-3.4.6/src/c && \
    ./configure --prefix=/usr/local/zookeeper &&\
    make && make install && cd /tmp && rm -rf /tmp/zookeeper-3.4.6*

RUN yum install -y zip unzip && yum clean all

#安装 librdkafka
ADD librdkafka-master.zip /tmp
RUN cd /tmp && unzip librdkafka-master.zip && cd /tmp/librdkafka-master && \
     ./configure && make && make install && \
     rm -rf /tmp/librdkafka-master

ENV PATH "$PATH:/usr/local/php/bin"

#zookeeper
RUN cd /tmp && git clone https://github.com/jbboehr/php-zookeeper.git && \
     cd php-zookeeper && phpize && \
     ./configure --with-php-config=php-config --with-libzookeeper-dir=/usr/local/zookeeper &&\
     make && make install && \
     cd /tmp && rm -rf php-zookeeper

#安装 php-rdkafka 扩展
RUN cd /tmp &&\
     git clone https://github.com/arnaud-lb/php-rdkafka.git && \
     cd php-rdkafka && \
     phpize && \
     ./configure && \
     make && \
     make install && \
     cd /tmp && rm -rf php-rdkafka*

RUN  echo "extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20100525/zookeeper.so" >>/usr/local/php/lib/php.ini && \
     echo "extension=rdkafka.so" >>/usr/local/php/lib/php.ini

EXPOSE 9000

COPY docker-entrypoin.sh /usr/local/bin/docker-entrypoin.sh

RUN chmod +x /usr/local/bin/docker-entrypoin.sh

RUN mkdir -p /data/wwwroot

RUN mkdir -p /Logs/php && touch /Logs/php/error_log.log && chmod 777 /Logs/php/error_log.log

RUN echo "error_log=/Logs/php/error_log.log" >> /usr/local/php/lib/php.ini

#安装 librdkafka
ENTRYPOINT ["docker-entrypoin.sh"]
#启动
CMD ["supervisord","-n","-c", "/etc/supervisor/supervisord.conf"]