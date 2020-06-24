#!/usr/bin/env nextflow

ref_fasta = file(params.ref_fasta)
read1_fastq = file(params.read1_fastq)
read2_fastq = file(params.read2_fastq)

process BWA_Align {

    input:
    file ref_fasta from ref_fasta
    file read1_fastq from read1_fastq
    file read2_fastq from read2_fastq

    output:
    file 'NA12878_chr20_ds.sam' into bwa_result

    """
    bwa index ${ref_fasta}
    bwa mem ${params.bwa_opt} ${params.threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > 'NA12878_chr20_ds.sam'
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
