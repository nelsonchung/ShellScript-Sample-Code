echo "1. for PUMA5 realtek"
echo "2. for PUMA6 celeno"
read option

if [ $option == "1" ] ;then
gtkterm -p /dev/ttyUSB0 -s 38400& 
else
gtkterm -p /dev/ttyUSB0 -s 115200& 
fi
