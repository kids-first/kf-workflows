cwlVersion: v1.0
class: CommandLineTool
id: picard_markduplicates_latest
requirements:
  - class: ResourceRequirement
    ramMin: 1000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: d3bcenter/alpine-picard:latest
baseCommand: [java, -jar, /picard.jar, MarkDuplicates]
arguments:
  - position: 1
    valueFrom: CREATE_INDEX=true
  - position: 2
    valueFrom: VALIDATION_STRINGENCY=STRICT
  - position: 3
    valueFrom: METRICS_FILE=marked_dup_metrics.txt
  - position: 4
    prefix: 'OUTPUT='
    separate: false
    valueFrom: $(inputs.input_bam.nameroot).markdup.bam
inputs:
  input_bam:
    type: File
    inputBinding:
      position: 5
      prefix: 'INPUT='
      separate: false
outputs:
  mark_duplicates_bam:
    type: File
    outputBinding:
      glob: '*.markdup.bam'
    secondaryFiles:
      - ^.bai