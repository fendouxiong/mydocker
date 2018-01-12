FROM java:java1.8
MAINTAINER  fendouxiong <wuxiaofei8023@gmail.com>

RUN cd /usr/local && wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.5-linux-x86_64.tar.gz

RUN cd /usr/local && tar -zxf kibana-5.6.5-linux-x86_64.tar.gz && \
     mv kibana-5.6.5-linux-x86_64 kibana && \
     chmod +x /usr/local/kibana/bin/kibana

COPY docker-entrypoin.sh  /usr/local/bin/docker-entrypoin.sh

RUN chmod +x /usr/local/bin/docker-entrypoin.sh

ENV SERVER_HOST localhost

ENV ES_URL http://localhost:9200

EXPOSE 5601

ENTRYPOINT ["docker-entrypoin.sh"]

CMD ["/usr/local/kibana/bin/kibana"]
