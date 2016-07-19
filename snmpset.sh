IP="172.16.90.39"
CBNOID="1.3.6.1.4.1.35604"
gwFilterLanFilterEntry="2.4.1.8.1.4.2.1"
gwFilterLanFilterEnabled=$gwFilterLanFilterEntry".11"
gwFilterLanFilterRowStatus=$gwFilterLanFilterEntry".12"

##start set
snmpset -c private -v2c $IP "$CBNOID"."$gwFilterLanFilterEnabled".1 integer 1
snmpset -c private -v2c $IP "$CBNOID"."$gwFilterLanFilterRowStatus".1 integer 1
