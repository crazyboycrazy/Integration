#from sam file we find real kimeric read ID
import sys
import collections
samfile=sys.argv[1]
kimeric_read=sys.argv[2]
kimeric_list=[]
my_dict=collections.defaultdict(list)
with open(kimeric_read)as file:
    for line in file:
        kimeric_list.append(line.strip())
with open(samfile) as file:
    for line in file:
        readid=line.split("\t")[0]
        match=[line.split("\t")[2]]
        my_dict[readid]+=match

def test_integration(input_list):
    list_a=[k for k in input_list if "taxid" in k]
    list_b=[k for k in input_list if ("taxid" not in k) and ("*" not in k)]
    if (len(list_a) > 1) and (len(list_b)>1):
        return True

for i,l in my_dict.items():
    if test_integration(l):
#        print(i,l,sep="\t")
        print(i)
