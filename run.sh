#!/bin/bash

port=18888

while getopts p: OPT; do
  case $OPT in
    p) port=$OPTARG ;;
  esac
done

docker run -it \
           --rm \
           --gpus all \
           -v $(pwd)/pretrain:/root/voice-changer/server/pretrain \
           -v $(pwd)/models:/root/voice-changer/server/models \
           -p "$port":"$port" \
           vcclient \
           -p "$port"
