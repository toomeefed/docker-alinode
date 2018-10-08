'use strict';

const fs = require('fs');

const defaults = {
  "server": "wss://agentserver.node.aliyun.com:8080",
  "appid": `${process.env.APP_ID}`,
  "secret": `${process.env.APP_SECRET}`,
  "heartbeatInterval": 60,
  "reconnectDelay": 10,
  "reportInterval": 60,
  "logdir": `${process.env.NODE_LOG_DIR}`,
  "error_log": []
};

var custom = {};

if (fs.existsSync(`${process.env.HOME}/app-config.json`)) {
  custom = require(`${process.env.HOME}/app-config.json`);
}

if (!custom.appid && defaults.appid) {
  delete custom.appid;
}

if (!custom.secret && defaults.secret) {
  delete custom.secret;
}

const config = Object.assign(defaults, custom);

if (config.appid !== 'undefined' && config.secret !== 'undefined') {
  if (config.logdir === 'undefined') {
    config.logdir = '/tmp';
  }
  fs.writeFileSync(`${process.env.HOME}/agenthub-running.json`, JSON.stringify(config));
}
