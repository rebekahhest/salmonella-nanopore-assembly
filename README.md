# salmonella-nanopore-assembly
Nanopore-based consensus genome assembly and reference comparison of Salmonella enterica

**Author:** Rebekah Hest  
**Course:** BINF6110 - Genomic Methods for Bioinformatics

## Assignment 1 - Part 1

This repository contains Part 1 of Assignment 1, which focuses on the background, rationale, and proposed methods for assembling a *Salmonella enterica* genome from Oxford Nanopore sequencing data and comparing it to a reference genome.

### Introduction

Bacterial genome assembly is crucial for understanding microbial evolution, tracking pathogen transmission, and monitoring antimicrobial resistance. Oxford Nanopore Technologies (ONT) long-read sequencing (LRS) has improved bacterial genome reconstruction by spanning large repetitive regions often fragmented in short reads (Santos et al., 2025). Recent ONT R10 pore chemistry reports Q20+ accuracy (Sereika et al., 2022). Recent studies demonstrate Nanopore R10 long-read assemblers, such as Flye, can produce bacterial genome assemblies with structural completeness comparable to Illumina-Nanopore hybrid approaches (Lerminiaux et al., 2024; Sanderson et al., 2024).
<br><br>
Despite these advancements, LRS is characterized by higher per-base error rates than short-read sequencing, particularly for insertion and deletion errors in homopolymeric regions, which can negatively impact consensus accuracy and downstream variant detection (Delahaye and Nicolas, 2021; Harvey et al., 2023). Consequently, long-read assemblies typically require additional polishing and quality assessment steps to mitigate systematic sequencing errors and improve base-level accuracy.
<br><br>
Alignment of an assembled genome to a reference provides a complementary approach for evaluating assembly quality through the detection of single-nucleotide variants and small insertions or deletions, which may reflect true biological divergence or residual assembly errors (Nattestad and Schatz, 2016). When a high-quality reference is available, this approach facilitates variant calling but may introduce reference bias and reduce accuracy in divergent regions (Lischer and Shimizu, 2017; Marchant et al., 2016).
<br><br>
The goal of this project is to assemble a consensus genome of _Salmonella enterica_, a clinically significant pathogen with a well-characterized genome and high-quality reference sequences (Laing et al., 2017). Raw ONT R10 long reads will be assembled and polished, then aligned to a reference genome obtained from NCBI for variant calling and visualization to evaluate assembly accuracy and limitations of a long-read-only, reference-based approach.

### Proposed Methods

## Assignment 1 - Part 2

### Final Methods

### Results

### Discussion

## References
