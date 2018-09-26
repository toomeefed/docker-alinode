FROM registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode:3-alpine AS builder

RUN rm -rf /usr/local/bin/yarn* \
&& npm set registry https://registry.npm.taobao.org \
&& npm set disturl https://npm.taobao.org/dist \
&& npm i -g yarn pm2 \
&& npm cache clean --force

FROM alpine:3.6 AS prod

ENV NODE_VERSION=8.12.0 \
  YARN_VERSION=1.9.4 \
  ALINODE_VERSION=3.12.0 \
  ALINODE_CONFIG=alinode.config.json \
  ENABLE_NODE_LOG=YES \
  NODE_LOG_DIR=/tmp \
  NODE_ENV=production \
  HOME=/root \
  APP_DIR=/app

COPY --from=builder /usr/local /usr/local
COPY default.config.js $HOME
COPY docker-entrypoint.sh /

RUN addgroup -g 1000 node \
  && adduser -u 1000 -G node -s /bin/sh -D node \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
  && apk add --no-cache libstdc++ curl

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /app

CMD ["pm2-runtime", "start", "ecosystem.config.js"]
