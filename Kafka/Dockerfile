FROM java:java1.8

RUN cd /usr/local/src && \
     wget http://apache.stu.edu.tw/kafka/1.0.0/kafka_2.11-1.0.0.tgz && \
     tar xvf kafka_2.11-1.0.0.tgz && \
     rm -rf kafka_2.11-1.0.0.tgz  && \
     mv kafka_2.11-1.0.0 /usr/local/kafka

#为依次增长的：0、1、2、3、4，集群中唯一id
ENV BROKER_ID 0
#日志地址
ENV LOG_DIRS "/data/kafka/logs"
#zookeeperServers列表，各节点以逗号分开
ENV ZOOKEEPER_CONNECT localhost:2181
#num.network.threads broker处理消息的最大线程数，一般情况下数量为cpu核数
ENV NUM_NETWORK_THREADS_BROKER 2
#num.io.threads 处理IO的线程数 最大不超过cpu的3倍
ENV NUM_IO_THREADS 5
#socket.send.buffer.bytes=102400
ENV SOCKET_SEND_BUFFER_BYTES 102400
#socket.receive.buffer.bytes
ENV SOCKET_RECEIVE_BUFFER_BYTES 102400
#socket.request.max.bytes=104857600
ENV SOCKET_REQUEST_MAX_BYTES 104857600
#num.partitions=1 默认分区数
ENV NUM_PARTITIONS 1
#log.retention.hours 控制一个log保留多长个小时
ENV LOG_RETENTION_HOURS 168
#zookeeper.connection.timeout.ms 指定客户端连接zookeeper的最大超时时间
ENV ZOOKEEPER_CONNECTION_TIMEOUT_MS 6000
#queued.max.requests 等待IO线程处理的请求队列最大数
ENV QUEUED_MAX_REQUESTS 500

COPY docker-entrypoin.sh /usr/local/bin/docker-entrypoin.sh

RUN chmod +x /usr/local/bin/docker-entrypoin.sh

EXPOSE 9092

ENTRYPOINT ["docker-entrypoin.sh"]

CMD ["/usr/local/kafka/bin/kafka-server-start.sh","/usr/local/kafka/config/server.properties"]
