FROM debian:8-slim

# alinode 版本和镜像
ENV ALINODE_VERSION=3.11.8 \
    NODE_VERSION=8.11.4 \
    ENABLE_NODE_LOG=YES \
    NODE_LOG_DIR=/tmp \
    ALINODE_CONFIG=alinode.config.json \
    NODE_ENV=production \
    HOME=/root \
    APP_DIR=/app

# 复制 alinode npm 到 bin 目录
COPY --from=registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode /usr/local/lib /usr/local/lib
COPY --from=registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode /usr/local/bin /usr/local/bin
COPY --from=registry.cn-hangzhou.aliyuncs.com/aliyun-node/alinode /bin/ping /bin

# 只维护一个 shell
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# 安装 curl yarn pm2
RUN echo -e "\
deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib\n\
" > /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends ca-certificates curl \
&& rm -rf /var/lib/apt/lists/* \
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
