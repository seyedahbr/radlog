Sizes="32 64 128 256 512 1024 2048"

for S in $Sizes
do
	python vec_gen.py $S vec$S.csv
done

mkdir ../datasets/vec
mv vec*.csv ../datasets/vec/