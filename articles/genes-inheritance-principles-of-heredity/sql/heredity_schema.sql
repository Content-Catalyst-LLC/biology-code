-- Genes, inheritance, and heredity reproducibility schema.
--
-- This schema tracks genotype counts, inheritance ratio tests,
-- recombination observations, quantitative trait examples, heredity condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS genotype_counts;
DROP TABLE IF EXISTS inheritance_ratio_tests;
DROP TABLE IF EXISTS recombination_observations;
DROP TABLE IF EXISTS quantitative_trait_records;
DROP TABLE IF EXISTS heredity_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE genotype_counts (
    genotype TEXT PRIMARY KEY,
    genotype_count INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE inheritance_ratio_tests (
    test_id INTEGER PRIMARY KEY,
    test_name TEXT NOT NULL,
    category_name TEXT NOT NULL,
    observed_count INTEGER NOT NULL,
    expected_ratio REAL NOT NULL,
    notes TEXT
);

CREATE TABLE recombination_observations (
    gamete TEXT PRIMARY KEY,
    gamete_count INTEGER NOT NULL,
    gamete_class TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE quantitative_trait_records (
    individual_id TEXT PRIMARY KEY,
    additive_genetic_value REAL NOT NULL,
    environmental_effect REAL NOT NULL,
    phenotype REAL NOT NULL,
    notes TEXT
);

CREATE TABLE heredity_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    standing_variation REAL NOT NULL,
    inheritance_clarity REAL NOT NULL,
    recombination_information REAL NOT NULL,
    population_size REAL NOT NULL,
    genotype_quality REAL NOT NULL,
    environmental_context REAL NOT NULL,
    inbreeding_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    allele_frequency_p REAL,
    allele_frequency_q REAL,
    expected_heterozygosity REAL,
    chi_square REAL,
    recombination_fraction REAL,
    additive_variance REAL,
    phenotypic_variance REAL,
    h2 REAL,
    predicted_response REAL,
    heredity_condition_score REAL,
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

INSERT INTO genotype_counts
(genotype, genotype_count, notes)
VALUES
('AA', 112, 'Synthetic genotype count'),
('Aa', 196, 'Synthetic genotype count'),
('aa', 92, 'Synthetic genotype count');

INSERT INTO inheritance_ratio_tests
(test_name, category_name, observed_count, expected_ratio, notes)
VALUES
('monohybrid_3_to_1', 'dominant', 315, 0.75, 'Synthetic monohybrid count'),
('monohybrid_3_to_1', 'recessive', 105, 0.25, 'Synthetic monohybrid count'),
('dihybrid_9_3_3_1', 'A_B_', 902, 0.5625, 'Synthetic dihybrid count'),
('dihybrid_9_3_3_1', 'A_bb', 297, 0.1875, 'Synthetic dihybrid count'),
('dihybrid_9_3_3_1', 'aaB_', 305, 0.1875, 'Synthetic dihybrid count'),
('dihybrid_9_3_3_1', 'aabb', 96, 0.0625, 'Synthetic dihybrid count');

INSERT INTO recombination_observations
(gamete, gamete_count, gamete_class, notes)
VALUES
('AB', 410, 'parental', 'Synthetic recombination observation'),
('ab', 405, 'parental', 'Synthetic recombination observation'),
('Ab', 92, 'recombinant', 'Synthetic recombination observation'),
('aB', 93, 'recombinant', 'Synthetic recombination observation');

INSERT INTO quantitative_trait_records
(individual_id, additive_genetic_value, environmental_effect, phenotype, notes)
VALUES
('ind_001',1.2,2.1,53.3,'Synthetic quantitative trait record'),
('ind_002',-0.8,1.6,50.8,'Synthetic quantitative trait record'),
('ind_003',2.4,-0.2,52.2,'Synthetic quantitative trait record'),
('ind_004',-1.6,-2.1,46.3,'Synthetic quantitative trait record'),
('ind_005',0.7,0.4,51.1,'Synthetic quantitative trait record'),
('ind_006',3.1,2.6,55.7,'Synthetic quantitative trait record'),
('ind_007',-2.5,-1.4,46.1,'Synthetic quantitative trait record'),
('ind_008',1.9,-0.6,51.3,'Synthetic quantitative trait record'),
('ind_009',0.2,1.8,52.0,'Synthetic quantitative trait record'),
('ind_010',-1.1,0.3,49.2,'Synthetic quantitative trait record');

INSERT INTO heredity_condition_sites
(site_name, standing_variation, inheritance_clarity, recombination_information, population_size, genotype_quality, environmental_context, inbreeding_risk, notes)
VALUES
('reference_population',0.76,0.78,0.64,0.72,0.81,0.70,0.18,'Synthetic heredity condition site'),
('bottlenecked_population',0.32,0.66,0.40,0.28,0.70,0.58,0.72,'Synthetic heredity condition site'),
('crop_breeding_panel',0.82,0.74,0.70,0.68,0.76,0.62,0.22,'Synthetic heredity condition site'),
('restoration_seed_source',0.58,0.60,0.44,0.52,0.66,0.80,0.36,'Synthetic heredity condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('genotype_counts.csv', 'synthetic_example', 'constructed_example', 'allele frequency and heterozygosity estimation', 'MIT-compatible example data', 'genotype count setup', 'Not real genotype data'),
('monohybrid_counts.csv', 'synthetic_example', 'constructed_example', 'chi-square goodness-of-fit for 3:1 ratio', 'MIT-compatible example data', 'monohybrid test setup', 'Not real cross data'),
('dihybrid_counts.csv', 'synthetic_example', 'constructed_example', 'chi-square goodness-of-fit for 9:3:3:1 ratio', 'MIT-compatible example data', 'dihybrid test setup', 'Not real cross data'),
('recombination_observations.csv', 'synthetic_example', 'constructed_example', 'recombination fraction estimation', 'MIT-compatible example data', 'recombination setup', 'Not real linkage data'),
('quantitative_trait.csv', 'synthetic_example', 'constructed_example', 'heritability and response-to-selection scaffold', 'MIT-compatible example data', 'quantitative trait setup', 'Not real quantitative genetics data');
