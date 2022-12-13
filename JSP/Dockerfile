# mysql
mysql:
  container_name: ${PROJECT_PREFIX}-mysql
  restart: unless-stopped
  image: mysql:5.6.39
  ports:
    - "${SRV_MYSQL_PORT}:3306"
  volumes:
    - ${DATA_PATH}/mysql:/data
  environment:
    - MYSQL_ROOT_PASSWORD=${SRV_MYSQL_ROOT_PASSWORD}
# redis
redis:
  container_name: ${PROJECT_PREFIX}-redis
  restart: unless-stopped
  image: redis:4.0.8
  ports:
    - "${SRV_REDIS_PORT}:6379"
  volumes:
    - ${DATA_PATH}/redis:/data
  command: redis-server --requirepass ${SRV_REDIS_PASSWORD}
# rabbitmq
rabbitmq:
  container_name: ${PROJECT_PREFIX}-rabbitmq
  restart: unless-stopped
  image: rabbitmq:3.7.4-management-alpine
  ports:
    - "${SRV_RABBITMQ_PORT}:5672"
  volumes:
    - ${DATA_PATH}/rabbitmq:/var/lib/rabbitmq
  environment:
    - RABBITMQ_NODENAME=default@localhost
# elastic-search
elasticsearch:
  container_name: ${PROJECT_PREFIX}-elasticsearch
  restart: unless-stopped
  image: elasticsearch:5.6.8
  ports:
    - "${SRV_ELASTICSEARCH_PORT1}:9200"
    - "${SRV_ELASTICSEARCH_PORT2}:9300"
  volumes:
    - ${DATA_PATH}/elasticsearch:/data
  command: elasticsearch
# api nginx
api:
  container_name: ${PROJECT_PREFIX}-api
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/smartcity-api:standard-build
  ports:
    - "${MOD_API_PORT}:80"
  volumes:
    - /data/tsl/:/data
    - ./legacy.config.ini:/config.ini
  environment:
    - ENV=prod
  # command: /project/script/nginx_bootstrap.sh
  env_file: ./.env
# script
script:
  container_name: ${PROJECT_PREFIX}-script
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/smartcity-script:standard-build
  volumes:
    - /data/tsl:/data
    - ./legacy.config.ini:/config.ini
  environment:
    - ENV=prod
  # command: /project/script/script_bootstrap.sh
  env_file: ./.env
# 蓝色平台前端
fe:
  container_name: ${PROJECT_PREFIX}-fe
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/smartcity-fe:standard
  ports:
    - "${MOD_FE_PORT}:80"
  env_file: ./.env
# 大数据
spark-localfinal:
  container_name: ${PROJECT_PREFIX}-spark-localfinal
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/spark:master
  env_file: ./.env
spark-apiserver:
  container_name: ${PROJECT_PREFIX}-spark-apiserver
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/api-server:master
  ports:
    - "${MOD_BIGDATA_API_PORT}:8085"
    - "${MOD_BIGDATA_API_PORT1}:8089"
  env_file: ./.env
#视频
video-api:
  container_name: ${PROJECT_PREFIX}-video-api
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/architecture-video-api:latest
  ports:
    - "${MOD_VIDEO_API_PORT}:80"
  env_file: ./video/.env
  volumes:
    - /data/video:/data/video
    - ./video/cron.conf:/etc/crontabs/root.conf
    - /data/video/api/log:/data/log
video-srs:
  container_name: ${PROJECT_PREFIX}-video-srs
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/architecture-video-srs:latest
  ports:
    - "${MOD_VIDEO_RTMP_PORT}:1935"
  env_file: ./video/.env
  volumes:
    - ./video/srs.conf.template:/usr/local/srs/conf/srs.conf.template
    - /data/srs/log:/data/log
  command: /bin/sh -c "envsubst '$$API_HOST $$API_PORT' < /usr/local/srs/conf/srs.conf.template > /usr/local/srs/conf/srs.conf && /etc/init.d/srs start && tail -f /data/log/srs.log"
video-saver:
  container_name: ${PROJECT_PREFIX}-video-saver
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/architecture-video-saver:latest
  env_file: ./video/.env
  volumes:
    - /data/tmp:/tmp
video-puller:
  container_name: ${PROJECT_PREFIX}-video-puller
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/architecture-video-puller:latest
  env_file: ./video/.env
# 设备服务
deviceapi:
  container_name: ${PROJECT_PREFIX}-deviceapi
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/smartcity-deviceapi:master
  ports:
    - "${MOD_DEVICE_API_PORT}:80"
  volumes:
    - ./legacy.config.ini:/app/config.ini:ro
    - /data/tsl:/data
  env_file: ./.env
# dnake人脸服务
dnake-face:
  container_name: ${PROJECT_PREFIX}-dnake-face
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/dnake-face
  ports:
    - "${MOD_DNAKE_FACE_PORT}:8000"
  env_file: ./.env
# minio服务
minio:
  container_name: ${PROJECT_PREFIX}-minio
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/minio/minio:latest
  ports:
    - "${SRV_MINIO_PORT}:9000"
  volumes:
    - /mnt/data:/data
    - /mnt/config:/root/.minio
  environment:
    - MINIO_ACCESS_KEY=${SRV_MINIO_KEY}
    - MINIO_SECRET_KEY=${SRV_MINIO_SECRET}
  env_file: ./.env
  command: server /data
# 监控
monitor:
  container_name: ${PROJECT_PREFIX}-monitor
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/monitor_monitor:latest
  volumes:
    - ./monitor/monitor.ini:/app/monitor.ini
    - ./monitor/crontab.conf:/etc/crontab.conf
    - /var/run/docker.sock:/var/run/docker.sock
  env_file: ./.env
# 代理
frpc:
  container_name: ${PROJECT_PREFIX}-frpc
  restart: unless-stopped
  image: ddliu/frpc:latest
  volumes:
    - ./frpc.ini:/etc/frpc.ini
  net: host
#同步
syncfile-app:
  container_name: ${PROJECT_PREFIX}-syncfile
  restart: unless-stopped
  image: daocloud.io/terminus_cloud/syncfile-app:master
  volumes:
    - /data/sync-file:/data/sync-file
  env_file:
    - ./syncfile/config.env
  working_dir: /app
  command: /app/sync-file-to-cloud