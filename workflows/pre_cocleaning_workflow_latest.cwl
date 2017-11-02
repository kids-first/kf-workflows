cwlVersion: v1.0
class: Workflow
id: pre_cocleaning_workflow
label: pre-cocleaning-workflow
requirements:
  - class: MultipleInputFeatureRequirement

inputs:
  indexd_reference_fasta: File
  fastq1: File
  fastq2: File
  read_group: string
  output_name: string

outputs:
  mark_duplicates_bam:
    type: File
    outputSource: picard_markduplicates/mark_duplicates_bam

steps:
  bwa_mem:
    run: ../tools/bwa_mem_latest.cwl
    in:
      indexd_reference_fasta: indexd_reference_fasta
      fastq1: fastq1
      fastq2: fastq2
      read_group: read_group
      output_name: output_name
    out:
      [output_bam]

  picard_samsort:
    run: ../tools/picard_sortsam_latest.cwl
    in:
      input_bam: bwa_mem/output_bam
    out:
      [sorted_bam]

  picard_markduplicates:
    run: ../tools/picard_markduplicates_latest.cwl
    in:
      input_bam: picard_samsort/sorted_bam
    out:
      [mark_duplicates_bam]
