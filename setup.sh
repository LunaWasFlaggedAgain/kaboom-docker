printf "Please enter the port for the mc server (default: 25565): "
read SERVER_PORT
printf "Please enter the port for the geyser proxy (default 19132): "
read GEYSER_PORT

SERVER_PORT=${SERVER_PORT:-25565}
GEYSER_PORT=${GEYSER_PORT:-19132}

echo "Setting up MC on port $SERVER_PORT and geyser on $GEYSER_PORT"





git clone https://github.com/kaboomserver/server.git server

sed -i "s/25565/$SERVER_PORT/" server/server.properties
sed -i "s/19132/$GEYSER_PORT/" server/plugins/Geyser-Spigot/config.yml

sudo iptables -t nat -A INPUT -p tcp --dport $SERVER_PORT -j SNAT --to-source 192.168.1.0-192.168.100.100
sudo iptables -A INPUT -p tcp --syn --dport $SERVER_PORT -m connlimit --connlimit-above 5 --connlimit-mask 32 -j REJECT --reject-with tcp-reset
sudo ip6tables -t nat -A INPUT -p tcp --dport $SERVER_PORT -j SNAT --to-source 2001:db8::1-2001:db8::6464
sudo ip6tables -A INPUT -p tcp --syn --dport $SERVER_PORT -m connlimit --connlimit-above 5 --connlimit-mask 32 -j REJECT --reject-with tcp-reset

sudo iptables -t nat -A INPUT -p udp --dport $GEYSER_PORT -j SNAT --to-source 192.168.1.0-192.168.100.100
sudo ip6tables -t nat -A INPUT -p udp --dport $GEYSER_PORT -j SNAT --to-source 2001:db8::1-2001:db8::6464

sudo docker-compose build
sudo docker-compose up -d