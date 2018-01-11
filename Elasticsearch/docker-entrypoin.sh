#!/bin/bash

set  -e

sed -i -e "s/Xms2g/Xms$XMS/" /usr/local/elasticsearch/config/jvm.options
sed -i -e "s/Xmx2g/Xmx$XMX/" /usr/local/elasticsearch/config/jvm.options

ES_YML=/usr/local/elasticsearch/config/elasticsearch.yml
PATH_DATA=${PATH_DATA//\//\\/}
PATH_LOGS=${PATH_LOGS//\//\\/}
sed -i -e "s/#network.host:.*/network.host: $NETWORK_HOST/" "$ES_YML"
sed -i -e "s/#bootstrap.memory_lock:.*/bootstrap.memory_lock: $BOOTSTRAP_MEMORY_LOCK/" "$ES_YML"
sed -i -e "s/#cluster.name:.*/cluster.name: $CLUSTER_NAME/" "$ES_YML"
sed -i -e "s/#node.name.*/node.name: $NODE_NAME/" "$ES_YML"
sed -i -e "s/#node.attr.rack:.*/node.attr.rack: $NODE_ATTR_RACK/" "$ES_YML"
sed -i -e "s/#path.data:.*/path.data: $PATH_DATA/" "$ES_YML"
sed -i -e "s/#path.logs:.*/path.logs: $PATH_LOGS/" "$ES_YML"
sed -i -e "s/#http.port:.*/http.port: $HTTP_POST/" "$ES_YML"
sed -i -e "s/#discovery.zen.ping.unicast.hosts:.*/discovery.zen.ping.unicast.hosts: $DISCOVERY_ZEN_PING_UNICAST_HOSTS/" "$ES_YML"
sed -i -e "s/#discovery.zen.minimum_master_nodes:.*/discovery.zen.minimum_master_nodes: $DISCOVERY_ZEN_MINIMUM_MASTER_NODES/" "$ES_YML"
sed -i -e "s/#gateway.recover_after_nodes:.*/gateway.recover_after_nodes: $GATEWAY_RECOVER_AFTER_NODES/" "$ES_YML"
sed -i -e "s/#action.destructive_requires_name:.*/action.destructive_requires_name: $ACTION_DESTRUCTIVE_REQUIRES_NAME/" "$ES_YML"

if [ "$NODE_MASTER" ];then
        if [ $(grep -c "node.master" "$ES_YML") -eq "0" ];then
        echo "node.master: false" >> "$ES_YML"
        fi
         sed -i -e "s/node.master:.*/node.master: $NODE_MASTER/" "$ES_YML"
fi

if [ "$NODE_DATA" ];then
        if [ $(grep -c "node.data" "$ES_YML") -eq "0" ];then
        echo "node.data: $NODE_DATA" >> "$ES_YML"
        fi
         sed -i -e "s/node.data:.*/node.data: $NODE_DATA/" "$ES_YML"
fi

if [ "$HTTP_CORS_ENABLED" ];then
        if [ $(grep -c "http.cors.enabled" "$ES_YML") -eq "0" ];then
        echo "http.cors.enabled: $HTTP_CORS_ENABLED" >> "$ES_YML"
        fi
        sed -i -e "s/http.cors.enabled:.*/http.cors.enabled: $HTTP_CORS_ENABLED/" "$ES_YML"
fi

if [ "$HTTP_CORS_ALLOW_ORIGIN" ];then
        if [ $(grep -c "http.cors.allow-origin" "$ES_YML") -eq "0" ];then
        echo "http.cors.allow-origin: $HTTP_CORS_ALLOW_ORIGIN" >> "$ES_YML"
        fi
        sed -i -e "s/http.cors.allow-origin:.*/http.cors.allow-origin: $HTTP_CORS_ALLOW_ORIGIN/" "$ES_YML"
fi

if [ "$NETWORK_PUBLISH_HOST" ];then
        if [ $(grep -c "network.publish_host" "$ES_YML") -eq "0" ];then
        echo "network.publish_host: $NETWORK_PUBLISH_HOST" >> "$ES_YML"
        fi
        sed -i -e "s/network.publish_host:.*/network.publish_host: $NETWORK_PUBLISH_HOST/" "$ES_YML"
fi

exec "$@"

