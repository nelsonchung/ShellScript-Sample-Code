#######DEFINE##########
account="private"
IP="172.16.90.164"
#IP="172.16.21.31"
SNMPWALK="snmpwalk -c private -v2c $IP"
SNMPSET="snmpset -c private -v2c $IP"
SNMPGET="snmpget -c private -v2c $IP"

#######DEFINE - OID##########
iso="1"
org="3"
dod="6"
internet="1"

mgmt="2"
mib_2="1"
docsDev="69"
docsDevMIBObjects="1"

docsDevSoftware=$iso.$org.$dod.$internet.$mgmt.$mib_2.$docsDev.$docsDevMIBObjects."3"

#docsDevEvent="5"
docsDevEvent=$iso.$org.$dod.$internet.$mgmt.$mib_2.$docsDev.$docsDevMIBObjects."5"
docsDevEvControl=$docsDevEvent."1.0"

private="4"
enterprises="1"
#cableLabs="4491"
cableLabs=$iso.$org.$dod.$internet.$private.$enterprises."4491"
docsIf3CmEventCtrlTable=$cableLabs."2.1.20.1.29" #1.3.6.1.4.1.4491.2.1.20.1.29


#cbn="35604"
cbn=$iso.$org.$dod.$internet.$private.$enterprises."35604"
cbnproducts=$cbn."1"
cm=$cbnproducts."19"
cmConfigPrivateBase=$cm."3"
cmConfigFreqObjects=$cmConfigPrivateBase."1"
nonfree_cmResetToDefaults=$cmConfigFreqObjects."18.0"
#wifi
cmdot11plus=$cm."51"
#wifi - 24G ssid
cmdot11plusObjects=$cmdot11plus."1"
cmdot11plusMgmtv2=$cmdot11plusObjects."5"
cmdot11MgmtMbss=$cmdot11plusMgmtv2."4"
cmdot11MbssBase=$cmdot11MgmtMbss."1"
cmdot11BssTable=$cmdot11MbssBase."14"
cmdot11BssEntry=$cmdot11BssTable."1"
cmdot11BssSsid=$cmdot11BssEntry."3"
#wifi - 5G ssid

cableModem=$cbn."2"
cmDocsisConfig=$cableModem."2"
cmDocsisBaseObjects=$cmDocsisConfig."1"
cmResetToDefaults=$cmDocsisBaseObjects."3.0"

########function#########
function chooseaction(){
    echo "Choose the action:"
    echo "1. Set"
    echo "2. Get"
    echo "3. Walk"
}
function list(){
    echo ""
    echo "===================================================================================="
    echo "List the spoort mib"
    count=1;
    echo $count". docsDevEvent($docsDevEvent)"
    count=`expr $count + 1`
    echo $count". docsDevEvControl($docsDevEvControl)"
    count=`expr $count + 1`
    echo $count". docsIf3CmEventCtrlTable($docsIf3CmEventCtrlTable)"
    count=`expr $count + 1`
    echo $count". cmResetToDefaults($cmResetToDefaults)"
    count=`expr $count + 1`
    echo $count". nonfree_cmResetToDefaults($nonfree_cmResetToDefaults)"
    count=`expr $count + 1`
    echo $count". docsDevSoftware($docsDevSoftware)"
    count=`expr $count + 1`
    echo "99. any OID you want"
}
function doaction(){
    if [ $1 -eq 1 ] ;then
#
#  TYPE: one of i, u, t, a, o, s, x, d, b
#    i: INTEGER, u: unsigned INTEGER, t: TIMETICKS, a: IPADDRESS
#        o: OBJID, s: STRING, x: HEX STRING, d: DECIMAL STRING, b: BITS
#            U: unsigned int64, I: signed int64, F: float, D: double
#
        echo "Please enter the type you wan to set"
        typecount=1;
        echo $typecount". i: INTEGER"
        typecount=`expr $typecount + 1`
        echo $typecount". u: unsigned INTEGER"
        typecount=`expr $typecount + 1`
        echo $typecount". s: STRING"
        typecount=`expr $typecount + 1`
        echo $typecount". x: HEX STRING"
        typecount=`expr $typecount + 1`
        echo $typecount". t: TIMETICKS"
        typecount=`expr $typecount + 1`
        echo $typecount". a: IPADDRESS"
        typecount=`expr $typecount + 1`
        echo $typecount". o: OBJID"
        typecount=`expr $typecount + 1`
        echo $typecount". d: DECIMAL STRING"
        typecount=`expr $typecount + 1`
        echo $typecount". b: BITS"
        typecount=`expr $typecount + 1`
        echo $typecount". U: unsigned int64"
        typecount=`expr $typecount + 1`
        echo $typecount". I: signed int64"
        typecount=`expr $typecount + 1`
        echo $typecount". F: float"
        typecount=`expr $typecount + 1`
        echo $typecount". D: double"
        typecount=`expr $typecount + 1`

        read typevalue
        if [ $typevalue -eq 1 ] ;then
            typecmd="i"
        elif [ $typevalue -eq 2 ] ;then
            typecmd="u"
        elif [ $typevalue -eq 3 ] ;then
            typecmd="s"
        elif [ $typevalue -eq 4 ] ;then
            typecmd="x"
        elif [ $typevalue -eq 5 ] ;then
            typecmd="t"
        elif [ $typevalue -eq 6 ] ;then
            typecmd="a"
        elif [ $typevalue -eq 7 ] ;then
            typecmd="o"
        elif [ $typevalue -eq 8 ] ;then
            typecmd="d"
        elif [ $typevalue -eq 9 ] ;then
            typecmd="b"
        elif [ $typevalue -eq 10 ] ;then
            typecmd="U"
        elif [ $typevalue -eq 11 ] ;then
            typecmd="I"
        elif [ $typevalue -eq 12 ] ;then
            typecmd="F"
        elif [ $typevalue -eq 13 ] ;then
            typecmd="D"
        fi

        echo "Please input the value"
        read inputvalue
        echo "$SNMPSET $2 $typecmd $inputvalue"
        $SNMPSET $2 $typecmd $inputvalue
    elif [ $1 -eq 2 ] ;then
        $SNMPGET $2
    elif [ $1 -eq 3 ] ;then
        $SNMPWALK $2
    fi
}
function chooseoption(){
echo "Choose the option:"
read option
#snmpset -c private -v2c $IP
if [ $option -eq 1 ];then
    OID=$docsDevEvent
elif [ $option -eq 2 ];then
    OID=$docsDevEvControl
elif [ $option -eq 3 ];then
    OID=$docsIf3CmEventCtrlTable
elif [ $option -eq 4 ];then
    OID=$cmResetToDefaults
elif [ $option -eq 5 ];then
    OID=$nonfree_cmResetToDefaults
elif [ $option -eq 6 ];then
    OID=$docsDevSoftware
elif [ $option -eq 99 ];then
    read OID
fi
}
########start############
while [ 1 ]
do

list
chooseoption
chooseaction
read actiontype
doaction $actiontype $OID 

done
