FROM alpine:3.6

# alinode 版本和镜像
ENV ALINODE_VERSION=3.12.0 \
    NODE_VERSION=8.12.0 \
    ENABLE_NODE_LOG=YES \
    NODE_LOG_DIR=/tmp \
    ALINODE_CONFIG=alinode.config.json \
    NODE_ENV=production \
    HOME=/root \
    APP_DIR=/app

# 复制 alinode npm 到 bin 目录
COPY --from=registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode:3-alpine /usr/local /usr/local

# 安装 curl yarn pm2
RUN addgroup -g 1000 node \
&& adduser -u 1000 -G node -s /bin/sh -D node \
&& echo http://mirrors.aliyun.com/alpine/v3.6/main > /etc/apk/repositories \
&& apk add --no-cache libstdc++ curl \
&& rm -rf /usr/local/bin/yarn* \
&& npm set registry https://registry.npm.taobao.org \
&& npm set disturl https://npm.taobao.org/dist \
&& npm i -g yarn pm2 \
&& npm cache clean --force

# 初始化脚本
COPY default.config.js $HOME
COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

# 工作目录
WORKDIR /app

# 默认启动命令
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
