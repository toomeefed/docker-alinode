# Official Docker Image for alinode

> alinode 官网镜像模板

详细原理请看《[alinode 官方镜像分析并提取 Dockerfile](http://www.52cik.com/2018/10/01/docker-alinode-dockerfile.html)》。

从阿里官网镜像中提取的 Dockerfile 模板。

## 特别说明

`Dockerfile-3` 是可构建的。  
`Dockerfile-3-alpine` 是不可构建的，因为他是多阶段构建 (multi-stage build)，前一阶段构建的镜像完全丢弃，所以不能得知具体发生了什么。

但可以看我魔改过的版本。  
[3/Dockerfile](https://github.com/toomeefed/docker-alinode/blob/master/3/Dockerfile) 目录对应的 `Dockerfile-3` 版本。  
[3-alpine/Dockerfile](https://github.com/toomeefed/docker-alinode/blob/master/3-alpine/Dockerfile) 目录对应的 `Dockerfile-3-alpine` 版本。

根据自己的需求魔改吧。
