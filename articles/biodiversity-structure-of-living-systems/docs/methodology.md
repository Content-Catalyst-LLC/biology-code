# Methodology Notes

## Purpose

The computational examples support biodiversity reasoning by translating article concepts into transparent calculations. The examples are intentionally compact so they can be inspected, adapted, and extended.

## Core Methods

### Richness

Species richness is the number of species observed at a site.

### Shannon Diversity

Shannon diversity is calculated as:

H = -sum(p_i * log(p_i))

where p_i is the relative abundance of species i.

### Simpson and Hill Numbers

Hill numbers translate diversity metrics into effective numbers of species:

- q = 0: species richness
- q = 1: exp(Shannon)
- q = 2: inverse Simpson concentration

### Beta Diversity

Bray-Curtis dissimilarity compares compositional difference among sites using abundance data.

### Trait-Based Structure

Community-weighted mean traits are calculated by multiplying relative abundance by species trait values. Functional diversity can be expanded with distance-based metrics.

### Priority Screening

The priority-screening examples combine effective diversity, richness, fragmentation pressure, and functional uniqueness. This is not a universal conservation rule. It is a transparent scaffold for comparing assumptions.

## Interpretation

These workflows should be interpreted as educational biodiversity-analysis scaffolds, not as operational monitoring systems. Real applications require sampling design, taxonomic validation, spatial replication, sampling-effort correction, uncertainty analysis, and ecological expertise.
