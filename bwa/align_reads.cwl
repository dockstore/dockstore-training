#!/usr/bin/env cwl-runner

class: CommandLineTool
id: align_tool
label: align tool
cwlVersion: v1.1

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-5173-4627
    s:email: jshands@ucsc.edu
    s:name: Walter Shands

s:codeRepository: https://github.com/wshands/dockstore-training
s:dateCreated: "2020-06-22"
s:license: https://spdx.org/licenses/Apache-2.0

s:keywords: edam:topic_0091 , edam:topic_0622
s:programmingLanguage: Python

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

$schemas:
  - https://schema.org/docs/schema_org_rdfa.html
  - http://edamontology.org/EDAM_1.18.owl


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
    inputBinding:
      position: 1
    doc: Sample name

  bwa_opt:
    type: string
    inputBinding:
      position: 2
    doc: BWA options

  threads:
    type: int
    inputBinding:
      position: 3
    doc: Number of threads to use.

  ref_fasta:
    type: File
    inputBinding:
      position: 4
    doc: Genome reference fasta file.

  ref_fasta_fai:
    type: File
    inputBinding:
      position: 5
    doc: Genome reference bwa index fai.

  ref_fasta_amb:
    type: File
    inputBinding:
      position: 6
    doc: Genome reference bwa index amb.

  ref_fasta_ann:
    type: File
    inputBinding:
      position: 7
    doc: Genome reference bwa index ann.

  ref_fasta_bwt:
    type: File
    inputBinding:
      position: 8
    doc: Genome reference bwa index bwt.

  ref_fasta_pac:
    type: File
    inputBinding:
      position: 9
    doc: Genome reference bwa index pac.

  ref_fasta_sa:
    type: File
    inputBinding:
      position: 10
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

outputs:
  output_sam:
    type: File
    outputBinding:
      glob: $(inputs.sample_name).sam
    doc: Aligned SAM file.

baseCommand: [bwa_align.sh]

