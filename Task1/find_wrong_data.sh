#!/bin/bash
##################################
# - Find wrong data from log file and output to text
# - Sort wrong data text
#
##################################
# Author: Sven Shen
# Date: 2022-04-26

set -e
set -u

#  logFile ：The path to the log file that needs to be processed
#  outputPath： Final output directory
#  outputFile： Output filename
#  tempFile : Temporary file to hold line numbers

logFile="../data/test-1-action-ids.log"
outputPath="./output/"
outputFile="test-1-action-ids-output.txt"
tempFile="./output/tempNumber"

# Determine whether the log file exists 
if [ ! -f "$logFile" ]; then
    echo "Please check if the target log file exists : $logFile"
    exit 1
fi
# Create an output directory
if [ ! -d "$outputPath" ]; then
    mkdir $outputPath
fi

# Get the line number where the wrong is replaced from the log file
awk '/ongoing/{print NR}' $logFile > $tempFile

# Clear file contents
> $outputPath$outputFile

# Output all actionIds for those wrong replaced lines in log file
while read -r line
do
  let actionIdLineNO=$line+1
  awk "NR==$actionIdLineNO{print}" $logFile   |tr -cd "[0-9]" >> $outputPath$outputFile
  echo "">> $outputPath$outputFile
done <  $tempFile

# Clear temporary file
rm $tempFile

# Sort output file
sort $outputPath$outputFile -o $outputPath$outputFile

echo "outputFile:$outputPath$outputFile"