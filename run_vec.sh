Sizes="32 64 128 256 512 1024 2048"
Programs="windowsum_stratified presum_stratified"

Sizes="4096 8192 16384 32768 65536"
Sizes="4096 8192 16384 32768 65536 131072 262144 524288 524288"
Sizes="32 256 2048 16384"
Programs="windowsum_stratified"
#Programs="windowsum_stratified_30"

for P in $Programs
do
	for S in $Sizes
	do
		./run.sh -program=$P -arc=../datasets/vec/vec$S.csv -output=$P-out
	done
done
