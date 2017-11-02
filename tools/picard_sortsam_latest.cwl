cwlVersion: v1.0
class: CommandLineTool
id: picard_samsort_latest
requirements:
  - class: ResourceRequirement
    ramMin: 1000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: d3bcenter/alpine-picard:latest
baseCommand: [java, -jar, /picard.jar, SortSam]
arguments:
  - position: 1
    valueFrom: CREATE_INDEX=true
  - position: 2
    valueFrom: SORT_ORDER=coordinate
  - position: 3
    prefix: OUTPUT=
    separate: false
    valueFrom: $(inputs.input_bam.nameroot).sort.bam
inputs:
  input_bam:
    type: File
    inputBinding:
      position: 4
      prefix: 'INPUT='
      separate: false
outputs:
  sorted_bam:
    type: File
    outputBinding:
      glob: '*.sort.bam'
    secondaryFiles:
      - ^.bai