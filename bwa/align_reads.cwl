#!/usr/bin/env cwl-runner

class: CommandLineTool
id: align_tool
label: align tool
cwlVersion: v1.1

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
#
dct:creator:
  '@id':  https://orcid.org/0000-0001-5173-4627
  foaf:name: Walter Shands
  foaf:mbox: jshands@ucsc.edu

requirements:
  DockerRequirement:
    dockerPull: "quay.io/ldcabansay/bwa:latest"
  ResourceRequirement:
    coresMin: 1
    ramMin: 1024
    outdirMin: 100000
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}

  # Make sure the index files are in the same place
  # so BWA can find them
  InitialWorkDirRequirement:
    listing:
      - $(inputs.ref_fasta)
      - $(inputs.ref_fasta_fai)
      - $(inputs.ref_fasta_amb)
      - $(inputs.ref_fasta_ann)
      - $(inputs.ref_fasta_bwt)
      - $(inputs.ref_fasta_pac)
      - $(inputs.ref_fasta_sa)

inputs:
  sample_name:
    type: string
    doc: Sample name

  bwa_opt:
    type: string
    inputBinding:
      position: 2
      shellQuote: false
    doc: BWA options

  ref_fasta:
    type: File
    inputBinding:
      position: 4
    doc: Genome reference fasta file.

  ref_fasta_fai:
    type: File
    doc: Genome reference bwa index fai.

  ref_fasta_amb:
    type: File
    doc: Genome reference bwa index amb.

  ref_fasta_ann:
    type: File
    doc: Genome reference bwa index ann.

  ref_fasta_bwt:
    type: File
    doc: Genome reference bwa index bwt.

  ref_fasta_pac:
    type: File
    doc: Genome reference bwa index pac.

  ref_fasta_sa:
    type: File
    doc: Genome reference bwt index sa.

  read1_fastq:
    type: File
    inputBinding:
      position: 11
    doc: Input first fastq.

  read2_fastq:
    type: File
    inputBinding:
      position: 12
    doc: Input second fastq.

stdout: $(inputs.sample_name).sam
outputs:
  output_sam:
    type: stdout
    doc: Aligned SAM file.

baseCommand: [bwa, mem]

