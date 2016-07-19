
echo "Choose the command you want:"
echo "1. sudo nmap –sS –max-retries 0 –min-rate 1000 –PN –r –p1-65535 172.16.90.179 (for CH6640)"
echo "2. sudo nmap –sS –max-retries 0 –min-rate 1000 –PN –r –p1-65535 172.16.90.39 (for CH7465)"
echo "3. sudo nmap –sS –max-retries 0 –min-rate 1000 –PN –r –p1-65535 192.168.0.1"
read option

#echo "Please input the target ip address you want to test:"
#read target
#target="172.16.90.39"
target="172.16.90.179"
#target="192.168.0.1"
if [ $option == 1 ];then
target="172.16.90.179"
sudo nmap -sS -max-retries 0 -min-rate 1000 -PN -r -p1-65535 $target
elif [ $option == 2 ];then
target="172.16.90.39"
sudo nmap -sS -max-retries 0 -min-rate 1000 -PN -r -p1-65535 $target
elif [ $option == 3 ];then
target="192.168.0.1"
sudo nmap -sS -max-retries 0 -min-rate 1000 -PN -r -p1-65535 $target
fi
