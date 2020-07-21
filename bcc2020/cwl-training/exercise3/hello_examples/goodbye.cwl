#!/usr/bin/env cwl-runner

###############################################################################################
# this tool will...

# launch locally with Dockstore CLI:
#   dockstore tool launch --local-entry goodbye.cwl --json goodbye.json
###############################################################################################


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
          cat \${greeting} > Goodbye.txt
          echo See you later! >> Goodbye.txt

inputs:
  greeting:
    type: File
    inputBinding:
      position: 1

outputs:
  outFile:
    type: File
    outputBinding:
      glob: Goodbye.txt
    doc: Output from echo and cat commands

