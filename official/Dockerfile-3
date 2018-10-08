FROM node:8

ENV ALINODE_VERSION=3.12.0
ENV ENABLE_NODE_LOG=YES
ENV NODE_LOG_DIR=/tmp
ENV HOME=/root

RUN curl -SLO "http://alinode.aliyun.com/dist/new-alinode/v$ALINODE_VERSION/alinode-v$ALINODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "http://alinode.aliyun.com/dist/new-alinode/v$ALINODE_VERSION/SHASUMS256.txt" \
  && grep " alinode-v$ALINODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt | sha256sum -c - \
  && tar -zxvf "alinode-v$ALINODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "alinode-v$ALINODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt
RUN ENABLE_NODE_LOG=NO npm install -g @alicloud/agenthub --registry=https://registry.npm.taobao.org

COPY default.config.js /root
COPY start-agenthub.sh /

ENTRYPOINT ["/start-agenthub.sh"]
