class: CommandLineTool
cwlVersion: v1.0
id: picard_sam_sort
label: picard-samsort
requirements:
  - class: ResourceRequirement
    ramMin: 1000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: d3bcenter/alpine-picard
baseCommand:
  - java
arguments:
  - position: 0
    prefix: -jar
    valueFrom: /picard.jar
  - position: 1
    valueFrom: SortSam
  - position: 2
    valueFrom: CREATE_INDEX=true
  - position: 3
    valueFrom: SORT_ORDER=coordinate
  - position: 4
    prefix: OUTPUT=
    separate: false
    valueFrom: $(inputs.unsortedBam.nameroot).sort.bam
inputs:
  - id: unsortedBam
    type: File
    inputBinding:
      position: 4
      prefix: 'INPUT='
      separate: false
outputs:
  - id: sortedBam
    type: File
    outputBinding:
      glob: '*.sort.bam'
    secondaryFiles:
      - ^.bai