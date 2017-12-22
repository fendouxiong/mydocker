#!/bin/bash

set  -e

/usr/local/php/sbin/php-fpm -F -c /usr/local/php/lib/php.ini

exec "$@"
