#!/bin/bash
cd $1
docker-compose -f $2 down
killall -9 bitcoind
echo "Running $2 at $1"
nohup docker-compose -f $2 up > dockerRunning.log &
cat dockerRunning.log
echo success
