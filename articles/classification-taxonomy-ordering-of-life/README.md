# Classification, Taxonomy, and the Ordering of Life

This article repository supports the Biology knowledge-series article:

**Classification, Taxonomy, and the Ordering of Life**

The code distribution expands the article's compact R and Python examples into a reproducible computational taxonomy workflow. It includes sequence-distance matrices, Jukes-Cantor correction, biodiversity indices, Bray-Curtis dissimilarity, occurrence-record summaries, taxonomic confidence scoring, SQL provenance structures, validation notes, reproducible data files, and multi-language scientific-computing scaffolding.

No university affiliation is implied by the repository. The design goal is research-grade computational rigor: clear assumptions, modular code, transparent data structures, provenance, validation checks, and reproducible workflows.

## Repository Structure

- `python/` — sequence distance, Jukes-Cantor correction, biodiversity indices, occurrence summaries, taxonomic confidence scoring, and validation
- `r/` — phylogenetic distance examples, diversity indices, community dissimilarity, and assignment scoring
- `julia/` — sequence distance, diversity, and scoring calculations
- `fortran/` — compact numerical kernel for taxonomic distance and diversity
- `rust/` — safe command-line taxonomic confidence scoring utility
- `go/` — portable taxonomic confidence scoring helper
- `c/` — compact taxonomy numerical kernel
- `cpp/` — comparative taxonomic assignment scenario simulation
- `sql/` — taxa, sequences, occurrence records, community counts, assignment scores, outputs, and provenance schema
- `docs/` — setup, methodology, validation, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent quantitative taxonomy:

1. Calculate pairwise p-distance for aligned DNA sequences.
2. Apply Jukes-Cantor correction.
3. Summarize biodiversity with Shannon diversity.
4. Compare communities with Bray-Curtis dissimilarity.
5. Summarize occurrence records by taxon and region.
6. Score taxonomic assignment confidence using explicit assumptions.
7. Track data provenance and uncertainty.

These examples are educational and methodological scaffolds. They are not authoritative taxonomic revisions, regulatory biodiversity assessments, diagnostic pathogen-identification systems, or conservation policy determinations. Real applications require expert taxonomic review, validated data, voucher specimens where possible, uncertainty assessment, and domain-specific standards.
