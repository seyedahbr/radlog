mkdir snap
cd snap
wget https://snap.stanford.edu/data/wiki-Vote.txt.gz
wget https://snap.stanford.edu/data/twitter_combined.txt.gz
wget https://snap.stanford.edu/data/soc-Epinions1.txt.gz
gunzip wiki-Vote.txt.gz
gunzip twitter_combined.txt.gz
gunzip soc-Epinions1.txt.gz
cd ..