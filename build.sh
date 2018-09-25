#!/bin/bash

set -e

# 默认 tag 3
tag=${1:-3}

if [ ! -d $tag ]; then
  echo "no such tag: $tag"
  exit -1
fi

docker build -f $tag/Dockerfile -t toomee/alinode:$tag context

echo
echo "✨  toomee/alinode:$tag is done!"
echo
docker images toomee/alinode:$tag
echo
docker run --rm toomee/alinode:$tag sh -c 'echo "alinode v$ALINODE_VERSION" && echo "node $(node -v)" && echo "npm v$(npm -v)" && echo "yarn v$(yarn -v)" && echo "pm2 v$(pm2 -v)"'
echo
