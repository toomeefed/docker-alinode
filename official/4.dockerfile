FROM node:8

RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

ENV ALINODE_VERSION=4.5.0
ENV ARCH=x64
ENV ENABLE_NODE_LOG=YES
ENV NODE_LOG_DIR=/tmp
ENV HOME=/root

RUN curl -fsSLO --compressed "http://alinode.aliyun.com/dist/new-alinode/v$ALINODE_VERSION/alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz" \
  && curl -fsSLO --compressed "http://alinode.aliyun.com/dist/new-alinode/v$ALINODE_VERSION/SHASUMS256.txt" \
  && grep " alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -zxvf "alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "alinode-v$ALINODE_VERSION-linux-$ARCH.tar.gz" SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && ENABLE_NODE_LOG=NO npm install -g @alicloud/agenthub

COPY default.config.js /root
COPY start-agenthub.sh /

ENTRYPOINT ["/start-agenthub.sh"]
