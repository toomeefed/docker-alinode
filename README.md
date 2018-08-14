# docker-alinode

Node.js 性能平台 - Node.js Performance Platform  

> 集成 alinode + yarn + pm2 + agenthub  
> 自动启动 agenthub 服务，让你可以像 pm2 镜像一样方便使用。  


[《Node.js性能平台运行时版本和官方对应列表》](https://help.aliyun.com/knowledge_detail/60811.html)

## 标签对应关系

Image Name | Operating system | Node | Dockerfile
:-- | :-- | :-- | :--
toomee/alinode:3 | Centos7 | v8.11.3 | [3](https://github.com/toomeefed/docker-alinode/blob/master/3/Dockerfile)
toomee/alinode:3.11.5 | Centos7 | v8.11.3 | [3](https://github.com/toomeefed/docker-alinode/blob/master/3/Dockerfile)

## 使用说明

假设你的项目是如下结构

```
.
├── src
│   └── app.js
├── package.json
├── ecosystem.config.js
└── README.md
```

### 拉取镜像

```sh
$ docker pull toomee/alinode:3
```

### 1. 直接启动

到当前项目目录下执行如下命令：

```sh
$ docker run -d \
  -p 8000:8000 \
  -v $(pwd):/app \
  -e "APP_ID=应用ID" \
  -e "APP_SECRET=应用密钥" \
  -h my-alinode \
  --name my-alinode \
  toomee/alinode:3
```

### 2. 基于配置启动

项目跟目录创建 `alinode.config.json` 内容如下：

> [Agenthub 文档](https://github.com/aliyun-node/agenthub)

```json
{
  "appid": "<YOUR APPID>",
  "secret": "<YOUR SECRET>",
  "logdir": "/tmp/",
  "error_log": [
    "</path/to/your/error.log>",
    "您的应用在业务层面产生的异常日志的路径",
    "例如：/root/.logs/error.#YYYY#-#MM#-#DD#-#HH#.log",
    "可选"
  ],
  "packages": [
    "</path/to/your/package.json>",
    "可以输入多个package.json的路径",
    "可选"
  ]
}
```

然后启动容器：

```sh
$ docker run -d \
  -p 8000:8000 \
  -v $(pwd):/app \
  -h my-alinode \
  --name my-alinode \
  tm/alinode:3
```

### 常用命令

命令 | 描述
:-- | :--
`$ docker exec my-alinode pm2 monit` | 监控每个进程 CPU 使用情况
`$ docker exec my-alinode pm2 list` | 列出进程
`$ docker exec my-alinode pm2 logs` | 查看日志
`$ docker exec my-alinode pm2 reload all` | 无缝重启所有进程

**PS: 具体使用说明看 PM2 和 alinode 文档**
