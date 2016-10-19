echo "1. Add gre ipv4 tunnel."
echo "2. Add gre ipv4 tunnel with vlan."
echo "3. Add gre ipv6 tunnel."
echo "4. Add gre ipv6 tunnel with vlan."
read userinput

#General Setting
cable_modem_ipv4_vlan_id="100"
cable_modem_ipv6_vlan_id="1001"

#support gre server can get gre packet from eth0 or wlan0
interface_name="eth0"
#if you set interface_name to wlan0, you need to run setroute.sh
#interface_name="wlan0"
#setroute.sh
#6640
cable_modem_ipv4_ip="172.16.90.53"
#cable_modem_ipv6_ip="2002:db50:fa13:43:98c7:d820:6a2b:3adc"
#cable_modem_ipv4_ip="172.16.95.38"
#cable_modem_ipv6_ip="2002:db50:fa13:90:2cc1:4b80:7594:c1ef"
#7465
#cable_modem_ipv4_ip="172.16.95.111"
#cable_modem_ipv6_ip="2002:db50:fa13:90:71dd:d824:6f48:a40c"
#For anderson
#cable_modem_ipv4_ip="172.16.95.34"
#cable_modem_ipv6_ip="2002:db50:fa13:90:71dd:d824:6f48:a40c"
#cable_modem_ipv4_vlan_id="501"
#6643
#cable_modem_ipv4_ip="172.16.21.29"
cable_modem_ipv4_ip="172.16.90.91"
#cable_modem_ipv4_ip="172.16.95.39"

if [ "1" == "$userinput" ] ;then
    ./nelsongre.sh -4 $interface_name $cable_modem_ipv4_ip
elif [ "2" == "$userinput" ] ;then
    ./nelsongre.sh -4 $interface_name $cable_modem_ipv4_ip $cable_modem_ipv4_vlan_id
elif [ "3" == "$userinput" ] ;then
    ./nelsongre.sh -6 $interface_name $cable_modem_ipv6_ip
elif [ "4" == "$userinput" ] ;then
    ./nelsongre.sh -6 $interface_name $cable_modem_ipv6_ip $cable_modem_ipv6_vlan_id
else
    echo "Not support"
fi
