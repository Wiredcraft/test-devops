# Description
> A shell script that finds and sorts wrong data in the log

## Variables
```bash
#  logFile ：The path to the log file that needs to be processed
#  outputPath： Final output directory
#  outputFile： Output filename
#  tempFile : Temporary file to hold line numbers
logFile="../data/test-1-action-ids.log"
outputPath="./output/"
outputFile="test-1-action-ids-output.txt"
tempFile="./output/tempNumber"
```
## How to use
1. Modify the variable or place the log file to be processed in the directory set by the script

2. Execute the script and you will get the processed files in the `outputPath` directory you set
