import csv
import sys

if(len(sys.argv) < 3):
    print(f"Arguments count: {len(sys.argv)}")
    print("you have to pass <in_file> <out_file>")


ur_infile = sys.argv[1]
ur_outfile = sys.argv[2]

with open(ur_infile) as fin, open(ur_outfile, 'w') as fout:
    o=csv.writer(fout)
    for line in fin:
        if(line.startswith("#")):
            continue
        v = line.split()
        if(ur_outfile.endswith("-w.csv")):
        	v.append("1")
        o.writerow(v)