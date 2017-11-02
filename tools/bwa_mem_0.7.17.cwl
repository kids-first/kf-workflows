cwlVersion: v1.0
class: CommandLineTool
id: bwa_mem_0.7.17
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 1000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: d3bcenter/alpine-bwa-samtools:0.7.17
baseCommand: [bwa, mem]
arguments:
  - position: 1
    prefix: '-t'
    valueFrom: '8'
  - position: 2
    prefix: '-T'
    valueFrom: '0'
inputs:
  read_group:
    type: string
    inputBinding:
      position: 3
      prefix: '-R'
  indexd_reference_fasta:
    type: File
    inputBinding:
      position: 4
    secondaryFiles: [.amb, .ann, .bwt, .pac, .sa]
  fastq1:
    type: File
    inputBinding:
      position: 5
  fastq2:
    type: File
    inputBinding:
      position: 6
  output_name:
    type: string
    inputBinding:
      position: 7
      shellQuote: false
      valueFrom: '| samtools view -Shb -o $(self).bam'
outputs:
  output_bam:
    type: File
    outputBinding:
      glob: '*.bam'
