#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: CommandLineTool

baseCommand: ["bash", "goodbye.sh"]

# Construct a shell script on the fly
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: goodbye.sh
        entry: |-
          #!/bin/bash
          greeting="$(inputs.greeting.path)"
          cat \${greeting} > goodbye.txt
          echo See you later! >> goodbye.txt

inputs:
  greeting:
    type: File
    inputBinding:
      position: 1

outputs:
  outFile:
    type: File
    outputBinding:
      glob: goodbye.txt
    doc: Output from echo and cat commands

