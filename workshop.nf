#!/usr/bin/env nextflow

process BWA_Align {
    container = params.container

    input:
    file ref_fasta from params.ref_fasta
    file read1_fastq from params.read1_fastq
    file read2_fastq from params.read2_fastq

    output:
    file 'NA12878_chr20_ds.sam' into bwa_result

    """
    bwa mem ${params.bwa_opt} ${params.threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > 'NA12878_chr20_ds.sam'
    """
}

process Flagstat {
    container = params.container

    input:
    file sam from bwa_result

    output:
    file "NA12878_chr20_ds.sam.flagstat.metrics" into flagstat_output_channel

    """
    samtools flagstat ${sam} > 'NA12878_chr20_ds.sam.flagstat.metrics'
    """

}