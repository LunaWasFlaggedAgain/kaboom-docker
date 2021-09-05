#!/bin/bash

if [ "$(env printf '\xFE' | nc -w 15 127.0.0.1 25565 | wc -m)" -eq 0 ]; then
    kill -9 -1
fi
exit 0