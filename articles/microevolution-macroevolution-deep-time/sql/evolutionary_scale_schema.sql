-- Microevolution, macroevolution, and deep time reproducibility schema.
--
-- This schema tracks population scenarios, aligned sequences, clade turnover,
-- birth-death scenarios, evolutionary-scale diagnostic examples, model outputs,
-- and provenance.

DROP TABLE IF EXISTS population_scenarios;
DROP TABLE IF EXISTS aligned_sequences;
DROP TABLE IF EXISTS clade_turnover;
DROP TABLE IF EXISTS birth_death_scenarios;
DROP TABLE IF EXISTS evolutionary_scale_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE population_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_allele_frequency REAL NOT NULL,
    population_size INTEGER NOT NULL,
    fitness_AA REAL NOT NULL,
    fitness_Aa REAL NOT NULL,
    fitness_aa REAL NOT NULL,
    mutation_A_to_a REAL NOT NULL,
    mutation_a_to_A REAL NOT NULL,
    migration_fraction REAL NOT NULL,
    migrant_allele_frequency REAL NOT NULL,
    drift_enabled TEXT NOT NULL,
    generations INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE aligned_sequences (
    sequence_id INTEGER PRIMARY KEY,
    lineage_name TEXT NOT NULL UNIQUE,
    sequence_text TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE clade_turnover (
    clade_id INTEGER PRIMARY KEY,
    clade_name TEXT NOT NULL UNIQUE,
    originations REAL NOT NULL,
    extinctions REAL NOT NULL,
    interval_myr REAL NOT NULL,
    notes TEXT
);

CREATE TABLE birth_death_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_lineages INTEGER NOT NULL,
    intervals INTEGER NOT NULL,
    lambda_rate REAL NOT NULL,
    mu_rate REAL NOT NULL,
    n_iter INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE evolutionary_scale_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    population_variation REAL NOT NULL,
    lineage_distinctiveness REAL NOT NULL,
    fossil_record_strength REAL NOT NULL,
    phylogenetic_resolution REAL NOT NULL,
    extinction_pressure REAL NOT NULL,
    adaptive_capacity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    allele_frequency REAL,
    heterozygosity REAL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    lambda_rate REAL,
    mu_rate REAL,
    net_diversification REAL,
    turnover REAL,
    final_lineages REAL,
    evolutionary_scale_score REAL,
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

INSERT INTO population_scenarios
(scenario_name, initial_allele_frequency, population_size, fitness_AA, fitness_Aa, fitness_aa, mutation_A_to_a, mutation_a_to_A, migration_fraction, migrant_allele_frequency, drift_enabled, generations, notes)
VALUES
('neutral_largeN', 0.50, 5000, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.00, 0.50, 'true', 120, 'Synthetic neutral scenario'),
('positive_selection', 0.20, 1000, 1.15, 1.08, 1.00, 0.0000, 0.0000, 0.00, 0.50, 'true', 120, 'Synthetic positive selection scenario'),
('migration_balance', 0.90, 1000, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.05, 0.20, 'true', 120, 'Synthetic migration scenario'),
('mutation_selection', 0.95, 2000, 1.00, 0.98, 0.92, 0.0010, 0.0000, 0.00, 0.50, 'false', 120, 'Synthetic mutation-selection scenario');

INSERT INTO aligned_sequences
(lineage_name, sequence_text, notes)
VALUES
('lineage_A', 'ATGCTAGCTAACGGTACCTA', 'Synthetic aligned sequence'),
('lineage_B', 'ATGCTGGCTATCGGTACCTA', 'Synthetic aligned sequence'),
('lineage_C', 'ATGATAGCTAACGGTTCCTA', 'Synthetic aligned sequence'),
('lineage_D', 'ATGCTAGTTAACGGAACCTG', 'Synthetic aligned sequence');

INSERT INTO clade_turnover
(clade_name, originations, extinctions, interval_myr, notes)
VALUES
('Clade_A', 18, 7, 20, 'Synthetic clade turnover example'),
('Clade_B', 9, 8, 20, 'Synthetic clade turnover example'),
('Clade_C', 25, 10, 20, 'Synthetic clade turnover example'),
('Clade_D', 12, 14, 20, 'Synthetic clade turnover example'),
('Clade_E', 15, 5, 30, 'Synthetic clade turnover example');

INSERT INTO birth_death_scenarios
(scenario_name, initial_lineages, intervals, lambda_rate, mu_rate, n_iter, notes)
VALUES
('balanced_turnover', 20, 50, 0.10, 0.10, 500, 'Synthetic balanced turnover'),
('positive_diversification', 20, 50, 0.12, 0.08, 500, 'Synthetic positive diversification'),
('high_extinction', 20, 50, 0.08, 0.13, 500, 'Synthetic high extinction'),
('rapid_radiation', 20, 50, 0.18, 0.05, 500, 'Synthetic rapid radiation');

INSERT INTO evolutionary_scale_sites
(site_name, population_variation, lineage_distinctiveness, fossil_record_strength, phylogenetic_resolution, extinction_pressure, adaptive_capacity, notes)
VALUES
('reference_clade', 0.72, 0.66, 0.80, 0.78, 0.22, 0.70, 'Synthetic evolutionary-scale diagnostic'),
('fragmented_population_complex', 0.48, 0.74, 0.42, 0.60, 0.66, 0.38, 'Synthetic evolutionary-scale diagnostic'),
('well_sampled_fossil_group', 0.51, 0.62, 0.91, 0.70, 0.35, 0.54, 'Synthetic evolutionary-scale diagnostic'),
('rapidly_evolving_pathogen', 0.88, 0.41, 0.20, 0.82, 0.30, 0.86, 'Synthetic evolutionary-scale diagnostic');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('population_scenarios.csv', 'synthetic_example', 'constructed_example', 'population-genetic simulation', 'MIT-compatible example data', 'microevolution scenario setup', 'Not real population data'),
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence divergence and Jukes-Cantor distance', 'MIT-compatible example data', 'sequence-distance setup', 'Not real sequence data'),
('clade_turnover.csv', 'synthetic_example', 'constructed_example', 'origination-extinction turnover', 'MIT-compatible example data', 'macroevolution scenario setup', 'Not real fossil or clade data'),
('birth_death_scenarios.csv', 'synthetic_example', 'constructed_example', 'birth-death Monte Carlo screening', 'MIT-compatible example data', 'diversification scenario setup', 'Not real diversification data');
