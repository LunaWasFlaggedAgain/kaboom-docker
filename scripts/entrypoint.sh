#!/bin/bash

rm -rf worlds

if [ ! -f "/server/server.jar" ]; then
    git clone https://github.com/kaboomserver/server.git /server
elif [ $AUTO_UPDATE = "1" ]; then
    git pull
fi

/scripts/alivecheck.sh &

exec java -Xms$MEMORY -Xmx$MEMORY $JAVA_ARGS -jar server.jar -nogui
