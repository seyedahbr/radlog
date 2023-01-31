# RaDlog

RaDlog is a system supporting the execution of [recursive query](https://en.wikipedia.org/wiki/Hierarchical_and_recursive_queries_in_SQL).
It is built on top of Spark (branch 2.0) that includes the compiler
and the distributed execution engine for the RaSQL (Recursive-aggregate-SQL)
language and the traditional Datalog. It supersedes the BigDatalog system
that previously developed at UCLA.

<https://rad-log.com/>

## Building RaDlog

You may follow the instructions of how Spark builds.

Spark is built using [Apache Maven](http://maven.apache.org/).
To build Spark and its example programs, run:

    build/mvn -DskipTests clean package

(You do not need to do this if you downloaded a pre-built package.)

You can build Spark using more than one thread by using the -T option with Maven, see ["Parallel builds in Maven 3"](https://cwiki.apache.org/confluence/display/MAVEN/Parallel+builds+in+Maven+3).
More detailed documentation is available from the project site, at
["Building Spark"](http://spark.apache.org/docs/latest/building-spark.html).
For developing Spark using an IDE, see [Eclipse](https://cwiki.apache.org/confluence/display/SPARK/Useful+Developer+Tools#UsefulDeveloperTools-Eclipse)
and [IntelliJ](https://cwiki.apache.org/confluence/display/SPARK/Useful+Developer+Tools#UsefulDeveloperTools-IntelliJ).

Spark can also be built using SBT, run:

    build/sbt compile

SBT is typically faster than Maven in development build.
To build packaged jars, run:

    build/sbt package
     
## Example Programs

Example RaDlog and Datalog queries locate in [query](query) directory.
The example/test data locate in [testdata](testdata) directory.

## Running Tests

Tests profiles are located in [query/test_datalog.txt](query/test_datalog.txt) and [query/test_rasql.txt](query/test_rasql.txt). They are read by `tests.scala` in [datalog/src/main/scala/edu/ucla/cs/wis/bigdatalog/spark/test](datalog/src/main/scala/edu/ucla/cs/wis/bigdatalog/spark/test).

## RaDlog Configuration

Property Name | Default | Meaning
------------- | -------------| -------------
spark.sql.sessionState|radlog|Choose between RaDlog and vanilla Spark mode. (radlog/spark)
spark.sql.codegen.wholeStage|false|Enable whole Stage code generation.
spark.sql.shuffle.partitions|1|The number of partitions to use when shuffling data for joins or aggregations. **Set it to `cores-per-node * pinRDDHostLimit` to enable the maximum parallelism.**
spark.locality.wait|0s|How long to wait to launch a data-local task. Note in RaDlog's pinRDD mode, it should be set to 0 as we have Partition-Aware Scheduling.
spark.datalog.pinRDDHostLimit|0|**Any value greater than 0 will enable the pinRDD mode in distributed deployment.** In pinRDD mode, each RDD split will be pinned to a specific worker node during the recursive evaluation. This number determines how many workers will be used in pinRDD mode. TODO: remove the hard-coded Hosts file!!!
spark.datalog.aggrIterType|tungsten|The aggregate iterator type.
spark.datalog.packedBroadcast|false|Enable the packed Broadcast mode.
spark.datalog.recursion.fixpointTask|true|Enable the decomposed execution when possible.
spark.datalog.recursion.maxIterations|Int.MaxValue|Maximum iterations allowed before reaching the fixpoint.
spark.datalog.recursion.nonMonotonic|false|Enable the non-Monotonic computation.

## Spark Configuration

Please refer to the [Configuration Guide](http://spark.apache.org/docs/latest/configuration.html)
in the online documentation for an overview on how to configure Spark.

## A Note About Hadoop Versions

Spark uses the Hadoop core library to talk to HDFS and other Hadoop-supported
storage systems. Because the protocols have changed in different versions of
Hadoop, you must build Spark against the same version that your cluster runs.

Please refer to the build documentation at
["Specifying the Hadoop Version"](http://spark.apache.org/docs/latest/building-spark.html#specifying-the-hadoop-version)
for detailed guidance on building for a particular distribution of Hadoop, including
building for particular Hive and Hive Thriftserver distributions.

## File preparation

Download datasets:

```
mkdir snap
cd snap
wget https://snap.stanford.edu/data/wiki-Vote.txt.gz
wget https://snap.stanford.edu/data/twitter_combined.txt.gz
wget https://snap.stanford.edu/data/soc-Epinions1.txt.gz
gunzip wiki-Vote.txt.gz
gunzip twitter_combined.txt.gz
gunzip soc-Epinions1.txt.gz
```

Graph data:

```
python txt_to_csv.py snap/wiki-Vote.txt wiki.csv
python txt_to_csv.py snap/twitter_combined.txt twitter.csv
python txt_to_csv.py snap/soc-Epinions1.txt epinions.csv
python txt_to_csv.py snap/wiki-Vote.txt wiki-w.csv
python txt_to_csv.py snap/twitter_combined.txt twitter-w.csv
python txt_to_csv.py snap/soc-Epinions1.txt epinions-w.csv
mkdir ../datasets
mkdir ../datasets/wiki/
mkdir ../datasets/epinions/
mkdir ../datasets/twitter/
mv wiki.csv ../datasets/wiki/
mv wiki-w.csv ../datasets/wiki/
mv epinions.csv ../datasets/epinions/
mv epinions-w.csv ../datasets/epinions/
mv twitter.csv ../datasets/twitter/
mv twitter-w.csv ../datasets/twitter/
```

Vector data:

```
python vec_gen.py 2 vec2.csv
python vec_gen.py 4 vec4.csv
python vec_gen.py 8 vec8.csv
python vec_gen.py 16 vec16.csv
python vec_gen.py 32 vec32.csv
python vec_gen.py 64 vec64.csv
python vec_gen.py 128 vec128.csv
mkdir ../datasets/vec
mv vec*.csv ../datasets/vec/
```


## Running

```
./run.sh -program=cc_all -arc=../datasets/twitter/twitter.csv
./run.sh -program=cc_all -arc=../datasets/epinions/epinions.csv
./run.sh -program=cc_all -arc=../datasets/wiki/wiki.csv
./run.sh -program=presum_stratified -arc=../datasets/vec/vec8.csv -output=presum-out
./run.sh -program=windowsum_stratified -arc=../datasets/vec/vec8.csv -output=windowsum-out
```