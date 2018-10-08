# docker-alinode

Node.js 性能平台 - Node.js Performance Platform  

> 集成 alinode + yarn + pm2 + agenthub  
> 自动启动 agenthub 服务，让你可以像 pm2 镜像一样方便使用。  

[GitHub](https://github.com/toomeefed/docker-alinode)
|
[Docker Store](https://store.docker.com/community/images/toomee/alinode)
|
[《Node.js性能平台运行时版本和官方对应列表》](https://help.aliyun.com/knowledge_detail/60811.html)
|
[《官网 Dockerfile 模板》](https://github.com/toomeefed/docker-alinode/tree/master/official)

## 标签对应关系

镜像 | 镜像大小 | 基础镜像 | AliNode | Node | Dockerfile
:-- | :-- | :-- | :-- | :-- | :--
toomee/alinode:3 | 217MB | debian:8 | v3.12.0 | v8.12.0 | [Dockerfile](https://github.com/toomeefed/docker-alinode/blob/master/3/Dockerfile)
toomee/alinode:3-slim | 159MB | debian:8-slim | v3.12.0 | v8.12.0 | [Dockerfile](https://github.com/toomeefed/docker-alinode/blob/master/3-slim/Dockerfile)
toomee/alinode:3-alpine | 90.9MB | alpine:3.6 | v3.12.0 | v8.12.0 | [Dockerfile](https://github.com/toomeefed/docker-alinode/blob/master/3-alpine/Dockerfile) [推荐]

### 所有镜像

```sh
$ docker images toomee/alinode
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
toomee/alinode      3-alpine            e7d60ba066ec        9 minutes ago       90.9MB
toomee/alinode      3.12-alpine         e7d60ba066ec        9 minutes ago       90.9MB
toomee/alinode      3.12.0-alpine       e7d60ba066ec        9 minutes ago       90.9MB
toomee/alinode      3                   b2c687008376        32 hours ago        217MB
toomee/alinode      3-slim              baca97ca02d4        32 hours ago        159MB
```

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
$ docker pull toomee/alinode:3-alpine
```

### 1. 直接启动

到当前项目目录下执行如下命令：

```sh
$ docker run -d \
  -p 8000:8000 \
  -v $PWD:/app \
  -e "APP_ID=应用ID" \
  -e "APP_SECRET=应用密钥" \
  -h my-alinode \
  --name my-alinode \
  toomee/alinode:3-alpine
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
  -v $PWD:/app \
  -h my-alinode \
  --name my-alinode \
  toomee/alinode:3-alpine
```

### 常用命令

命令 | 描述
:-- | :--
`$ docker exec my-alinode pm2 monit` | 监控每个进程 CPU 使用情况
`$ docker exec my-alinode pm2 list` | 列出进程
`$ docker exec my-alinode pm2 logs` | 查看日志
`$ docker exec my-alinode pm2 reload all` | 无缝重启所有进程

**PS: 具体使用说明看 PM2 和 alinode 文档**


## 高级应用

多环境基于配置部署方案：

添加 `alinode.config.json`, `alinode.config.pre.json` 到根目录。

启动 pre 环境容器：

```sh
$ docker run -d \
  -p 8000:8000 \
  -v $PWD:/app \
  -e "ALINODE_CONFIG=alinode.config.pre.json" \
  -h my-alinode \
  --name my-alinode \
  toomee/alinode:3-alpine
```

启动 正式 环境容器：

```sh
$ docker run -d \
  -p 8000:8000 \
  -v $PWD:/app \
  -h my-alinode \
  --name my-alinode \
  toomee/alinode:3-alpine
```

## docker-compose

也可以使用 docker-compose.yml 启动。

```yml
web:
  image: toomee/alinode:3-alpine
  restart: always
  hostname: my-alinode
  container_name: my-alinode
  environment:
    APP_ID: 应用ID
    APP_SECRET: 应用密钥
    # 或者使用自定义环境配置
    # ALINODE_CONFIG: alinode.config.pre.json
  ports:
    - 8000:8000
  volumes:
    - $PWD:/app
```

常用命令

```sh
$ docker-compose pull    # 更新/拉取镜像
$ docker-compose up -d   # 创建并启动
$ docker-compose restart # 重启容器
$ docker-compose down    # 关闭并删除
```

## 特别说明

`-h my-alinode` 是容器 hostname 最终会显示在 <https://node.console.aliyun.com/> 平台实例列表中。
如果不写，会显示默认容器名，也就是随机值。

## 自定义

推荐自定义修改 Dockerfile 然后构建合适自己的镜像。  
由于官网还没开源，所以 Dockerfile 也是未知的，官方镜像就像是黑匣子。  
这个是我研究官网镜像总结出来的，是基于官网镜像直接抽取的，兼容性目前来看没啥问题。  
有问题，欢迎反馈。
