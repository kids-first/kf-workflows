class: CommandLineTool
cwlVersion: v1.0
id: picard_markduplicates
label: picard-markduplicates
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
    valueFrom: MarkDuplicates
  - position: 2
    valueFrom: CREATE_INDEX=true
  - position: 3
    valueFrom: VALIDATION_STRINGENCY=STRICT
  - position: 4
    valueFrom: METRICS_FILE=marked_dup_metrics.txt
  - position: 5
    prefix: 'OUTPUT='
    separate: false
    valueFrom: $(inputs.inputBam.nameroot).markdup.bam
inputs:
  - id: inputBam
    type: File
    inputBinding:
      position: 6
      prefix: 'INPUT='
      separate: false
outputs:
  - id: markDupBam
    type: File
    outputBinding:
      glob: '*.markdup.bam'
    secondaryFiles:
      - ^.bai