#!/bin/bash

./build.sh 3 3.15 3.15.0
./build.sh 3-slim 3.15-slim 3.15.0-slim
./build.sh 3-alpine 3.14-alpine 3.14.1-alpine

./build.sh 4 4.8 4.8.0
./build.sh 4-slim 4.8-slim 4.8.0-slim
./build.sh 4-alpine 4.7-alpine 4.7.0-alpine

./build.sh 5 5.6 5.6.0
./build.sh 5-slim 5.6-slim 5.6.0-slim
