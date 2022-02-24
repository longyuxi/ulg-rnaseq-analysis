import os

##TODO when script is generalized: WRAP FILENAMES IN QUOTES

##### USER INPUTS ####
INPUT_FILES = ["../alignments-ncbi/a344.out.grcm-ncbi-tran_sorted.bam", "../alignments-ncbi/a346.out.grcm-ncbi-tran_sorted.bam", "../alignments-ncbi/a347.out.grcm-ncbi-tran_sorted.bam", "../alignments-ncbi/a348.out.grcm-ncbi-tran_sorted.bam", "../alignments-ncbi/a2840.out.grcm-ncbi-tran_sorted.bam", "../alignments-ncbi/a2841.out.grcm-ncbi-tran_sorted.bam"]
REFERENCE = "/home/longyuxi/Documents/mount/RNAseq-raw-data/ref/grcm39-ncbi.fa"
REFERENCE_INTERVAL = "NC_000079.7:23990924-24009174"

######### SOFTWARES #############
PICARDPATH = "/home/longyuxi/Documents/picard/picard.jar"
GATKPATH = "/home/longyuxi/Documents/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar"
GATK = "/home/longyuxi/Documents/gatk-4.2.5.0/gatk"

os.system('rm varcall_cmds.tmp')
vcf_files = []
for input_file in INPUT_FILES:
    # java -jar picard.jar AddOrReplaceReadGroups I=zip1_sorted.bam O=zip1_RG.bam RGID=1 RGLB=A RGPL=illumina RGPU=NovaSeq RGSM=1
    RG_file = input_file[:-4] + '.RG.bam'
    # ARRG_command = f"java -jar {PICARDPATH} AddOrReplaceReadGroups I={input_file} O={RG_file} RGID=1 RGLB=A RGPL=illumina RGPU=NovaSeq RGSM=1"
    ## JUST FOR TESTING
    ARRG_command = f""

    # java -jar picard.jar MarkDuplicates I=zip1_RG.bam O=zip1_MD.bam M=zip1_metrics.txt
    MD_file= RG_file[:-7] + '.MD.bam'
    # MD_command = f"{GATK} MarkDuplicatesSpark --spark-master local[\\*] -I {RG_file} -O {MD_file} -M {RG_file[:-7] + '_metrics.txt'}"
    # MD_command = f"java -jar {PICARDPATH} MarkDuplicates I={RG_file} O={MD_file} M={RG_file[:-7] + '_metrics.txt'}"
    MD_command = f""

    index_command = f"samtools index {MD_file}"

    # java -jar gatk-4.1.4.0/gatk-package-4.1.4.0-local.jar HaplotypeCaller -R reference.txt                          -I zip1_MD.bam -O zip1.g.vcf -ERC GVCF
    vcf_file = input_file[:-4] + '.g.vcf'
    HC_command = f"java -jar {GATKPATH} HaplotypeCaller -R {REFERENCE} -I {MD_file} -O {vcf_file} -ERC GVCF"
    vcf_files.append(vcf_file)

    # os.system(ARRG_command)
    # os.system(MD_command)
    # os.system(HC_command)
    with open('varcall_cmds.tmp', 'a') as f:
        f.write(f'{ARRG_command} ; {MD_command} ; {index_command} ; {HC_command}\n')



# java -jar gatk-4.1.4.0/ gatk-package-4.1.4.0-local.jar GenomicsDBImport -V zip1_MD.bam         -V zip2_MD.bam … --genomics-workspace-path zip -L “reference-interval”
v_params = ""

## TO REMOVE AFTER THIS RUN
sample_names = ['a344', 'a346', 'a347', 'a348', 'a2840', 'a2841']
vcf_files = [f'/home/longyuxi/Documents/mount/RNAseq-raw-data/alignments-ncbi/vcfs/{sn}.out.grcm-ncbi-tran_sorted.g.vcf' for sn in sample_names]
for v in vcf_files:
    v_params += f"-V {v} "

GDBI_command = f"java -jar {GATKPATH} GenomicsDBImport {v_params} --genomicsdb-workspace-path variants -L {REFERENCE_INTERVAL}"

# java -jar gatk-4.1.4.0/gatk-package-4.1.4.0-local.jar GenotypeGVCFs -R reference.txt                           -V -gendb://zip -O zip.vcf
GGVCF_command = f"java -jar {GATKPATH} GenotypeGVCFs -R {REFERENCE} -V gendb://variants -O variants.vcf"

os.system('rm make_vcf_cmds.tmp')
with open('make_vcf_cmds.tmp', 'a') as f:
    f.write(f'{GDBI_command} ; {GGVCF_command}\n')

# os.system(GDBI_command)
# os.system(GGVCF_command)
