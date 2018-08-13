# docker-alinode

> Node.js 性能平台 - Node.js Performance Platform

## alinode + yarn + pm2

> Node.js性能平台运行时版本和官方对应列表
> <https://help.aliyun.com/knowledge_detail/60811.html>


## Tags available

Image Name | Operating system | Node | Dockerfile
:-- | :-- | :-- | :--
toomee/alinode:3 | Centos7 | v8.11.3 | [3](https://github.com/toomeefed/docker-alinode/blob/master/3/Dockerfile)

## Usage

假设你的项目是如下结构

```
.
├── src
│   └── app.js
├── package.json
├── pm2.json
└── README.md
```

拉取镜像

```sh
$ docker pull toomee/alinode:3
$ docker run -d \
  -p 8000:8000 \
  -v $(pwd):/app \
  -e "APP_ID=应用ID" \
  -e "APP_SECRET=应用密钥" \
  -h my-alinode \
  --name my-alinode \
  toomee/alinode:3
```

### 常用命令

命令 | 描述
:-- | :--
`$ docker exec my-alinode pm2 monit` | 监控每个进程 CPU 使用情况
`$ docker exec my-alinode pm2 list` | 列出进程
`$ docker exec my-alinode pm2 logs` | 查看日志
`$ docker exec my-alinode pm2 reload all` | 无缝重启所有进程

**PS: 具体使用说明看 PM2 和 alinode 文档**
