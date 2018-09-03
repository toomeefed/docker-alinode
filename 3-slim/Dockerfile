FROM debian:8-slim AS builder

# alinode 版本和镜像
ENV ALINODE_VERSION=3.11.8
ENV MIRROR_ALINODE=http://alinode.aliyun.com/dist/new-alinode

# 下载 alinode
RUN echo "\
deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib\n\
" > /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends ca-certificates wget \
&& rm -rf /var/lib/apt/lists/* \
&& cd /opt \
&& wget $MIRROR_ALINODE/v$ALINODE_VERSION/alinode-v$ALINODE_VERSION-linux-x64.tar.gz \
&& tar -xzf alinode-v$ALINODE_VERSION-linux-x64.tar.gz \
&& mv alinode-v$ALINODE_VERSION-linux-x64 alinode

FROM debian:8-slim AS prod

USER root

# 复制 alinode npm 到 bin 目录
COPY --from=builder /opt/alinode/lib /usr/local/lib
COPY --from=builder /opt/alinode/bin /usr/local/bin

# 只维护一个 shell，安装 yarn pm2 agenthub
RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
&& npm set registry https://registry.npm.taobao.org \
&& npm set disturl https://npm.taobao.org/dist \
&& npm i -g yarn pm2 @alicloud/agenthub \
&& npm cache clean --force

# 应用环境变量
ENV HOME=/root \
    APP_DIR=/app \
    ALINODE_VERSION=3.11.8 \
    ENABLE_NODE_LOG=YES \
    NODE_LOG_DIR=/tmp \
    ALINODE_CONFIG=alinode.config.json \
    NODE_ENV=production

# 初始化脚本
COPY default.config.js $HOME
COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

# 工作目录
WORKDIR /app

# 默认启动命令
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
