#!/bin/bash

#Add colour to the shell output
RED='\033[0;31m'
WHITE='\033[0;37m' 
NC='\033[0m' # No Color

echo -e "${RED}RUN THIS SCRIPT AS SUDO USER${WHITE}"

if [ $# -eq 1 ]; then
    echo -e "Target ${RED}IP:$1${WHITE}"
else
    echo "Your command line is incorrect"
    echo -e "Usuage example: ${RED} sudo ./nmapScans.sh 10.10.10.121 ${WHITE}"
    exit 1
fi

#Get the date, will be used in filename
DATE=`date +%Y-%m-%d`
filename=$1_$DATE

echo -e "Running a ${RED}quick scan ${WHITE}first ......"
# Quick scan
nmap -T4 -F $1 > quick_nmapscan_$filename.txt &
echo -e "Results -> ${RED}quick_nmapscan_$filename.txt${WHITE}"

echo -e "Running ${RED}Intense scan plus UDP ${WHITE}scan now ......"
#Intense scan plus UDP
nmap -sS -sU -T4 -A -v $1 > intense_nmapscan_$filename.txt &
echo -e "Results -> ${RED}intense_nmapscan_$filename.txt${WHITE}"


echo -e "Running ${RED}Slow Comprehensive ${WHITE}scan ......"
# Slow comprehensive scan
nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 –script 'default or (discovery and safe)' $1 > slowFull_nmapscan_$filename.txt &
echo -e "Results -> ${RED}slowFull_nmapscan_$filename.txt${WHITE}"

echo "Check files for results."
echo -e "Note slow scan can take ${RED}2 hours ${WHITE}....."

exit 0