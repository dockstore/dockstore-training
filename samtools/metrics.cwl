#!/usr/bin/env cwl-runner

class: CommandLineTool
id: metrics_tool
label: metrics tool
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
    #dockerPull: $(runtime.docker_image)
    dockerPull: "quay.io/ldcabansay/samtools:latest"
  ResourceRequirement:
    coresMin: 1
    ramMin: 1024
    outdirMin: 100000

inputs:
  analysis_sam:
    type: File
    inputBinding:
      position: 1
#      prefix: --analysis-sam
    doc: SAM file to analyze.

  output_file_name:
    type: string?
    inputBinding:
#      prefix: --output-file-name
      position: 2
    default: "results_sam_flagstat_metrics.txt"
    doc: Output file name.

  docker_image:
    type: string
    doc: Docker image to use.

outputs:
  flagstat_metrics:
    type: File
    outputBinding:
      glob: $(inputs.output_file_name)
    doc: Metrics on the input SAM file.

baseCommand: [flagstat.sh]

