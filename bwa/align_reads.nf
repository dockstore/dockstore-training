#!/usr/bin/env nextflow

ref_fasta = file(params.ref_fasta)
read1_fastq = file(params.read1_fastq)
read2_fastq = file(params.read2_fastq)
ref_fasta_fai = file(params.ref_fasta_fai)
ref_fasta_bwt = file(params.ref_fasta_bwt)
ref_fasta_sa = file(params.ref_fasta_sa)
ref_fasta_pac = file(params.ref_fasta_pac)
ref_fasta_amb = file(params.ref_fasta_amb)
ref_fasta_ann = file(params.ref_fasta_ann)

process BWA_Align {
    input:
    file ref_fasta from ref_fasta
    file read1_fastq from read1_fastq
    file read2_fastq from read2_fastq
    file ref_fasta_fai from ref_fasta_fai
    file ref_fasta_bwt from ref_fasta_bwt
    file ref_fasta_sa from ref_fasta_sa
    file ref_fasta_pac from ref_fasta_pac
    file ref_fasta_amb from ref_fasta_amb
    file ref_fasta_ann from ref_fasta_ann

    output:
    file 'NA12878_chr20_ds.sam' into bwa_result

    """
    bwa mem ${params.bwa_opt} ${params.threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > 'NA12878_chr20_ds.sam'
    """
}