#!/bin/bash

# 例子
# sh build.sh 3-alpine 3.13-alpine 3.13.0-alpine

set -e

# 输入参数
tag=${1:-3}

# 版本
version=${tag/-*/}
# 版本标签
tagname=${tag/*-/}

# 对应目录
dir="$version/$tagname"

# 如果没标签，默认 jessie 版本
if [ "$version" = "$tagname" ]; then
  dir="$version/jessie"
fi

# 判断目录是否存在
if [ ! -d $dir ]; then
  echo "no such tag: $tag"
  exit -1
fi

# 构建镜像
docker build -f $dir/Dockerfile -t toomee/alinode:$tag context

echo
echo "✨ toomee/alinode:$tag is done!"
echo

if [ $# -gt 1 ]; then
  for ((i=2; i<=$#; i++)); do
    echo "Create tag $tag -> ${!i}"
    docker tag toomee/alinode:$tag toomee/alinode:${!i}
  done
fi

echo

if [ "$version" = "$tagname" ]; then
  docker images toomee/alinode:$tag*
else
  docker images toomee/alinode:$version*-$tagname
fi

echo
docker run --rm toomee/alinode:$tag sh -c 'echo "alinode v$ALINODE_VERSION" && echo "node $(node -v)" && echo "npm v$(npm -v)" && echo "yarn v$(yarn -v)" && echo "pm2 v$(pm2 -v)"'
echo
