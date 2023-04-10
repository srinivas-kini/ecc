#!/usr/bin/env bash

export SCRIPTS_DIR=$HADOOP_HOME/bin

export MAPPER="part1mapper.py"
export REDUCER="part1reducer.py"

export OUTPUT_DIR="p1output"

chmod 777 $SCRIPTS_DIR/$MAPPER $SCRIPTS_DIR/$REDUCER

# Run streaming job
hadoop jar $STREAMING \
 -D mapreduce.job.reduces=1 \
 -input "input/sample.log" \
 -output $OUTPUT_DIR \
 -mapper "python3 ${MAPPER}" \
 -reducer "python3 ${REDUCER}" \
 -file "${SCRIPTS_DIR}/${MAPPER}" \
 -file "${SCRIPTS_DIR}/${REDUCER}" \

# Print output
hadoop fs -text /user/exouser/$OUTPUT_DIR/part-00000

# Remove output directory from HDFS
hadoop fs -rm -r $OUTPUT_DIR
