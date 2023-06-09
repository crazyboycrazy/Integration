#minimap 
../minimap2-2.26_x64-linux/minimap2 -ax map-ont -t 10 ../Zebra_Bacteria_merge_genome/Bacteria_zebra_genome.fna  merged.fastq > output_minimap.sam

#samtools 
samtools view -T ../Zebra_Bacteria_merge_genome/Bacteria_zebra_genome.fna -f 2048 -h output_minimap.sam  > 2048.sam

#extract read ID
less output_minimap.sam |cut -f 3|grep kraken|sort|uniq > bacteria_name

#extract kimeric read id
less 2048.sam |grep -v "^@"|cut -f 1 >  kimeric_read_id

#real_kimeric read id  extract (한쪽은 zebra 한쪽은 bacteria)
python real_kimericread.py 2048.sam kimeric_read_id > real_kimeric_read

#extract real kimeric read
seqkit grep -f real_kimeric_read merged.fastq  > extracted.fastq

#change from fastq to fasta file
seqkit fq2fa  extracted.fastq  > extracted.fasta

#Make blast reference
#1) extract bacteria fasta
less output_minimap.sam |cut -f 3|grep kraken|sort|uniq > bacteria_name
seqkit grep -f bacteria_name  ../normal/Bacteria_genome/library.fna  > Bacteria_library.fna
#2) merge bacteria and zebrafish fasta
cat Bacteria_library.fna  ../Zebrafish_genome/GCA_903798175.1_fDreNAz1.1_genomic.fna  > merged_reference.fa


#Blast Search
~/blastn/ncbi-blast-2.14.0+/bin/blastn -query extracted.fasta -subject merged_reference.fa -outfmt "7 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qlen" -evalue 1e-6 -task megablast > blast_out_result
