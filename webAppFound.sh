#!/bin/bash

#Add colour to the shell output
RED='\033[0;31m'
WHITE='\033[0;37m' 
NC='\033[0m' # No Color

if [ $# -eq 2 ]; then
    echo "Your IP and PORT"
    echo -e "${WHITE}IP Address: ${RED}$1"
    echo -e "${WHITE}PORT Number: ${RED}$2 ${WHITE}"
else
    echo "Your command line contains no arguments"
    echo -e "${WHITE}Usuage example: ${RED} ./webAppFound.sh 10.10.10.121 80 ${WHITE}"
    exit 1
fi

#Get the date, will be used in filename
DATE=`date +%Y-%m-%d`
filename=$1_$DATE

echo "Lets run gobuster ......"
gobuster -e -u http://$1:$2 -w /Users/keithreilly/Documents/EHInfo/HTB/wordlists/common.txt > gobuster_$filename.txt 
echo -e "${WHITE}gobuster results stored in file ${RED}gobuster_$filename.txt ${WHITE}"

echo "Running Nikto Scan ......"
echo "This may take a few mins...."
nikto --host $1:$2 > nikto_$filename.txt &
echo -e "${WHITE}nikto results stored in the file ${RED}nikto_$filename.txt ${WHITE}"

echo "Scanning done."
echo -e "${WHITE}Wait a few minutes for scans to finish"

exit 0