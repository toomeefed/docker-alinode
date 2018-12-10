const fs = require('fs');

const defaults = {
  // server: 'wss://agentserver.node.aliyun.com:8080',
  heartbeatInterval: 60,
  reconnectDelay: 10,
  reportInterval: 60,
  logdir: '/tmp',
  error_log: [],
  packages: [],
};

let custom = {};

// load /app/alinode.config.json
if (fs.existsSync(`${process.env.APP_DIR}/${process.env.ALINODE_CONFIG}`)) {
  custom = require(`${process.env.APP_DIR}/${process.env.ALINODE_CONFIG}`);
}

if (fs.existsSync(`${process.env.APP_DIR}/package.json`)) {
  defaults.packages.push(`${process.env.APP_DIR}/package.json`);
}

const config = Object.assign(defaults, custom);

config.appid = config.appid || process.env.APP_ID;
config.secret = config.secret || process.env.APP_SECRET;
config.logdir = config.logdir || process.env.NODE_LOG_DIR || '/tmp';

if (config.appid && config.secret) {
  const runningCfg = `${process.env.HOME}/agenthub-running.json`;
  fs.writeFileSync(runningCfg, JSON.stringify(config, null, 2));
}
