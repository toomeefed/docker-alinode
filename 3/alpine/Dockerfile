FROM alpine:3.8

# 环境变量
ENV ALINODE_VERSION=3.14.0 \
    NODE_VERSION=8.15.0 \
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
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add --no-cache libstdc++ ca-certificates curl wget \
  && rm -rf /usr/local/bin/yarn* \
  && ENABLE_NODE_LOG=NO npm set registry https://registry.npm.taobao.org \
  && ENABLE_NODE_LOG=NO npm set disturl https://npm.taobao.org/dist \
  && ENABLE_NODE_LOG=NO npm i -g yarn pm2 \
  && ENABLE_NODE_LOG=NO npm cache clean --force \
  && rm -rf /tmp/*

# 初始化脚本
COPY default.config.js $HOME
COPY start-agenthub.sh /

# 入口脚本
ENTRYPOINT ["/start-agenthub.sh"]

# 工作目录
WORKDIR /app

# 默认启动命令
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
