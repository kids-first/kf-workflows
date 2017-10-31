class: CommandLineTool
cwlVersion: v1.0
id: bwa_mem
label: bwa-mem
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 1000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: d3bcenter/alpine-bwa-samtools
baseCommand:
  - bwa
  - mem
arguments:
  - position: 1
    prefix: '-t'
    valueFrom: '8'
  - position: 2
    prefix: '-T'
    valueFrom: '0'
inputs:
  - id: readGroup
    type: string
    inputBinding:
      position: 3
      prefix: '-R'
  - id: indexdReferenceFasta
    type: File
    inputBinding:
      position: 4
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  - id: fastq1
    type: File
    inputBinding:
      position: 5
  - id: fastq2
    type: File
    inputBinding:
      position: 6
  - id: outputName
    type: string
    inputBinding:
      position: 7
      shellQuote: false
      valueFrom: '| samtools view -Shb -o $(self)'
outputs:
  - id: outputBam
    type: File
    outputBinding:
      glob: '*.bam'
