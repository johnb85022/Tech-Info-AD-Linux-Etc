# go-dnsenum.sh
# simple bash to drive a command , dnsenu, I put the vars in the 
# script so would run the same way each time, 
# the line is the DNS server ip , the var are comma sep, 
###
LIST="10.92.133.10,myfoo.com.
10.176.101.130,secureless.com.
192.168.25.3,bincorp.com.
10.91.8.10,tellme.com."

for x in $LIST
do

#echo "${x}"
MYIP="${x%,*}"
MYDOM="${x#*,}"
printf "Running %s with %s ...\n" $MYIP $MYDOM

# Example
##dnsenum --dnsserver 10.92.133.10 --noreverse -o dns.BBINSGLOBAL.COM.file.xml BBINSGLOBAL.COM

#dnsenum --dnsserver "$MYIP" --noreverse -o "$MYDOM".dns.xml "$MYDOM"
dnsenum --dnsserver "$MYIP" --noreverse -nocolor "$MYDOM" | tee "$MYDOM"dns.txt

done
###
