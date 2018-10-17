FROM debian:jessie

# 环境变量
ENV ALINODE_VERSION=3.12.0 \
    NODE_VERSION=8.12.0 \
    ENABLE_NODE_LOG=YES \
    NODE_LOG_DIR=/tmp \
    ALINODE_CONFIG=alinode.config.json \
    NODE_ENV=production \
    HOME=/root \
    APP_DIR=/app

# 添加用户和组
RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

# 安装 运维工具，alinode，yarn pm2 agenthub
RUN set -x \
  && echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list \
  && apt-get update && apt-get install -y ca-certificates curl wget --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -SLO "http://alinode.aliyun.com/dist/new-alinode/v$ALINODE_VERSION/alinode-v$ALINODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "http://alinode.aliyun.com/dist/new-alinode/v$ALINODE_VERSION/SHASUMS256.txt" \
  && grep " alinode-v$ALINODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt | sha256sum -c - \
  && tar -zxvf "alinode-v$ALINODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "alinode-v$ALINODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt \
  && npm set registry https://registry.npm.taobao.org \
  && npm set disturl https://npm.taobao.org/dist \
  && npm i -g yarn pm2 @alicloud/agenthub \
  && npm cache clean --force

# 初始化脚本
COPY default.config.js /root
COPY start-agenthub.sh /

# 入口脚本
ENTRYPOINT ["/start-agenthub.sh"]

# 工作目录
WORKDIR /app

# 默认启动命令
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
