#!/usr/bin/env nextflow

input_sam = file(params.analysis_sam)

process Flagstat {
    input:
    file input_sam from input_sam

    output:
    file 'NA12878_chr20_ds.sam.flagstat.metrics' into flagstat_output_channel

    """
    samtools flagstat ${input_sam} > 'NA12878_chr20_ds.sam.flagstat.metrics'
    """
}