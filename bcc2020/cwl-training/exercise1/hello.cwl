#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: CommandLineTool

baseCommand: ["bash", "hello.sh"]

# Construct a shell script on the fly
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: hello.sh
        entry: |-
          #!/bin/bash
          myName="$(inputs.myName.path)"
          echo Hello World! > Hello.txt
          cat \${myName} >> Hello.txt

inputs:
  myName:
    type: File
    inputBinding:
      position: 1

outputs:
  outFile:
    type: File
    outputBinding:
      glob: Hello.txt
    doc: Output from echo and cat commands

