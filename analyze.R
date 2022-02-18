library(DESeq2)
library(Rsubread)

# alignment_files = c("alignments-ncbi/a344.out.grcm-ncbi-tran_sorted.bam", "alignments-ncbi/a346.out.grcm-ncbi-tran_sorted.bam", "alignments-ncbi/a347.out.grcm-ncbi-tran_sorted.bam", "alignments-ncbi/a348.out.grcm-ncbi-tran_sorted.bam", "alignments-ncbi/a2840.out.grcm-ncbi-tran_sorted.bam", "alignments-ncbi/a2841.out.grcm-ncbi-tran_sorted.bam")

# fc <- featureCounts(files=alignment_files, annot.ext="ref/grcm39-ncbi.gtf", isGTFAnnotationFile=TRUE,GTF.featureType="exon",GTF.attrType="gene_id", isPairedEnd=TRUE, nthreads=12, requireBothEndsMapped=TRUE, countChimericFragments=FALSE)

sample_names = c("a344", "a346", "a347", "a348", "a2840", "a2841")
colnames(fc$counts) <- sample_names
coldata = read.csv('sample_conditions.csv', row.names = 1, header = FALSE)
colnames(coldata) = "condition"
coldata$condition <- factor(coldata$condition)

dds <- DESeqDataSetFromMatrix(countData = fc$counts,
                              colData = coldata,
                              design = ~ condition)

dds <- DESeq(dds)
res <- results(dds)
resOrdered <- res[order(res$pvalue),]
summary(res)

write.csv(as.data.frame(resOrdered), 
          file="analysis/condition_treated_results.csv")

# plotCounts(dds, gene=which(res@rownames == "Tcim"), intgroup="condition")