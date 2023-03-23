Sizes="32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 524288 1048576"

for S in $Sizes
do
	python vec_gen.py $S vec$S.csv
done

mkdir ../datasets/vec
mv vec*.csv ../datasets/vec/
