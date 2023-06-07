#samtools 
samtools view -T ../Zebra_Bacteria_merge_genome/Bacteria_zebra_genome.fna -f 2048 -h output_minimap.sam  > 2048.sam
#extract read ID
less output_minimap.sam |cut -f 3|grep kraken|sort|uniq > bacteria_name
