sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
