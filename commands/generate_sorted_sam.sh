SAMTOOLS='samtools'
NUMBER_OF_THREADS=`nproc`
FILES=(a2840 a2841 a344 a346 a347 a348)
OUTPUT_PREFIX=


generate_bam_from_sam()
{
    echo "Generating BAM from SAM..."
    $SAMTOOLS view -@ $NUMBER_OF_THREADS -S -b "$OUTPUT_PREFIX.sam" > "$OUTPUT_PREFIX.bam"
    $SAMTOOLS sort -@ $NUMBER_OF_THREADS "${OUTPUT_PREFIX}.bam" -o "${OUTPUT_PREFIX}_sorted.bam"
    $SAMTOOLS index "${OUTPUT_PREFIX}_sorted.bam"

    echo "Removing original SAM file"
    rm "$OUTPUT_PREFIX.sam"
    echo "Removed original SAM file"

    echo "Removing unsorted BAM file"
    rm "$OUTPUT_PREFIX.bam"
    echo "Removed unsorted BAM file"
}

for file in ${FILES[@]} ; do
	OUTPUT_PREFIX="/work/yl708/bissiglab/alignments/${file}.out.grcm"
	generate_bam_from_sam
done
