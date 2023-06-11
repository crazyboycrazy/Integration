#1
../../minimap2-2.26_x64-linux/minimap2 -ax map-ont -t 10 MEtronidazole_merged.fa  normal_zebra_extracted.fastq > output_minimap.sam

#2
samtools view -b output_minimap.sam  -o  output_minimap.bam

#3
samtools sort output_minimap.bam > output_minimap.sorted.bam

#4
samtools index output_minimap.sorted.bam


#5
sniffles -i output_minimap.sorted.bam -v output_min_support_1.vcf --minsupport 0

#6
less output_min_support_1.vcf |grep Sniffles2.INS|awk '{print ">"$1"_"NR,"\n"$5}' > Inserted.fasta
