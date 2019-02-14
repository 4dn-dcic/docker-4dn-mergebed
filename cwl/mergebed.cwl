---
  outputs: 
    - 
      id: "#merged_bed"
      type: 
        - "File"
      outputBinding: 
        glob: "$(inputs.outprefix + '.bed.gz')"
  baseCommand: 
    - "run-merge-bed.sh"
  hints: 
    - 
      dockerPull: "duplexa/4dn-mergebed:v1"
      class: "DockerRequirement"
  cwlVersion: "v1.0"
  class: "CommandLineTool"
  arguments: []
  inputs: 
    - 
      id: "#outprefix"
      inputBinding: 
        position: 1
        separate: true
      default: "out"
      type:
        - "string"
    - 
      id: "#input_bed"
      inputBinding: 
        itemSeparator: " "
        position: 2
        separate: true
      type:
        - 
          items: "File"
          type: "array"
  requirements: 
    - 
      class: "InlineJavascriptRequirement"
