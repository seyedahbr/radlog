Datasets="wiki epinions twitter"
Programs="cc_all"

for P in $Programs
do
	for D in $Datasets
	do
		echo " BENCHMARKING $P on $D" ;
		./run.sh -program=$P -arc=../datasets/$D/$D.csv
	done
done
