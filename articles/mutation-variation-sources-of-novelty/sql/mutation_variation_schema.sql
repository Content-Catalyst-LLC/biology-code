-- Mutation, variation, and novelty reproducibility schema.
--
-- This schema tracks mutation spectra, aligned sequences, genotype summaries,
-- structural variation, novelty condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS mutation_spectrum;
DROP TABLE IF EXISTS aligned_sequences;
DROP TABLE IF EXISTS genotype_site_summary;
DROP TABLE IF EXISTS structural_variants;
DROP TABLE IF EXISTS novelty_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE mutation_spectrum (
    spectrum_id INTEGER PRIMARY KEY,
    mutation_class TEXT NOT NULL UNIQUE,
    mutation_count INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE aligned_sequences (
    sequence_id INTEGER PRIMARY KEY,
    taxon_name TEXT NOT NULL UNIQUE,
    sequence_text TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE genotype_site_summary (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    derived_count INTEGER NOT NULL,
    n_chromosomes INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE structural_variants (
    variant_id TEXT PRIMARY KEY,
    variant_type TEXT NOT NULL,
    size_bp INTEGER NOT NULL,
    overlaps_gene INTEGER NOT NULL,
    overlaps_regulatory_region INTEGER NOT NULL,
    population_frequency REAL NOT NULL,
    notes TEXT
);

CREATE TABLE novelty_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    mutation_supply REAL NOT NULL,
    standing_variation REAL NOT NULL,
    recombination_potential REAL NOT NULL,
    regulatory_flexibility REAL NOT NULL,
    developmental_modularity REAL NOT NULL,
    ecological_opportunity REAL NOT NULL,
    constraint_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    expected_mutations REAL,
    poisson_probability REAL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    nucleotide_diversity REAL,
    segregating_sites INTEGER,
    mutation_selection_balance_q REAL,
    final_allele_frequency REAL,
    structural_priority_score REAL,
    novelty_condition_score REAL,
    condition_class TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE provenance_records (
    provenance_id INTEGER PRIMARY KEY,
    dataset_name TEXT NOT NULL,
    source_name TEXT NOT NULL,
    observation_method TEXT,
    analytical_method TEXT,
    license TEXT,
    processing_step TEXT,
    uncertainty_notes TEXT,
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO mutation_spectrum
(mutation_class, mutation_count, notes)
VALUES
('A>G', 43, 'Synthetic mutation spectrum observation'),
('G>A', 39, 'Synthetic mutation spectrum observation'),
('C>T', 77, 'Synthetic mutation spectrum observation'),
('T>C', 31, 'Synthetic mutation spectrum observation'),
('A>C', 18, 'Synthetic mutation spectrum observation'),
('A>T', 14, 'Synthetic mutation spectrum observation'),
('C>A', 22, 'Synthetic mutation spectrum observation'),
('C>G', 9, 'Synthetic mutation spectrum observation');

INSERT INTO aligned_sequences
(taxon_name, sequence_text, notes)
VALUES
('taxon_A', 'ATGCTAGCTAACGGTACCTA', 'Synthetic aligned sequence'),
('taxon_B', 'ATGCTGGCTATCGGTACCTA', 'Synthetic aligned sequence'),
('taxon_C', 'ATGATGGCTATCGGTTCCTA', 'Synthetic aligned sequence'),
('taxon_D', 'ATGCTAGTTAACGGAACCTG', 'Synthetic aligned sequence'),
('taxon_E', 'ATGCTAGCTAACGGAACCTA', 'Synthetic aligned sequence');

INSERT INTO genotype_site_summary
(site_name, derived_count, n_chromosomes, notes)
VALUES
('site_1', 1, 80, 'Synthetic genotype site summary'),
('site_2', 2, 80, 'Synthetic genotype site summary'),
('site_3', 5, 80, 'Synthetic genotype site summary'),
('site_4', 8, 80, 'Synthetic genotype site summary'),
('site_5', 13, 80, 'Synthetic genotype site summary'),
('site_6', 21, 80, 'Synthetic genotype site summary'),
('site_7', 34, 80, 'Synthetic genotype site summary'),
('site_8', 3, 80, 'Synthetic genotype site summary'),
('site_9', 0, 80, 'Synthetic genotype site summary'),
('site_10', 80, 80, 'Synthetic genotype site summary'),
('site_11', 9, 80, 'Synthetic genotype site summary'),
('site_12', 17, 80, 'Synthetic genotype site summary');

INSERT INTO structural_variants
(variant_id, variant_type, size_bp, overlaps_gene, overlaps_regulatory_region, population_frequency, notes)
VALUES
('sv_001', 'deletion', 1200, 1, 1, 0.012, 'Synthetic structural variant'),
('sv_002', 'duplication', 85000, 1, 0, 0.280, 'Synthetic structural variant'),
('sv_003', 'inversion', 43000, 0, 1, 0.041, 'Synthetic structural variant'),
('sv_004', 'translocation', 210000, 1, 1, 0.004, 'Synthetic structural variant'),
('sv_005', 'copy_gain', 5600, 1, 0, 0.095, 'Synthetic structural variant');

INSERT INTO novelty_condition_sites
(site_name, mutation_supply, standing_variation, recombination_potential, regulatory_flexibility, developmental_modularity, ecological_opportunity, constraint_risk, notes)
VALUES
('reference_population', 0.58, 0.74, 0.66, 0.62, 0.61, 0.55, 0.22, 'Synthetic novelty condition site'),
('bottlenecked_population', 0.31, 0.28, 0.32, 0.40, 0.45, 0.48, 0.68, 'Synthetic novelty condition site'),
('microbial_stress_system', 0.88, 0.69, 0.54, 0.76, 0.52, 0.84, 0.30, 'Synthetic novelty condition site'),
('crop_breeding_panel', 0.63, 0.81, 0.79, 0.58, 0.56, 0.61, 0.24, 'Synthetic novelty condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('mutation_spectrum.csv', 'synthetic_example', 'constructed_example', 'mutation spectrum summary', 'MIT-compatible example data', 'mutation spectrum setup', 'Not real mutation data'),
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence distance and Jukes-Cantor correction', 'MIT-compatible example data', 'sequence distance setup', 'Not real sequence data'),
('genotype_site_summary.csv', 'synthetic_example', 'constructed_example', 'nucleotide diversity and site-frequency summary', 'MIT-compatible example data', 'diversity summary setup', 'Not real genotype data'),
('structural_variants.csv', 'synthetic_example', 'constructed_example', 'structural variant priority scoring', 'MIT-compatible example data', 'structural variation setup', 'Not real structural variant data');
