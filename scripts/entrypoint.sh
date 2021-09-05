#!/bin/bash

while true; do
    java -Xms$MEMORY -Xmx$MEMORY $JAVA_ARGS -jar server.jar -nogui
    rm -rf worlds

    if [ $AUTO_UPDATE = "1" ]; then
        git pull
    fi

    sleep 5
done