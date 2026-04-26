-- Speciation, diversity, and tree-of-life reproducibility schema.
--
-- This schema tracks divergence scenarios, aligned sequences, birth-death
-- scenarios, speciation condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS divergence_scenarios;
DROP TABLE IF EXISTS aligned_sequences;
DROP TABLE IF EXISTS birth_death_scenarios;
DROP TABLE IF EXISTS speciation_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE divergence_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    generations INTEGER NOT NULL,
    loci INTEGER NOT NULL,
    population_1_size INTEGER NOT NULL,
    population_2_size INTEGER NOT NULL,
    migration_12 REAL NOT NULL,
    migration_21 REAL NOT NULL,
    selection_sd REAL NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE aligned_sequences (
    sequence_id INTEGER PRIMARY KEY,
    taxon_name TEXT NOT NULL UNIQUE,
    sequence_text TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE birth_death_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    time_steps INTEGER NOT NULL,
    initial_richness INTEGER NOT NULL,
    lambda_rate REAL NOT NULL,
    mu_rate REAL NOT NULL,
    n_iter INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE speciation_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    allele_divergence REAL NOT NULL,
    reproductive_isolation REAL NOT NULL,
    ecological_difference REAL NOT NULL,
    phylogenetic_resolution REAL NOT NULL,
    gene_flow_risk REAL NOT NULL,
    lineage_distinctiveness REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    mean_delta_p REAL,
    mean_fst REAL,
    max_fst REAL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    final_richness REAL,
    peak_richness REAL,
    extinction_probability REAL,
    speciation_condition_score REAL,
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

INSERT INTO divergence_scenarios
(scenario_name, generations, loci, population_1_size, population_2_size, migration_12, migration_21, selection_sd, seed, notes)
VALUES
('low_migration', 250, 300, 300, 300, 0.002, 0.002, 0.015, 42, 'Synthetic low migration divergence scenario'),
('higher_migration', 250, 300, 300, 300, 0.020, 0.020, 0.015, 43, 'Synthetic higher migration scenario'),
('stronger_selection', 250, 300, 300, 300, 0.002, 0.002, 0.030, 44, 'Synthetic stronger selection scenario'),
('small_population_drift', 250, 300, 100, 100, 0.002, 0.002, 0.010, 45, 'Synthetic small population drift scenario');

INSERT INTO aligned_sequences
(taxon_name, sequence_text, notes)
VALUES
('A', 'ATGCTAGCTAACGGTACCTA', 'Synthetic aligned sequence'),
('B', 'ATGCTGGCTATCGGTACCTA', 'Synthetic aligned sequence'),
('C', 'ATGATGGCTATCGGTTCCTA', 'Synthetic aligned sequence'),
('D', 'ATGCTAGTTAACGGAACCTG', 'Synthetic aligned sequence'),
('E', 'ATGCTAGCTAACGGAACCTA', 'Synthetic aligned sequence');

INSERT INTO birth_death_scenarios
(scenario_name, time_steps, initial_richness, lambda_rate, mu_rate, n_iter, notes)
VALUES
('net_positive', 120, 8, 0.10, 0.03, 1000, 'Synthetic positive diversification'),
('near_equilibrium', 120, 8, 0.07, 0.06, 1000, 'Synthetic near equilibrium'),
('high_turnover', 120, 8, 0.14, 0.12, 1000, 'Synthetic high turnover'),
('high_extinction', 120, 8, 0.06, 0.11, 1000, 'Synthetic high extinction');

INSERT INTO speciation_condition_sites
(site_name, allele_divergence, reproductive_isolation, ecological_difference, phylogenetic_resolution, gene_flow_risk, lineage_distinctiveness, notes)
VALUES
('reference_pair', 0.68, 0.72, 0.66, 0.78, 0.20, 0.74, 'Synthetic condition site'),
('hybrid_zone', 0.46, 0.38, 0.55, 0.63, 0.72, 0.50, 'Synthetic condition site'),
('island_radiation', 0.74, 0.69, 0.82, 0.70, 0.18, 0.80, 'Synthetic condition site'),
('microbial_complex', 0.51, 0.30, 0.61, 0.52, 0.45, 0.58, 'Synthetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('divergence_scenarios.csv', 'synthetic_example', 'constructed_example', 'divergence-with-gene-flow simulation', 'MIT-compatible example data', 'speciation divergence setup', 'Not real population-genetic data'),
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence distance and Jukes-Cantor correction', 'MIT-compatible example data', 'distance-matrix setup', 'Not real sequence data'),
('birth_death_scenarios.csv', 'synthetic_example', 'constructed_example', 'birth-death diversification simulation', 'MIT-compatible example data', 'lineage-through-time setup', 'Not real diversification data'),
('speciation_condition_sites.csv', 'synthetic_example', 'constructed_example', 'lineage separation condition scoring', 'MIT-compatible example data', 'condition score setup', 'Not real species-delimitation data');
