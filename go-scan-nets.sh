#!/bin/bash
# Who, JB
# What, Peek at nets via nmap
# When, 04 of 2020
# Why, found a server with exploit on it, help inventory.

echo "Starting $(date) $0..."
INPUT=$1
D_STR=$(date "+%Y-%m-%d")

if [[ -a $INPUT ]]
        then
                echo "Working with $INPUT input file ..."
        else
                echo "Missing input file? $INPUT ..."
                exit
fi


echo "Starting $(date) $0 $INPUT ..."

mapfile file_array < "${INPUT}"

for ((i=0; i < ${#file_array[@]}; ++i));
do
# gen the file name for each loop
        OUTPUT="scan.$D_STR.$(uuidgen).txt"
        SCAN_CMD="nmap -v -sV -T4 -O -oG $OUTPUT -F --version-light"
        echo "Scanning $date ${file_array[$i]}"
        $($SCAN_CMD ${file_array[$i]})
        echo "Next $(date) ..."



done

echo "Complete $(date) $0..."
