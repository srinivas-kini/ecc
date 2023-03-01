#!/usr/bin/env bash

export OUTPUT_DIR_GREP="grepoutput"
export OUTPUT_DIR_WC="wcoutput"
#export OUTPUT_DIR_SORT=sortouput

# Remove o/p dir if present
hadoop fs -rm -r $OUTPUT_DIR_GREP
hadoop fs -rm -r $OUTPUT_DIR_WC
#hadoop fs -rm -r $OUTPUT_DIR_SORT

echo "-- Running grep example to extract IP addresses from the sample.log file --"
# Run grep example
hadoop jar $EXAMPLES grep \
input/sample.log \
$OUTPUT_DIR_GREP \
'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'

echo "-- Output for grep -- "
hadoop fs -text /user/exouser/$OUTPUT_DIR_GREP/part-r-00000

echo "-- Running wordcount on the sample.log file"
# Run wc example
hadoop jar $EXAMPLES wordcount /user/exouser/input/sample.log /user/exouser/$OUTPUT_DIR_WC

# Print wordcount output
echo "-- Output for wc --"
hadoop fs -text /user/exouser/$OUTPUT_DIR_WC/part-r-00000

# Run sort example
#echo "-- Running sort on the output from wordcount"
#hadoop jar $EXAMPLES sort /user/exouser/$OUTPUT_DIR_WC/part-r-00000 /user/exouser/$OUTPUT_DIR_SORT

# Print sort output
#echo "-- Output for sort --"
#hadoop fs -ls /user/exouser/$OUTPUT_DIR_SORT

# Remove output directory from HDFS
hadoop fs -rm -r $OUTPUT_DIR_GREP
hadoop fs -rm -r $OUTPUT_DIR_WC
#hadoop fs -rm -r $OUTPUT_DIR_SORT
