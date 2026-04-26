-- Genomics and the expansion of biological knowledge reproducibility schema.
--
-- This schema tracks expression observations, variant summaries,
-- aligned sequences, metagenomic profiles, genomic condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS expression_observations;
DROP TABLE IF EXISTS sample_metadata;
DROP TABLE IF EXISTS variant_site_summary;
DROP TABLE IF EXISTS aligned_sequences;
DROP TABLE IF EXISTS metagenomic_profile;
DROP TABLE IF EXISTS genomic_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE sample_metadata (
    sample_id TEXT PRIMARY KEY,
    sample_group TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE expression_observations (
    observation_id INTEGER PRIMARY KEY,
    gene_name TEXT NOT NULL,
    sample_id TEXT NOT NULL,
    count_value REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (sample_id) REFERENCES sample_metadata(sample_id)
);

CREATE TABLE variant_site_summary (
    locus_id TEXT PRIMARY KEY,
    alt_count_pop1 INTEGER NOT NULL,
    n_chrom_pop1 INTEGER NOT NULL,
    alt_count_pop2 INTEGER NOT NULL,
    n_chrom_pop2 INTEGER NOT NULL,
    missing_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE aligned_sequences (
    sequence_id INTEGER PRIMARY KEY,
    taxon_name TEXT NOT NULL UNIQUE,
    sequence_text TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE metagenomic_profile (
    taxon_name TEXT PRIMARY KEY,
    reads INTEGER NOT NULL,
    carbon_cycle_genes INTEGER NOT NULL,
    nitrogen_cycle_genes INTEGER NOT NULL,
    stress_response_genes INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE genomic_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    assembly_quality REAL NOT NULL,
    annotation_depth REAL NOT NULL,
    variant_quality REAL NOT NULL,
    expression_signal REAL NOT NULL,
    population_representation REAL NOT NULL,
    provenance_quality REAL NOT NULL,
    bias_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    log2_fc REAL,
    alt_frequency REAL,
    minor_allele_frequency REAL,
    expected_heterozygosity REAL,
    nucleotide_diversity REAL,
    fst_value REAL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    relative_abundance REAL,
    functional_potential_score REAL,
    genomic_condition_score REAL,
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

INSERT INTO sample_metadata
(sample_id, sample_group, notes)
VALUES
('sample_1', 'control', 'Synthetic sample metadata'),
('sample_2', 'control', 'Synthetic sample metadata'),
('sample_3', 'control', 'Synthetic sample metadata'),
('sample_4', 'control', 'Synthetic sample metadata'),
('sample_5', 'treated', 'Synthetic sample metadata'),
('sample_6', 'treated', 'Synthetic sample metadata'),
('sample_7', 'treated', 'Synthetic sample metadata'),
('sample_8', 'treated', 'Synthetic sample metadata');

INSERT INTO expression_observations
(gene_name, sample_id, count_value, notes)
VALUES
('gene_1','sample_1',101,'Synthetic expression observation'),
('gene_1','sample_2',98,'Synthetic expression observation'),
('gene_1','sample_3',104,'Synthetic expression observation'),
('gene_1','sample_4',96,'Synthetic expression observation'),
('gene_1','sample_5',162,'Synthetic expression observation'),
('gene_1','sample_6',158,'Synthetic expression observation'),
('gene_1','sample_7',166,'Synthetic expression observation'),
('gene_1','sample_8',170,'Synthetic expression observation'),
('gene_2','sample_1',112,'Synthetic expression observation'),
('gene_2','sample_2',106,'Synthetic expression observation'),
('gene_2','sample_3',109,'Synthetic expression observation'),
('gene_2','sample_4',111,'Synthetic expression observation'),
('gene_2','sample_5',168,'Synthetic expression observation'),
('gene_2','sample_6',171,'Synthetic expression observation'),
('gene_2','sample_7',160,'Synthetic expression observation'),
('gene_2','sample_8',164,'Synthetic expression observation'),
('gene_3','sample_1',94,'Synthetic expression observation'),
('gene_3','sample_2',99,'Synthetic expression observation'),
('gene_3','sample_3',97,'Synthetic expression observation'),
('gene_3','sample_4',103,'Synthetic expression observation'),
('gene_3','sample_5',150,'Synthetic expression observation'),
('gene_3','sample_6',148,'Synthetic expression observation'),
('gene_3','sample_7',154,'Synthetic expression observation'),
('gene_3','sample_8',160,'Synthetic expression observation'),
('gene_4','sample_1',130,'Synthetic expression observation'),
('gene_4','sample_2',128,'Synthetic expression observation'),
('gene_4','sample_3',132,'Synthetic expression observation'),
('gene_4','sample_4',126,'Synthetic expression observation'),
('gene_4','sample_5',88,'Synthetic expression observation'),
('gene_4','sample_6',94,'Synthetic expression observation'),
('gene_4','sample_7',91,'Synthetic expression observation'),
('gene_4','sample_8',90,'Synthetic expression observation');

INSERT INTO variant_site_summary
(locus_id, alt_count_pop1, n_chrom_pop1, alt_count_pop2, n_chrom_pop2, missing_rate, notes)
VALUES
('locus_1',12,200,9,80,0.01,'Synthetic variant summary'),
('locus_2',80,200,18,80,0.03,'Synthetic variant summary'),
('locus_3',34,200,31,80,0.02,'Synthetic variant summary'),
('locus_4',5,200,11,80,0.04,'Synthetic variant summary'),
('locus_5',121,200,55,80,0.01,'Synthetic variant summary'),
('locus_6',45,200,37,80,0.02,'Synthetic variant summary'),
('locus_7',160,200,70,80,0.05,'Synthetic variant summary'),
('locus_8',20,200,4,80,0.03,'Synthetic variant summary'),
('locus_9',67,200,44,80,0.02,'Synthetic variant summary'),
('locus_10',3,200,2,80,0.01,'Synthetic variant summary');

INSERT INTO aligned_sequences
(taxon_name, sequence_text, notes)
VALUES
('genome_A', 'ATGCTAGCTAACGGTACCTA', 'Synthetic aligned sequence'),
('genome_B', 'ATGCTGGCTATCGGTACCTA', 'Synthetic aligned sequence'),
('genome_C', 'ATGATGGCTATCGGTTCCTA', 'Synthetic aligned sequence'),
('genome_D', 'ATGCTAGTTAACGGAACCTG', 'Synthetic aligned sequence'),
('genome_E', 'ATGCTAGCTAACGGAACCTA', 'Synthetic aligned sequence');

INSERT INTO metagenomic_profile
(taxon_name, reads, carbon_cycle_genes, nitrogen_cycle_genes, stress_response_genes, notes)
VALUES
('Nitrosomonas',12000,18,21,44,'Synthetic metagenomic profile'),
('Pseudomonas',8500,11,6,39,'Synthetic metagenomic profile'),
('Bacteroides',6100,7,2,28,'Synthetic metagenomic profile'),
('Rhizobium',4200,9,19,22,'Synthetic metagenomic profile'),
('Vibrio',1800,2,1,17,'Synthetic metagenomic profile'),
('Bacillus',3600,5,4,31,'Synthetic metagenomic profile');

INSERT INTO genomic_condition_sites
(site_name, assembly_quality, annotation_depth, variant_quality, expression_signal, population_representation, provenance_quality, bias_risk, notes)
VALUES
('reference_genome_project',0.84,0.78,0.72,0.66,0.62,0.80,0.22,'Synthetic genomic condition site'),
('conservation_panel',0.68,0.61,0.76,0.40,0.82,0.74,0.30,'Synthetic genomic condition site'),
('metagenomic_survey',0.55,0.58,0.42,0.36,0.70,0.64,0.41,'Synthetic genomic condition site'),
('clinical_variant_screen',0.72,0.83,0.88,0.50,0.58,0.79,0.27,'Synthetic genomic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('expression_matrix.csv', 'synthetic_example', 'constructed_example', 'expression summary and PCA-style ordination', 'MIT-compatible example data', 'expression matrix setup', 'Not real transcriptomic data'),
('variant_site_summary.csv', 'synthetic_example', 'constructed_example', 'allele frequency, heterozygosity, and FST-style calculation', 'MIT-compatible example data', 'variant summary setup', 'Not real variant data'),
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence distance and Jukes-Cantor correction', 'MIT-compatible example data', 'sequence distance setup', 'Not real genome data'),
('metagenomic_profile.csv', 'synthetic_example', 'constructed_example', 'metagenomic abundance and functional potential scoring', 'MIT-compatible example data', 'metagenomic profile setup', 'Not real metagenomic data');
