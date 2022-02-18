# single file command

# hisat2 -x hisat2_indexes/grcm39/genome -1 RNAseq-raw-data/raw_data/a2840/a2840_1.fq -2 RNAseq-raw-data/raw_data/a2840/a2840_2.fq -S a2840.out.grcm.sam -t -p 44

# for all files command
for genome in {a2840,a2841,a344,a346,a347,a348} ; do 
	hisat2 -x hisat2_indexes/grcm39/genome -1 RNAseq-raw-data/raw_data/${genome}/${genome}_1.fq -2 RNAseq-raw-data/raw_data/${genome}/${genome}_2.fq -S alignments/${genome}.out.grcm.sam -t -p $(nproc)
done
