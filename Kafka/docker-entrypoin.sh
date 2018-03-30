#!/bin/bash

set  -e

if [ -d "$LOG_DIRS" ];then
    mkdir -p "$LOG_DIRS"
fi
LOG_DIRS=${LOG_DIRS//\//\\/}

sed -i -e "s/broker.id=.*/broker.id=$BROKER_ID/g" /usr/local/kafka/config/server.properties

sed -i -e "s/log.dirs=.*/log.dirs=$LOG_DIRS/g" /usr/local/kafka/config/server.properties

sed -i -e "s/zookeeper.connect=.*/zookeeper.connect=$ZOOKEEPER_CONNECT/g" /usr/local/kafka/config/server.properties

sed -i -e "s/num.network.threads=.*/num.network.threads=$NUM_NETWORK_THREADS_BROKER/g" /usr/local/kafka/config/server.properties

sed -i -e "s/num.io.threads=.*/num.io.threads=$NUM_IO_THREADS/g" /usr/local/kafka/config/server.properties

sed -i -e "s/socket.send.buffer.bytes=.*/socket.send.buffer.bytes=$SOCKET_SEND_BUFFER_BYTES/g" /usr/local/kafka/config/server.properties

sed -i -e "s/socket.receive.buffer.bytes=.*/socket.receive.buffer.bytes=$SOCKET_RECEIVE_BUFFER_BYTES/g" /usr/local/kafka/config/server.properties

sed -i -e "s/socket.request.max.bytes=.*/socket.request.max.bytes=$SOCKET_REQUEST_MAX_BYTES/g" /usr/local/kafka/config/server.properties

sed -i -e "s/num.partitions=.*/num.partitions=$NUM_PARTITIONS/g" /usr/local/kafka/config/server.properties

sed -i -e "s/log.retention.hours=.*/log.retention.hours=$LOG_RETENTION_HOURS/g" /usr/local/kafka/config/server.properties

sed -i -e "s/zookeeper.connection.timeout.ms=.*/zookeeper.connection.timeout.ms=$ZOOKEEPER_CONNECTION_TIMEOUT_MS/g" /usr/local/kafka/config/server.properties

if [ "$QUEUED_MAX_REQUESTS" ];then
        if [ $(grep -c "queued.max.requests" /usr/local/kafka/config/server.properties) -eq "0" ];then
        echo "" >> /usr/local/kafka/config/server.properties
        echo "queued.max.requests=$QUEUED_MAX_REQUESTS" >> /usr/local/kafka/config/server.properties
        fi
        sed -i -e "s/queued.max.requests=.*/queued.max.requests=$QUEUED_MAX_REQUESTS/" /usr/local/kafka/config/server.properties
fi
exec "$@"

