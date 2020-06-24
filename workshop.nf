#!/usr/bin/env nextflow

params.test1 = '/Users/natalieperez/gitOrgs/dockstore-training/data/ref/ref_hg37_chr20.fa'
params.test2 = '/Users/natalieperez/gitOrgs/dockstore-training/data/NA12878_chr20_ds_r1.fq'
params.test3 = '/Users/natalieperez/gitOrgs/dockstore-training/data/NA12878_chr20_ds_r2.fq'

process BWA_Align {

    input:
    path 'ref_fasta' from params.test1
    path 'read1_fastq' from params.test2
    path 'read2_fastq' from params.test3

    output:
    file 'NA12878_chr20_ds.sam' into bwa_result

    """
    bwa index ref_fasta
    bwa mem ${params.bwa_opt} ${params.threads} ref_fasta read1_fastq read2_fastq > 'NA12878_chr20_ds.sam'
    """
}

process Flagstat {

    input:
    file sam from bwa_result

    output:
    file "NA12878_chr20_ds.sam.flagstat.metrics" into flagstat_output_channel

    """
    samtools flagstat ${sam} > 'NA12878_chr20_ds.sam.flagstat.metrics'
    """

}