Sizes="32 64 128 256 512 1024 2048"
Programs="windowsum_stratified presum_stratified"

for P in $Programs
do
	for S in $Sizes
	do
		./run.sh -program=$P -arc=../datasets/vec/vec$S.csv -output=$P-out
	done
done