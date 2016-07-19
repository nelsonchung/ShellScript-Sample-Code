echo "Input the destination ip address:"
read destipaddr

echo "Choose the command you want:"
echo "1. Firewall port scan (UDP)"
echo "2. Firewall ip flood (TCP)"
read option

if [ $option == 1 ];then
    #sudo nmap -sU -max-retries 0 -min-rate 100 -PN -r -p1-65535 $destipaddr
fi

if [ $option == 2 ];then
    #sudo nmap -sS -max-retries 0 -min-rate 100 -PN -r -p1-65535 $destipaddr
fi
