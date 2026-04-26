# Methodology Notes

## Purpose

The computational examples support speciation and tree-of-life reasoning by translating population divergence, FST-style structure, sequence distance, corrected distance, birth-death diversification, and lineage persistence into transparent calculations.

## Core Methods

### Allele-Frequency Divergence

Delta p = |p1 - p2|

where p1 and p2 are allele frequencies in two populations.

### Mean Multi-Locus Divergence

Mean Delta p = (1 / L) sum(|p1_i - p2_i|)

where L is the number of loci.

### FST-Style Structure

FST = (HT - HS) / HT

where HT is total expected heterozygosity across pooled populations and HS is mean expected heterozygosity within populations.

### Sequence Distance

d = m / L

where m is the number of mismatches and L is sequence length.

### Jukes-Cantor Distance

d_JC = -3/4 ln(1 - 4p/3)

where p is observed proportion difference.

### Net Diversification

r = lambda - mu

where lambda is speciation or origination rate and mu is extinction rate.

### Lineage Richness

N(t) = N0 exp(rt)

where N0 is initial richness and r is net diversification.

## Interpretation

These workflows should be interpreted as educational computational speciation scaffolds, not calibrated systematic, phylogenetic, conservation, or diversification models. Real applications require empirical data, sampling design, model selection, uncertainty estimation, and domain expertise.
