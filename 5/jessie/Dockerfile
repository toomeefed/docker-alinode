FROM debian:jessie

# 环境变量
ENV ALINODE_VERSION=5.13.0 \
    NODE_VERSION=12.13.0 \
    ARCH=x64 \
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
  && echo "deb http://mirrors.aliyun.com/debian jessie main" > /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/debian-security jessie/updates main" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/debian jessie-updates main" >> /etc/apt/sources.list \
  && apt-get update && apt-get install -y ca-certificates curl wget --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fsSLO --compressed "https://npm.taobao.org/mirrors/alinode/v$ALINODE_VERSION/alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz" \
  && curl -fsSLO --compressed "https://npm.taobao.org/mirrors/alinode/v$ALINODE_VERSION/SHASUMS256.txt" \
  && grep " alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -zxvf "alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz" SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && ENABLE_NODE_LOG=NO npm set registry https://registry.npm.taobao.org \
  && ENABLE_NODE_LOG=NO npm set disturl https://npm.taobao.org/dist \
  && ENABLE_NODE_LOG=NO npm i -g yarn pm2 @alicloud/agenthub \
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
