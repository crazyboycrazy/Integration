#minimap 
../minimap2-2.26_x64-linux/minimap2 -ax map-ont -t 10 ../Zebra_Bacteria_merge_genome/Bacteria_zebra_genome.fna  merged.fastq > output_minimap.sam

#samtools 
samtools view -T ../Zebra_Bacteria_merge_genome/Bacteria_zebra_genome.fna -f 2048 -h output_minimap.sam  > 2048.sam

#extract read ID
less output_minimap.sam |cut -f 3|grep kraken|sort|uniq > bacteria_name

#real_kimeric read id  extract (한쪽은 zebra 한쪽은 bacteria)
python real_kimericread.py 2048.sam kimeric_read_id > real_kimeric_read
