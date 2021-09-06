#!/bin/bash

sleep 100 # wait for server to start

while true; do
    sleep 15

    if [ "$(env printf '\xFE' | nc -w 15 127.0.0.1 25565 | wc -m)" -eq 0 ]; then
        kill -9 1
        echo Killed
    fi
done
