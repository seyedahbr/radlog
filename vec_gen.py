import csv
import sys

if(len(sys.argv) < 3):
    print(f"Arguments count: {len(sys.argv)}")
    print("you have to pass <vec_length> <out_file>")


size = int(sys.argv[1])
ur_outfile = sys.argv[2]

with open(ur_outfile, 'w') as fout:
    o=csv.writer(fout)
    for i in range(1,size+1):
        o.writerow([str(i), str(i)])