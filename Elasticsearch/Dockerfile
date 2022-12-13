FROM java:java1.8

RUN cd /usr/local && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.5.tar.gz


#安装elasticsearch-5.6.3
RUN cd /usr/local && tar -zxf elasticsearch-5.6.5.tar.gz && mv elasticsearch-5.6.5 elasticsearch && \
    chmod +x /usr/local/elasticsearch/bin/elasticsearch

RUN groupadd elsearch && \
    useradd elsearch -g elsearch -p elasticsearch && \
    chown -R elsearch:elsearch  /usr/local/elasticsearch

ENV XMS 512m
ENV XMX 512m
ENV NETWORK_HOST 127.0.0.1
ENV BOOTSTRAP_MEMORY_LOCK false
ENV CLUSTER_NAME "my-application"
ENV NODE_NAME "node-1"
ENV NODE_ATTR_RACK "r1"
ENV PATH_DATA "/data/es"
ENV PATH_LOGS "/tmp/es/logs"
ENV HTTP_POST 9200
ENV DISCOVERY_ZEN_MINIMUM_MASTER_NODES 3
ENV GATEWAY_RECOVER_AFTER_NODES 3
ENV ACTION_DESTRUCTIVE_REQUIRES_NAME true
ENV DISCOVERY_ZEN_PING_UNICAST_HOSTS '["127.0.0.1", "[::1]"]'
ENV NETWORK_PUBLISH_HOST ""

RUN mkdir -p "$PATH_DATA" && mkdir -p "$PATH_LOGS" && \
    chown -R elsearch:elsearch "$PATH_DATA" && \
    chown -R elsearch:elsearch "$PATH_LOGS"

COPY docker-entrypoin.sh  /usr/local/bin/docker-entrypoin.sh

RUN chmod +x /usr/local/bin/docker-entrypoin.sh

EXPOSE 9200 9300

#切换成slsearch用户
USER elsearch

ENTRYPOINT ["docker-entrypoin.sh"]

CMD ["/usr/local/elasticsearch/bin/elasticsearch"]