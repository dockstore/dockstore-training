#!/usr/bin/env nextflow

process BWA_Align {
    container = params.container

    output:
    file 'NA12878_chr20_ds.sam' into bwa_result

    """
    bwa mem ${params.bwa_opt} ${params.threads} ${params.ref_fasta} ${params.read1_fastq} ${params.read2_fastq} > 'NA12878_chr20_ds.sam'
    """
}

process Flagstat {
    container = params.container

    input:
    val sam from bwa_result

    output:
    file "NA12878_chr20_ds.sam.flagstat.metrics" into flagstat_output_channel

    """
    samtools flagstat ${sam} > 'NA12878_chr20_ds.sam.flagstat.metrics'
    """

}