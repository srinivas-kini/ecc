#!/usr/bin/env bash


export LOC=$HADOOP_HOME/bin

chmod 777 $LOC/part1mapper.py $LOC/part1reducer.py

# Run streaming job
hadoop jar $STREAMING \
 -D mapreduce.job.reduces=1 \
 -input "input/sample.log" \
 -output p1output \
 -mapper "python3 part1mapper.py" \
 -reducer "python3 part1reducer.py" \
 -file "${LOC}/part1mapper.py" \
 -file "${LOC}/part1reducer.py" \

# Print o/p
hadoop fs -cat /user/exouser/p1output/part-00000 > $HADOOP_HOME/bin/part1output.txt

# Remove o/p directory
hadoop fs -rm -r p1output
