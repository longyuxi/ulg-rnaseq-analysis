library(Rsubread)

a <- featureCounts(files=c("alignments/a2840.out.grcm_sorted.bam","alignments/a2841.out.grcm_sorted.bam","alignments/a344.out.grcm_sorted.bam","alignments/a346.out.grcm_sorted.bam","alignments/a347.out.grcm_sorted.bam","alignments/a348.out.grcm_sorted.bam"),isPairedEnd=TRUE,nthreads=12,annot.ext="ref/Mus_musculus.GRCm39.104.gtf", requireBothEndsMapped=TRUE, isGTFAnnotationFile=TRUE,GTF.featureType="exon",GTF.attrType="gene_id")

