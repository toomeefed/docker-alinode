FROM centos:7

USER root

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN yum install wget -y

# Change mirrors
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

ENV HOME /root

# Install alinode v3.11.8 (node v8.11.4)
ENV ALINODE_VERSION 3.11.8
ENV TNVM_DIR /root/.tnvm

RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash

RUN source $HOME/.bashrc \
&& tnvm install "alinode-v$ALINODE_VERSION" \
&& tnvm use "alinode-v$ALINODE_VERSION" \
&& npm set registry https://registry.npm.taobao.org \
&& npm i -g yarn \
&& yarn global add pm2 @alicloud/agenthub

# add node and npm to path so the commands are available
ENV NODE_PATH $TNVM_DIR/versions/alinode/v$ALINODE_VERSION/lib/node_modules
ENV PATH      $TNVM_DIR/versions/alinode/v$ALINODE_VERSION/bin:$PATH

# Work dir
ENV APP_DIR /app
WORKDIR /app

# alinode config
COPY default.config.js $HOME
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

# Application environment variable
ENV NODE_LOG_DIR /tmp
ENV ENABLE_NODE_LOG YES
ENV ALINODE_CONFIG alinode.config.json
ENV NODE_ENV production

CMD ["pm2-runtime", "start", "ecosystem.config.js"]
