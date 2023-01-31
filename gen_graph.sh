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