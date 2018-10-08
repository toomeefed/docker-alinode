# FROM alpine:3.6 as builder
# 通过源码编译

FROM alpine:3.6 as prod

ENV HOME=/root
ENV ALINODE_VERSION=alinode-v3.12.0
ENV ENABLE_NODE_LOG=YES
ENV NODE_LOG_DIR=/tmp
ENV YARN_VERSION=1.5.1

COPY default.config.js /root
COPY start-agenthub.sh /

# 复制前一阶段构建好的 alinode
# COPY --from=builder /usr/local /usr/local

RUN > /etc/apk/repositories \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/main/" >> /etc/apk/repositories \
  && echo "http://mirrors.aliyun.com/alpine/v3.6/community/" >> /etc/apk/repositories \
  && apk update \
  && addgroup -g 1000 node \
  && adduser -u 1000 -G node -s /bin/sh -D node \
  && apk add --no-cache \
      libstdc++ \
  && apk add --no-cache --virtual .build-deps-yarn curl gnupg tar \
  && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
  && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && mkdir -p /opt \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && apk del .build-deps-yarn

ENTRYPOINT ["/start-agenthub.sh"]
