#!/bin/bash

for genome in {a2840,a2841,a344,a346,a347,a348} ; do 
	htseq-count alignments/${genome}.out.grcm_sorted.bam ref/Mus_musculus.GRCm39.104.gtf > htseq_outs/${genome}.out
done
