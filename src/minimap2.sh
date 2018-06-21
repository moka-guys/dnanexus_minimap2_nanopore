#!/bin/bash

# -e = exit on error; -x = output each line that is executed to log; -o pipefail = throw an error if there's an error in pipeline
set -e -x -o pipefail

main() {

    # Download fastq and reference genome
    dx-download-all-inputs 

    # Create output directories
    mkdir -p $HOME/out/bam/bam/
    mkdir -p $HOME/out/bai/bam/

    # Extract minimap2
    tar -jxvf minimap2-2.8_x64-linux.tar.bz2

    # Run minimap2. -a specifies output should be SAM format. -x uses preset setting for Oxford Nanopore. -t sets number of threads.
    ./minimap2-2.8_x64-linux/minimap2 -ax map-ont -t 4 $reference_genome_path $fastq_path > ${fastq_prefix}.sam

    # sort and index with samtools
    dx-docker run -v ~:/data quay.io/biocontainers/samtools:1.5--2 /bin/bash -c "samtools view -b -S /data/${fastq_prefix}.sam | \
    samtools sort - -o /data/${fastq_prefix}.bam && samtools index /data/${fastq_prefix}.bam"

    # Move bam and bam index to output directories
    sudo mv $HOME/${fastq_prefix}.bam $HOME/out/bam/bam/
    sudo mv $HOME/${fastq_prefix}.bam.bai $HOME/out/bai/bam/

    # Upload output
    dx-upload-all-outputs
}
