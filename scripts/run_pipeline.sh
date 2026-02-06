#!/usr/bin/env bash
# Requires conda environment: assembly
# Tools: filtlong, nanoplot, flye, minimap2, samtools, bcftools

# ---- Inputs ----
READS="$1"          # raw FASTQ
REFERENCE="$2"      # reference FASTA
THREADS="${4:-4}"   # optional, default = 4

mkdir -p "$OUTDIR"

# ---- QC & Filtering ----
filtlong --keep_percent 90 "$READS" > filtered_reads.fastq

# ---- Check Q-score ----
NanoPlot --fastq filtered_reads.fastq -o nanoplot_output

# ---- de novo assembly ----
flye nano-hq filtered_reads.fastq --genome-size 5m --out-dir flye_output --threads "$THREADS"

# ---- Align reads to reference ----
minimap2 -ax map-ont "$REFERENCE" filtered_reads.fastq | samtools sort -o ref_mapped.bam

samtools index ref_mapped.bam
samtools faidx "$REFERENCE"

# ---- Variant calling ----
bcftools mpileup -Ou -f "$REFERENCE" ref_mapped.bam | bcftools call -mv -Oz -o variants.vcf.gz

bcftools index variants.vcf.gz