#!/bin/bash


# with the -B flag
featureCounts -p --countReadPairs -B -T 64 -a ref/Mus_musculus.GRCm39.104.gtf -t exon -g gene_id -o counts-bothendsmapped.txt alignments/a2840.out.grcm_sorted.bam alignments/a2841.out.grcm_sorted.bam alignments/a344.out.grcm_sorted.bam alignments/a346.out.grcm_sorted.bam alignments/a347.out.grcm_sorted.bam alignments/a348.out.grcm_sorted.bam 

# without the -B flag
featureCounts -p --countReadPairs -T 64 -a ref/Mus_musculus.GRCm39.104.gtf -t exon -g gene_id -o counts-noB.txt alignments/a2840.out.grcm_sorted.bam alignments/a2841.out.grcm_sorted.bam alignments/a344.out.grcm_sorted.bam alignments/a346.out.grcm_sorted.bam alignments/a347.out.grcm_sorted.bam alignments/a348.out.grcm_sorted.bam 
