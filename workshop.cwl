cwlVersion: v1.1
class: Workflow

label: A workflow that aligns a fasta file and provides statistics on the SAM file
doc: A workflow that aligns a fasta file and provides statistics on the SAM file

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  '@id':  https://orcid.org/0000-0001-5173-4627
  foaf:name: Walter Shands
  foaf:mbox: jshands@ucsc.edu


inputs:
    sample_name: string
    bwa_opt: string
    ref_fasta: File
    ref_fasta_fai: File
    ref_fasta_amb: File
    ref_fasta_ann: File
    ref_fasta_bwt: File
    ref_fasta_pac: File
    ref_fasta_sa: File
    read1_fastq: File
    read2_fastq: File


outputs:
  output_sam:
    type: File
    outputSource: BWA_Align/output_sam
  output_metrics:
    type: File
    outputSource: Flagstat/flagstat_metrics

steps:
  BWA_Align:
    run: bwa/align_reads.cwl
    in:
      sample_name: sample_name
      bwa_opt: bwa_opt
      ref_fasta: ref_fasta
      ref_fasta_fai: ref_fasta_fai
      ref_fasta_amb: ref_fasta_amb
      ref_fasta_ann: ref_fasta_ann
      ref_fasta_bwt: ref_fasta_bwt
      ref_fasta_pac: ref_fasta_pac
      ref_fasta_sa: ref_fasta_sa
      read1_fastq: read1_fastq
      read2_fastq: read2_fastq

    out:
      [output_sam]

  Flagstat:
    run: samtools/metrics.cwl
    in:
      analysis_sam: BWA_Align/output_sam
    out: [flagstat_metrics]

