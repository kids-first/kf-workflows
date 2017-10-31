class: Workflow
cwlVersion: v1.0
id: test_run
label: test.run
requirements:
  - class: MultipleInputFeatureRequirement
inputs:
  - id: readGroup
    type: string
  - id: outputName
    type: string
  - id: indexdReferenceFasta
    type: File
  - id: fastq2
    type: File
  - id: fastq1
    type: File
outputs:
  - id: markDupBam
    outputSource:
      - picard_markduplicates/markDupBam
    type: File
steps:
  - id: bwa_mem
    in:
      - id: readGroup
        source: readGroup
      - id: indexdReferenceFasta
        source: indexdReferenceFasta
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
      - id: outputName
        source: outputName
    out:
      - id: outputBam
    run: ../tools/bwa-mem.cwl
  - id: picard_markduplicates
    in:
      - id: inputBam
        source: picard_sam_sort/sortedBam
    out:
      - id: markDupBam
    run: ../tools/picard-markduplicates.cwl
  - id: picard_sam_sort
    in:
      - id: unsortedBam
        source: bwa_mem/outputBam
    out:
      - id: sortedBam
    run: ../tools/picard-sortsam.cwl
