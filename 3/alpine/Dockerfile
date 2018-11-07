FROM alpine:3.6

# 环境变量
ENV ALINODE_VERSION=3.12.0 \
    NODE_VERSION=8.12.0 \
    ENABLE_NODE_LOG=YES \
    NODE_LOG_DIR=/tmp \
    ALINODE_CONFIG=alinode.config.json \
    NODE_ENV=production \
    HOME=/root \
    APP_DIR=/app

# 从官网镜像中复制 alinode 包含了 agenthub 无需安装
COPY --from=registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode:3-alpine /usr/local /usr/local

# 添加账号，安装 依赖，运维工具，yarn pm2
RUN addgroup -g 1000 node \
  && adduser -u 1000 -G node -s /bin/sh -D node \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
  && apk add --no-cache libstdc++ ca-certificates curl wget \
  && rm -rf /usr/local/bin/yarn* \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && npm set registry https://registry.npm.taobao.org \
  && npm set disturl https://npm.taobao.org/dist \
  && npm i -g yarn pm2 \
  && npm cache clean --force \
  && rm -rf /tmp/*

# 初始化脚本
COPY default.config.js /root
COPY start-agenthub.sh /

# 入口脚本
ENTRYPOINT ["/start-agenthub.sh"]

# 工作目录
WORKDIR /app

# 默认启动命令
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
