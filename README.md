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

### Methods

#### Read Quality Control and Filtering

Quality-control filtering was done on the raw ONT R10 reads (FASTQ) using Filtlong (v0.3.1) with `–keep_percent 90` in accordance with Wick et al. (2023) to remove the lowest-quality reads while preserving sufficient coverage and read-length. Before assembly, the expected quality score distributions (Q20+) and read length statistics (N50 5-15kb) will be verified for the filtered sequences using NanoPlot (v1.46.2).

#### Draft _de novo_ Genome Assembly and Polishing

A draft _de novo_ genome assembly was produced using Flye (v2.9.6) with `–nano-hq` and `–genome_size 5m` since this tool is optimized for long-read assembly and these parameters are appropriate for high-accuracy R10 bacterial reads (Wick et al., 2023). Assembly polishing using Medaka was attempted but not completed due to computational limitations. 

#### Reference Genome Retrieval and Alignment

A high-quality, curated reference genome for _S. enterica_ was downloaded from NCBI RefSeq (NCBI, n.d.; accession GCF_000006945.2). Reads were aligned using Minimap2 (v2.3) with `–ax map-ont` where the alignments were converted to BAM files, then sorted and indexed using Samtools (v1.23) to enable efficient variant calling and visualization (Li et al., 2018; Lefouili & Nam, 2022).

#### Variant Calling, Visualization and Quality Assessment

Variant calling was performed on the sorted, indexed BAM alignments using bcftools (v1.23) with the `mpileup` command to generate genotype likelihoods at each position and the `call` command to determine the most likely variant alleles. Alignments and called variants were visualized using IGV (v2.19.7) to inspect coverage, structural consistency, and variant confidence (Thorvaldsdóttir et al., 2013). 

## Assignment 1 - Part 2

### Results

De novo genome assembly of the filtered ONT reads using Flye generated 3 contigs with lengths of 3,318,776 bp, 1,676,988 bp, and 109,059 bp with a total assembly length of 5,104,823 bp. The contig N50 was 3,318,776 bp, and mean coverage was 139×. A bar plot of contig lengths is shown in Figure 1.
<br><br>
Of the 164,525 total raw reads, 155,622 (94.6%) were mapped to the S. enterica reference genome ASM694v2 with 148,576 primary alignments. Secondary and supplementary alignments accounted for 4,520 and 2,526 reads, respectively. Mean coverage of raw reads was calculated in 10kb bins and varied across the chromosome, with higher coverage observed toward the beginning and end of the genome and lower, more stable coverage across the central region (Figure 2). Localized fluctuations were present but overall depth remain consistently high across the full length of the genome. 
<br><br>
Variant calling identified a total of 12,206 variants, including 12,151 single-nucleotide polymorphisms (SNPs) and 119 insertions/deletions (indels). Representative SNPs were visualized in IGV to facilitate variant validation and assess alignment quality (Figure 3).

### Discussion

The total consensus assembly size was consistent with the expected genome size of _Salmonella enterica_ (~4.8Mb – 5.2Mb) (McClelland et al., 2001). The assembly was generated using a low number of contigs, with the largest contig representing more than half of the total assembly length. This high contiguity reflects the advantages of long-read sequencing through improved resolution of repetitive regions compared to short-read approaches (Amoutzias et al., 2022). The high mean coverage across the genome further supports the reliability of the assembly and variant calling results, reducing the likelihood of identifying false positive SNPs or strand bias. The predominant detection of SNPs over indels reflects the improved base-calling accuracy of ONT R10 chemistry, which reduces indel-associated errors (Delahaye and Nicolas, 2021; Bogaerts et al., 2024). This pattern suggests that most variants likely represent true differences from the reference genome.
<br><br>
In the first representative region, a single, well-supported SNP was identified within the STM2537 gene, annotated as a putative ketopantoate reductase which is involved in thiamine biosynthesis. Thiamine is an essential cofactor in central metabolic pathways (Koenigsknecht and Downs, 2010). The mutation occurs on the minus strand and results in a missense substitution from leucine to valine. Because this is a conservative change between two hydrophobic amino acids, the structural impact may be modest, although it could still influence enzyme stability or metabolic efficiency.
<br><br>
In a second region, multiple SNPs were observed within the oadB gene, which encodes the beta-subunit of the oxaloacetate decarboxylase chain, a component of a sodium ion pump involved in energy metabolism (Dimroth, 1987). In one example, a codon changes from leucine to arginine due to three adjacent SNPs, representing a nonconservative missense substitution. This mutation could impact protein structure, potentially affecting sodium gradient formation and cellular energy balance.
<br><br>
Overall, the ONT R10 long-read sequences produced a highly contiguous assembly that aligned well to the _S. enterica_ reference genome. Numerous single-nucleotide variants were identified, including SNPs and indels across the entire genome, which likely reflect natural strain-level adaptations. The high coverage and mapping rate support the reliability of the assembly and variant calls. However, the use of a long-read-only, reference-based approach may encounter higher base-level inaccuracies without additional polishing or complementary short-read sequencing compared to hybrid or short-read only methods (Amarasinghe et al., 2020).

