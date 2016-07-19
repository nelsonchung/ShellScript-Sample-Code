#command format
#./nelsongre.sh [ipv4/ipv6](-4/-6) cable_modem_ip vlan_enable(0/vlanid)

# Global variable
greinterface="gre12"
vlaninterface="vlan12"
#default value
greinterfaceip="10.120.110.163"
vlaninterfaceip="10.120.110.130"
vlanid="0"

# Runtime variable

if [ "$1" == "-4" ] ;then
    gretype="v4"
else
    gretype="v6"
fi

#default value
if [ "$gretype" == "v4" ] ;then
    cmip="172.16.95.20"
    #cmip="172.16.90.179"
    #cmip="172.16.75.36"
    #cmip="172.16.180.204"
else
    cmip="2002:db50:fa13:43:98c7:d820:6a2b:3adc"
fi

if [ "$2" != "" ] ;then
    echo "Gre interface is $2"
    enable_gre_interface=$2
fi

if [ "$3" != "" ] ;then
    echo "Update cmip with value $3"
    cmip=$3
fi

if [ "$4" != "0" ] && [ "$4" != "" ] ;then
    echo "Update vlanid with value $4"
    vlanid=$4
fi

if [ "$gretype" == "v4" ] ;then
    echo "ipv4"
    var_type="gretap"
else
    echo "ipv6"
    #var_type="ip6gre"  #Nelson test and not workable
    var_type="ip6gretap"
fi

##################################Start Establish Gre Tunnel####################################################
##################################Delete CurrentGre Tunnel####################################################
ifconfig | grep $vlaninterface > /dev/null
ret=`echo $?`
if [ 0 == $ret ] ;then
    #del vlan interface
    echo "delete vlan interface: $vlaninterface"
    sudo ifconfig $vlaninterface down
    sudo ip link del $vlaninterface
fi
ifconfig | grep $greinterface > /dev/null
ret=`echo $?`
if [ 0 == $ret ] ;then
    #del gre interface
    echo "delete gre interface: $greinterface"
    sudo ifconfig $greinterface down
    sudo ip link del $greinterface
fi

if [ "$gretype" == "v4" ] ;then
    #eth0ip=`ifconfig eth0 | grep "inet addr" | sed 's/inet addr://g' | awk '{print $1}'`
    #eth0ip=`ifconfig wlan0 | grep "inet addr" | sed 's/inet addr://g' | awk '{print $1}'`
    enable_gre_interface_ip=`ifconfig $enable_gre_interface | grep "inet addr" | sed 's/inet addr://g' | awk '{print $1}'`
else
    #eth0ip=`ifconfig eth0 | grep "inet6 addr" | grep "Scope:Global" | sed 's/inet6 addr://g' | sed 's/\// /g' | awk '{print $1}'`
    #eth0ip=`ifconfig wlan0 | grep "inet6 addr" | grep "Scope:Global" | sed 's/inet6 addr://g' | sed 's/\// /g' | awk '{print $1}'`
    enable_gre_interface_ip=`ifconfig $enable_gre_interface | grep "inet6 addr" | grep "Scope:Global" | sed 's/inet6 addr://g' | sed 's/\// /g' | awk '{print $1}'`
fi
echo "gre server ip address: "$eth0ip
echo "can accept "$cmip" from cable modem"

##################################Add Gre Tunnel####################################################
if [ "$gretype" == "v4" ] ;then
    echo "Add gre interface: $greinterface"
    #echo "sudo ip link add $greinterface type $var_type remote $cmip local $eth0ip"
    #sudo ip link add $greinterface type $var_type remote $cmip local $eth0ip
    sudo ip link add $greinterface type $var_type remote $cmip local $enable_gre_interface_ip
else
    #Do the following command or you will get the error "RTNETLINK answers: Operation not supported" - Start
    #sudo ip link add $greinterface type ip6gre remote $cmip local $eth0ip
    sudo ip link add $greinterface type ip6gre remote $cmip local $enable_gre_interface_ip
    sudo ip link del $greinterface
    #Do the following command or you will get the error "RTNETLINK answers: Operation not supported" - End 
    #sudo ip link add $greinterface type $var_type remote $cmip local $eth0ip
    sudo ip link add $greinterface type $var_type remote $cmip local $enable_gre_interface_ip
fi
echo "ifconfig $greinterface $greinterfaceip"
sudo ifconfig $greinterface $greinterfaceip
#if [ "$gretype" == "v4" ] ;then
    #sudo ifconfig $greinterface up #it is workable, but Nelson want to test ip link
#    sudo ip link set $greinterface up
#else
#    sudo ip link set $greinterface up
#fi
sudo ip link set $greinterface up

#add vlan interface
if [ "$vlanid" != "0" ] ;then
    echo "Add vlan interface: $vlaninterface"
    sudo ip link add link $greinterface name $vlaninterface type vlan id $vlanid
    sudo ip addr add $vlaninterfaceip/24 dev $vlaninterface
    sudo ifconfig $vlaninterface up
fi

##################################Restart Dhcp Server####################################################
echo "Restart Dhcp Server."
sudo service isc-dhcp-server restart
./makegregoworld.sh
