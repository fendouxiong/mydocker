#!/bin/bash

set  -e
echo "server.host: $SERVER_HOST" >>/usr/local/kibana/config/kibana.yml
echo "elasticsearch.url: $ES_URL" >> /usr/local/kibana/config/kibana.yml
exec "$@"
