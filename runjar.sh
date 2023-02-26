#!/usr/bin/env bash

export SCRIPTS_DIR=$HADOOP_HOME/bin
export MAPPER="part1mapper.py"
export REDUCER="part1reducer.py"

chmod 777 $SCRIPTS_DIR/$MAPPER $SCRIPTS_DIR/$REDUCER

# Run streaming job
hadoop jar $STREAMING \
 -D mapreduce.job.reduces=1 \
 -input "input/sample.log" \
 -output p1output \
 -mapper "python3 ${MAPPER}" \
 -reducer "python3 ${REDUCER}" \
 -file "${SCRIPTS_DIR}/${MAPPER}" \
 -file "${SCRIPTS_DIR}/${REDUCER}" \

# Print output
hadoop fs -cat /user/exouser/p1output/part-00000 > $HADOOP_HOME/bin/output.txt
cat output.txt

# Remove output directory from HDFS
hadoop fs -rm -r p1output
