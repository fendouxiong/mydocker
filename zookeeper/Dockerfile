FROM alibeibei/java:latest

ENV ZOO_CONF_DIR /usr/local/zookeeper/conf
ENV CONFIG=/usr/local/zookeeper/conf/zoo.cfg
ENV ZOO_PORT 2181
ENV ZOO_DATA_DIR /data/zookeeper
ENV ZOO_DATA_LOG_DIR /tmp/log/zookeeper
ENV ZOO_TICK_TIME 2000
ENV ZOO_INIT_LIMIT 5
ENV ZOO_SYNC_LIMIT 2
ENV ZOO_MAX_CLIENT_CNXNS 60

RUN cd /usr/local/src && \
    wget http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.3.6/zookeeper-3.3.6.tar.gz && \
    tar -zxvf zookeeper-3.3.6.tar.gz && rm -rf zookeeper-3.3.6.tar.gz && \
    mv zookeeper-3.3.6 /usr/local/zookeeper

COPY docker-entrypoin.sh /usr/local/bin/docker-entrypoin.sh

RUN chmod +x /usr/local/bin/docker-entrypoin.sh

EXPOSE 2888 3888

ENTRYPOINT ["docker-entrypoin.sh"]

CMD ["/usr/local/zookeeper/bin/zkServer.sh","start-foreground"]