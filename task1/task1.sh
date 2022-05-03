#!/bin/bash
logFile="../data/test-1-action-ids.log"
outputPath="./output/"
outputFile="test-1-action-ids-output.txt"
tempFile="./output/tempNumber"

#Check the file
if [ ! -f "$logFile" ]; then
   echo "The file doesn't exist..."
   exit 1
fi

#Check whether the directory exists, if not, create the directory
if [ ! -d "$outputPath" ]; then
    mkdir $outputPath
fi

#Match the string “ongoing” and print the next line
awk '$0~/ongoing/{getline;print$0;}' $logFile > $tempFile


#Print the third value divided by space and Remove the double quotation mark
cut -d " " -f 3 $tempFile | sed 's/\"//g' >> $outputPath$outputFile

#Delet the tempFile
rm $tempFile
