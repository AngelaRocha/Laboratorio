ip_Local=$1
ip_Publica=$2
nmap $ip_Local
nmap --script vuln $ip_Local
nmap $ip_Publica
nmap --script vuln $ip_Publica
