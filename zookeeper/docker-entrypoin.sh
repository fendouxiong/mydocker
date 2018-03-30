#!/bin/bash

set  -e

if [ ! -d "$ZOO_CONF_DIR" ]; then
     mkdir -p "$ZOO_CONF_DIR"
     chmod 777 -R "$ZOO_CONF_DIR"
fi
if [ ! -d "$ZOO_DATA_DIR" ]; then
   mkdir -p "$ZOO_DATA_DIR"
   chmod 777 -R "$ZOO_DATA_DIR"
fi

if [ ! -d "$ZOO_DATA_LOG_DIR" ]; then
    mkdir -p "$ZOO_DATA_LOG_DIR"
    chmod 777 -R "$ZOO_DATA_LOG_DIR"
fi

CONFIG="$ZOO_CONF_DIR/zoo.cfg"

if [ -f "$ZOO_CONF_DIR/zoo.cfg" ];then
    rm -rf "$ZOO_CONF_DIR/zoo.cfg"
fi

echo "clientPort=$ZOO_PORT" >> "$CONFIG"
echo "dataDir=$ZOO_DATA_DIR" >> "$CONFIG"
echo "dataLogDir=$ZOO_DATA_LOG_DIR" >> "$CONFIG"
echo "tickTime=$ZOO_TICK_TIME" >> "$CONFIG"
echo "initLimit=$ZOO_INIT_LIMIT" >> "$CONFIG"
echo "syncLimit=$ZOO_SYNC_LIMIT" >> "$CONFIG"
echo "maxClientCnxns=$ZOO_MAX_CLIENT_CNXNS" >> "$CONFIG"

for server in $ZOO_SERVERS; do
    echo "$server" >> "$CONFIG"
done

echo "${ZOO_MY_ID:-1}" > "$ZOO_DATA_DIR/myid"

exec "$@"

