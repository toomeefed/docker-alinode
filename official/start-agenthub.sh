#!/bin/sh


ENABLE_NODE_LOG=NO node $HOME/default.config.js

if [ -f $HOME/agenthub-running.json ]; then
  ENABLE_NODE_LOG=NO agenthub $HOME/agenthub-running.json &
fi

exec "$@"
