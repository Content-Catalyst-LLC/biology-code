-- Population genetics and mathematics of inheritance reproducibility schema.
--
-- This schema tracks population-genetic scenarios, genotype observations,
-- multi-population allele frequencies, migration-selection scenarios,
-- population condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS population_genetics_scenarios;
DROP TABLE IF EXISTS genotype_observations;
DROP TABLE IF EXISTS multipop_allele_frequencies;
DROP TABLE IF EXISTS migration_selection_scenarios;
DROP TABLE IF EXISTS population_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE population_genetics_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    generations INTEGER NOT NULL,
    initial_allele_frequency REAL NOT NULL,
    population_size INTEGER NOT NULL,
    fitness_AA REAL NOT NULL,
    fitness_Aa REAL NOT NULL,
    fitness_aa REAL NOT NULL,
    mutation_forward REAL NOT NULL,
    mutation_reverse REAL NOT NULL,
    migration_fraction REAL NOT NULL,
    migrant_allele_frequency REAL NOT NULL,
    drift_enabled TEXT NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE genotype_observations (
    observation_id INTEGER PRIMARY KEY,
    individual_id TEXT NOT NULL,
    locus_name TEXT NOT NULL,
    genotype_code INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE multipop_allele_frequencies (
    frequency_id INTEGER PRIMARY KEY,
    locus INTEGER NOT NULL,
    population_name TEXT NOT NULL,
    allele_frequency REAL NOT NULL,
    notes TEXT
);

CREATE TABLE migration_selection_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    generations INTEGER NOT NULL,
    p1_initial REAL NOT NULL,
    p2_initial REAL NOT NULL,
    migration_12 REAL NOT NULL,
    migration_21 REAL NOT NULL,
    selection_1 REAL NOT NULL,
    selection_2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE population_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    heterozygosity REAL NOT NULL,
    allelic_richness REAL NOT NULL,
    gene_flow REAL NOT NULL,
    fragmentation_pressure REAL NOT NULL,
    bottleneck_risk REAL NOT NULL,
    adaptive_capacity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    allele_frequency REAL,
    genotype_AA REAL,
    genotype_Aa REAL,
    genotype_aa REAL,
    expected_heterozygosity REAL,
    mean_fitness REAL,
    fixation_probability REAL,
    loss_probability REAL,
    fst_style REAL,
    population_condition_score REAL,
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

INSERT INTO population_genetics_scenarios
(scenario_name, generations, initial_allele_frequency, population_size, fitness_AA, fitness_Aa, fitness_aa, mutation_forward, mutation_reverse, migration_fraction, migrant_allele_frequency, drift_enabled, seed, notes)
VALUES
('neutral_large_pop', 180, 0.50, 5000, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.000, 0.50, 'true', 123, 'Synthetic neutral scenario'),
('selection_for_A', 180, 0.20, 1000, 1.15, 1.08, 1.00, 0.0000, 0.0000, 0.000, 0.50, 'true', 124, 'Synthetic selection scenario'),
('migration_balance', 180, 0.90, 1000, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.040, 0.15, 'true', 125, 'Synthetic migration scenario'),
('mutation_selection_balance', 180, 0.99, 3000, 1.00, 0.98, 0.92, 0.0015, 0.0001, 0.000, 0.50, 'false', 126, 'Synthetic mutation-selection scenario');

INSERT INTO genotype_observations
(individual_id, locus_name, genotype_code, notes)
VALUES
('ind_1', 'locus_1', 2, 'Synthetic genotype observation'),
('ind_2', 'locus_1', 1, 'Synthetic genotype observation'),
('ind_3', 'locus_1', 1, 'Synthetic genotype observation'),
('ind_4', 'locus_1', 0, 'Synthetic genotype observation'),
('ind_5', 'locus_1', 2, 'Synthetic genotype observation'),
('ind_6', 'locus_1', 1, 'Synthetic genotype observation'),
('ind_7', 'locus_1', 2, 'Synthetic genotype observation'),
('ind_8', 'locus_1', 0, 'Synthetic genotype observation'),
('ind_9', 'locus_1', 1, 'Synthetic genotype observation'),
('ind_10', 'locus_1', 2, 'Synthetic genotype observation'),
('ind_1', 'locus_2', 1, 'Synthetic genotype observation'),
('ind_2', 'locus_2', 1, 'Synthetic genotype observation'),
('ind_3', 'locus_2', 0, 'Synthetic genotype observation'),
('ind_4', 'locus_2', 0, 'Synthetic genotype observation'),
('ind_5', 'locus_2', 1, 'Synthetic genotype observation'),
('ind_6', 'locus_2', 2, 'Synthetic genotype observation'),
('ind_7', 'locus_2', 1, 'Synthetic genotype observation'),
('ind_8', 'locus_2', 0, 'Synthetic genotype observation'),
('ind_9', 'locus_2', 1, 'Synthetic genotype observation'),
('ind_10', 'locus_2', 1, 'Synthetic genotype observation');

INSERT INTO multipop_allele_frequencies
(locus, population_name, allele_frequency, notes)
VALUES
(1, 'pop1', 0.42, 'Synthetic allele frequency'),
(1, 'pop2', 0.45, 'Synthetic allele frequency'),
(1, 'pop3', 0.20, 'Synthetic allele frequency'),
(1, 'pop4', 0.48, 'Synthetic allele frequency'),
(2, 'pop1', 0.61, 'Synthetic allele frequency'),
(2, 'pop2', 0.59, 'Synthetic allele frequency'),
(2, 'pop3', 0.71, 'Synthetic allele frequency'),
(2, 'pop4', 0.64, 'Synthetic allele frequency'),
(3, 'pop1', 0.25, 'Synthetic allele frequency'),
(3, 'pop2', 0.34, 'Synthetic allele frequency'),
(3, 'pop3', 0.12, 'Synthetic allele frequency'),
(3, 'pop4', 0.31, 'Synthetic allele frequency');

INSERT INTO migration_selection_scenarios
(scenario_name, generations, p1_initial, p2_initial, migration_12, migration_21, selection_1, selection_2, notes)
VALUES
('local_adaptation_with_gene_flow', 150, 0.80, 0.20, 0.03, 0.03, 0.08, -0.04, 'Synthetic migration-selection scenario'),
('strong_gene_flow', 150, 0.80, 0.20, 0.10, 0.10, 0.08, -0.04, 'Synthetic migration-selection scenario'),
('asymmetric_migration', 150, 0.75, 0.25, 0.08, 0.01, 0.06, -0.03, 'Synthetic migration-selection scenario'),
('weak_selection', 150, 0.75, 0.25, 0.03, 0.03, 0.02, -0.01, 'Synthetic migration-selection scenario');

INSERT INTO population_condition_sites
(site_name, heterozygosity, allelic_richness, gene_flow, fragmentation_pressure, bottleneck_risk, adaptive_capacity, notes)
VALUES
('reference_metapopulation', 0.72, 0.68, 0.66, 0.22, 0.18, 0.70, 'Synthetic condition site'),
('isolated_fragment', 0.38, 0.35, 0.22, 0.78, 0.74, 0.31, 'Synthetic condition site'),
('restoration_source_mix', 0.61, 0.58, 0.52, 0.35, 0.30, 0.62, 'Synthetic condition site'),
('pathogen_resistance_pool', 0.82, 0.74, 0.48, 0.28, 0.25, 0.86, 'Synthetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('population_genetics_scenarios.csv', 'synthetic_example', 'constructed_example', 'selection-mutation-migration-drift simulation', 'MIT-compatible example data', 'single-locus scenario setup', 'Not real population-genetic data'),
('genotype_matrix.csv', 'synthetic_example', 'constructed_example', 'genotype-matrix Hardy-Weinberg screening', 'MIT-compatible example data', 'genotype coding setup', 'Not real genotype data'),
('multipop_allele_frequencies.csv', 'synthetic_example', 'constructed_example', 'FST-style population structure screening', 'MIT-compatible example data', 'multi-population frequency setup', 'Not real population structure data'),
('migration_selection_scenarios.csv', 'synthetic_example', 'constructed_example', 'migration-selection balance simulation', 'MIT-compatible example data', 'two-population scenario setup', 'Not real local adaptation data');
