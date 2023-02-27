#!/usr/bin/env bash

export SCRIPTS_DIR=$HADOOP_HOME/bin

export MAPPER="part1mapper.py"
export MAPPER2="part2mapper.py"

export REDUCER="part2reducer1.py"
export REDUCER2="part2reducer2.py"

export OUTPUT_DIR_TMP="p2output"
export OUTPUT_DIR_FINAL="p2final"

# Get the time range from the user or set it to the default value
export DEFAULT_TIME_RANGE="3-4"
export TIME_RANGE=${1:-DEFAULT_TIME_RANGE}


chmod 777 $SCRIPTS_DIR/$MAPPER $SCRIPTS_DIR/$REDUCER $SCRIPTS_DIR/$MAPPER2 $SCRIPTS_DIR/$REDUCER2

# MapReduce Phase 1
hadoop jar $STREAMING \
 -D mapreduce.job.reduces=1 \
 -input "input/sample.log" \
 -output $OUTPUT_DIR_TMP \
 -mapper "python3 ${MAPPER}" \
 -reducer "python3 ${REDUCER}" \
 -file "${SCRIPTS_DIR}/${MAPPER}" \
 -file "${SCRIPTS_DIR}/${REDUCER}" \

# MapReduce Phase 2
hadoop jar $STREAMING \
 -D mapreduce.job.reduces=1 \
 -input "/user/exouser/${OUTPUT_DIR_TMP}/part-00000" \
 -output $OUTPUT_DIR_FINAL \
 -mapper "python3 ${MAPPER2}" \
 -reducer "python3 ${REDUCER2} ${TIME_RANGE}" \
 -file "${SCRIPTS_DIR}/${MAPPER2}" \
 -file "${SCRIPTS_DIR}/${REDUCER2}" \

# Print output
hadoop fs -text /user/exouser/$OUTPUT_DIR_FINAL/part-00000

# Remove output directories
hadoop fs -rm -r /user/exouser/$OUTPUT_DIR_TMP
hadoop fs -rm -r /user/exouser/$OUTPUT_DIR_FINAL