## References
Amarasinghe, S.L., Su, S., Dong, X., Zappia, L., Ritchie, M. E., & Gouil, Q. (2020). Opportunities and challenges in long-read sequencing data analysis. _Genome Biology_, _21_(30). https://doi.org/10.1186/s13059-020-1935-5<br>
Amoutzias, G. D., Nikolaidis, M., & Hesketh, A. (2022). The Notable Achievements and the Prospects of Bacterial Pathogen Genomics. _Microorganisms_, _10_(5), 1040. https://doi.org/10.3390/microorganisms10051040<br>
Bogaerts, B., Van den Bossche, A., Verhaegen, B., Delbrassinne, L., Mattheus, W., Nouws, S., Godfroid, M., Hoffman, S., Roosens, N. H. C., De Keersmaecker, S. C. J., & Vanneste, K. (2024). Closing the gap: Oxford Nanopore Technologies R10 sequencing allows comparable results to Illumina sequencing for SNP-based outbreak investigation of bacterial pathogens. _Journal of clinical microbiology_, _62_(5), e0157623. https://doi.org/10.1128/jcm.01576-23<br>
Delahaye, C., & Nicolas, J. (2021). Sequencing DNA with nanopores: Troubles and biases. _PLoS ONE_, _16_(10), e0257521. https://doi.org/10.1371/journal.pone.0257521<br>
Dimroth, P. 1987. Sodium Ion Transport Decarboxylases and Other Aspects of Sodium Ion Cycling in Bacteria. _Microbiological Reviews_, _51_(3),320-340. https://doi.org/10.1128/mr.51.3.320-340.1987<br>
Harvey, W. T., Ebert, P., Elber, J., Audano, P. A., Munson, K. M., Hoekzema, K., Porubsky, D., Beck, C. R., Marschall, T., Garimella, K., & Eichler, E. E. Whole-genome long-read sequencing downsampling and its effect on variant-calling precision and recall. _Genome Research_, _33_(12), 2029-2040. https://doi.org/10.1101/gr.278070.123<br>
Koenigsknecht, M. J., & Downs, D. M. (2010). Thiamine biosynthesis can be used to dissect metabolic integration. _Trends in Microbiology_, _18_(6):240-7. https://doi.org/10.1016/j.tim.2010.03.003<br>
Lerminiaux, N., Fakharuddin, K., Mulvey, M. R., & Mataseje, L. (2024). Do we still need Illumina sequencing data? Evaluating Oxford Nanopore Technologies R10.4.1 flow cells and the Rapid v14 library prep kit for Gram negative bacteria whole genome assemblies. _Canadian Journal of Microbiology_, _70_(5). https://doi.org/10.1139/cjm-2023-0175<br>
Li, H. (2018). Minimap2: pairwise alignment for nucleotide sequences. _Sequence analysis_, _34_(18), 3094-3100. https://doi.org/10.1093/bioinformatics/bty191<br>
Lefouili, M., & Nam, K. (2022). The evaluation of Bcftools mpileup and GATK HaplotypeCaller for variant calling in non-human species. _Scientific Reports_, _12_, 11331. https://doi.org/10.1038/s41598-022-15563-2<br>
Lischer, H. E. L., & Shimizu, K. K. (2017). Reference-guided _de novo_ assembly approach improves genome reconstruction for related species. _BMC Bioinformatics_, _18_(474), 2017. https://doi.org/10.1186/s12859-017-1911-6<br>
Marchant, A., Mougel, F., Mendoça, V., Quartier, M., Jacquin-Joly, E., da Rosa, J. A., Petit, E., & Harry, M. (2016). Comparing _de novo_ and reference-based transcriptome assembly strategies by applying them to the blood-sucking bug _Rhodnius prolixus_. _Insect Biochemistry and Molecular Biology_, _69_, 25-33. https://doi.org/10.1016/j.ibmb.2015.05.009<br>
McClelland, M., Sanderson, K. E., Spieth, J., Clifton, S. W., Latreille, P., Courtney, L., Porwollik, S., Ali, J., Dante, M., Du, F., Hou, S., Layman, D., Leonard, S., Nguyen, C., Scott, K., Holmes, A., Grewal, N., Mulvaney, E., Ryan, E., Sun, H., Florea, L. H., Miller, W., Stoneking, T., Nhan, M., Waterson, R., Wilson, R. K. (2001). Complete genome sequence of Salmonella enterica serovar Typhimurium LT2. _Nature_, _413_(6858), 852–856. https://doi.org/10.1038/35101614<br>
National Center for Biotechnology Information. (n.d.). __Salmonella enterica subsp. enterica serovar Typhimurium str. LT2_ genome assembly (Accession GCF_000006945.2) [Database record]. National Library of Medicine. https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000006945.2/<br>
Nattestad, M., & Schatz, M. C. (2016). Assemblytics: a web analytics tool for the detection of variants from an assembly. _Bioinformatics_, _32_(19), 3021-3023. https://doi.org/10.1093/bioinformatics/btw369<br>
Sanderson, N. D., Hopkins, K. M. V., Colpus, M., Parker, M., Lipworth, S., Crook, D., & Stoesser, N. (2024). Evaluation of the accuracy of bacterial genome reconstruction with Oxford Nanopore R10.4.1 long-read-only sequencing. _Microbial Genomics_, _10_(5). https://doi.org/10.1099/mgen.0.001246<br>
Santos, R., Lee., H., Williams, A., Baffour-Kyei, A., Lee, S-H., Troakes, C., Al-Chalabi, A., Breen, G., & Iacoangeli, A. (2025). Investigating the Performance of Oxford Nanopore Long-Read Sequencing with Respect to Illumina Microarrays and Short-Read Sequencing. _International Journal of Molecular Sciences_, _26_(10), 4492. https://doi.org/10.3390/ijms26104492<br>
Sereika, M., Kirkegaard, R. H., Karst, S. M., Michaelsen, T. Y., Sørensen, E. A., Wollendberg, R. D., & Albertson, M. (2022). Oxford Nanopore R10.4 long-read sequencing enables the generation of near-finished bacterial genomes from pure cultures and metagenomes without short-read or reference polishing. _Nature Methods_, _19_, 823-826. https://doi.org/10.1038/s41592-022-01539-7<br>
Thorvaldsdóttir, H., Robinson, J. T., & Mesirov, J. P. (2012). Integrative Genomics Viewer (IGV): high-performance genomics data visualization and exploration. _Briefings in Bioinformatics_, _14_(2), 178-192. https://doi.org/10.1093/bib/bbs017<br>
Vorderman, R. H. P. (2025). Sequali: efficient and comprehensive quality control of short- and long-read sequencing data. _Bioinformatics Advances_, _5_(1). https://doi.org/10.1093/bioadv/vbaf010<br>
Wick, R. R., Judd, L. M., & Holt, K. E. (2023). Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing. _PLOS Computational Biology_, _19_(3), e1010905. https://doi.org/10.1371/journal.pcbi.1010905<br>
