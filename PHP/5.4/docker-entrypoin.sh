#!/bin/bash

set  -e

tee /etc/supervisor/conf.d/php-fpm.conf <<-'EOF'
[program:php-fpm]
command=/usr/local/php/sbin/php-fpm -c /usr/local/php/lib/php.ini
process_name=%(program_name)s
autorestart=true
autostart=true
stdout_logfile=/var/log/php-fpm.log
redirect_stderr=true
exitcodes=0
startretries=10
stopsignal=KILL
user=root
EOF

tee /etc/supervisor/conf.d/qconf_agent.conf <<-'EOF'
[program:qconf_agent]
command=/usr/local/qconf/bin/agent-cmd.sh start
process_name=%(program_name)s
autorestart=true
autostart=true
stdout_logfile=/var/log/qconf_agent.log
redirect_stderr=true
exitcodes=0
startretries=10
stopsignal=KILL
user=root
EOF

mkdir -p /var/log/nginx/

echo $QCONF_MODE > /usr/local/qconf/conf/localidc
echo $QCONF_ZOOKEEPER > /usr/local/qconf/conf/idc.conf

exec "$@"

