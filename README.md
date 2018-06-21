# dnanexus_minimap2_nanopore v1.0
[minimap2 v2.8] (https://github.com/lh3/minimap2/releases/tag/v2.8)

## What does this app do?
This app runs minimap2 to align Oxford Nanopore reads in a fastq file to a reference sequence.

## What are typical use cases for this app?
This app should be used aligning Oxford Nanopore reads to a reference sequence

## What data are required for this app to run?
The app requires a FASTQ file containing Oxford Nanopore reads and a reference FASTA to align to.

## What does this app output?
The app outputs 2 files:
1. sorted BAM file
2. BAM index file

## How does this app work?
The app runs minimap2 using the Oxford Nanopore settings to output a SAM file.
It then uses samtools v1.5 (docker image: [quay.io/biocontainers/samtools:1.5--2] (https://quay.io/repository/biocontainers/samtools?tab=info)) to convert SAM to BAM, sort and index.

## What are the limitations of this app
This app should only be used for Oxford Nanopore data.

## This app was made by Viapath Genome Informatics 