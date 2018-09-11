#!/bin/bash

if [ $1 = "3" ]; then
  docker build -f 3/Dockerfile -t toomee/alinode:3 context
  exit;
fi

if [ $1 = "3-slim" ]; then
  docker build -f 3-slim/Dockerfile -t toomee/alinode:3-slim context
  exit;
fi

if [ $1 = "3-tnvm" ]; then
  docker build -f 3-tnvm/Dockerfile -t toomee/alinode:3-tnvm context
  exit;
fi
