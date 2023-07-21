#!/bin/bash

read -r -d '' usage << EOM
usage: run.sh -program=<name>
              -pinRDDHostLimit=0..15
              -partitions=1..240
              -codegen=true/false
              -aggrIterType=t/p
              -packedBroadcast=true/false
              -<tableName>=<hdfsPath>

Please specify at least -program=<name> and -<tableName>=<hdfsPath>
EOM

if [ "$#" -lt 2 ]
  then
    echo "$usage"
    exit
fi

args="$@"
args=$(echo $args | sed -e 's/=/_/g')
args=$(echo $args | sed -e 's/ /@/g')
args=$(echo $args | sed -e 's/[-\/]//g')
args=$(echo $args | sed -e 's/hdfs:scai01.cs.ucla.edu:9000user//g')

output="exps/current/${args}.txt"

# prefix "local:" is crucial, otherwise you will see a long task deser time
cmd="./bin/spark-submit \
--master local[*] \
--deploy-mode client \
--class edu.ucla.cs.wis.bigdatalog.spark.runner.Experiments \
--conf spark.locality.wait=0s \
--conf spark.ui.showConsoleProgress=false \
--conf spark.datalog.shuffledistinct.enabled=false \
--conf spark.driver.maxResultSize=300g \
--conf spark.driver.memory=300g \
--conf spark.datalog.recursion.maxIterations=1000000 \
--conf spark.executor.memory=300g \
--conf spark.sql.shuffle.partitions=1 \
--conf spark.executor.cores=32 \
local:$PWD/datalog/target/scala-2.11/spark-datalog_2.11-2.0.3-SNAPSHOT.jar 
$@"

(printf "\n[Command] $cmd\n" && $cmd) 2>&1 | tee -a $output
