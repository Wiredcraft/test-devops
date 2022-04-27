# Description
> A shell script that finds and sorts wrong data in the log

In this task, I find the wrong data in the following steps:
1. Find the line number where the wrong data is located
2. Find the data of the next line through the line number in step 1 and intercept the id and output it to the file
3. Sort the data obtained in step 2

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
