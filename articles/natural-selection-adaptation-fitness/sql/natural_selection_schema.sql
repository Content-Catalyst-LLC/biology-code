-- Natural selection, adaptation, and fitness reproducibility schema.
--
-- This schema tracks genotype selection scenarios, quantitative trait observations,
-- variable environments, allele-frequency time series, selection condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS selection_scenarios;
DROP TABLE IF EXISTS trait_observations;
DROP TABLE IF EXISTS variable_environment_scenarios;
DROP TABLE IF EXISTS allele_frequency_timeseries;
DROP TABLE IF EXISTS selection_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE selection_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    generations INTEGER NOT NULL,
    initial_allele_frequency REAL NOT NULL,
    fitness_AA REAL NOT NULL,
    fitness_Aa REAL NOT NULL,
    fitness_aa REAL NOT NULL,
    notes TEXT
);

CREATE TABLE trait_observations (
    observation_id INTEGER PRIMARY KEY,
    individual_id TEXT NOT NULL,
    trait_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE variable_environment_scenarios (
    environment_id INTEGER PRIMARY KEY,
    environment_name TEXT NOT NULL UNIQUE,
    fitness_AA REAL NOT NULL,
    fitness_Aa REAL NOT NULL,
    fitness_aa REAL NOT NULL,
    notes TEXT
);

CREATE TABLE allele_frequency_timeseries (
    observation_id INTEGER PRIMARY KEY,
    time_value REAL NOT NULL,
    allele_frequency REAL NOT NULL,
    notes TEXT
);

CREATE TABLE selection_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    standing_variation REAL NOT NULL,
    selection_strength REAL NOT NULL,
    environmental_match REAL NOT NULL,
    demographic_stability REAL NOT NULL,
    gene_flow_support REAL NOT NULL,
    constraint_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    allele_frequency REAL,
    mean_fitness REAL,
    expected_heterozygosity REAL,
    selection_differential REAL,
    heritability REAL,
    response_to_selection REAL,
    fixation_probability REAL,
    loss_probability REAL,
    selection_condition_score REAL,
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

INSERT INTO selection_scenarios
(scenario_name, generations, initial_allele_frequency, fitness_AA, fitness_Aa, fitness_aa, notes)
VALUES
('directional_for_A', 180, 0.20, 1.15, 1.08, 1.00, 'Synthetic directional selection scenario'),
('heterozygote_advantage', 180, 0.20, 0.90, 1.00, 0.80, 'Synthetic balancing selection scenario'),
('heterozygote_disadvantage', 180, 0.50, 1.00, 0.70, 0.95, 'Synthetic heterozygote disadvantage scenario'),
('purifying_against_A', 180, 0.70, 0.75, 0.92, 1.00, 'Synthetic purifying selection scenario');

INSERT INTO trait_observations
(individual_id, trait_value, notes)
VALUES
('ind_1', -1.42, 'Synthetic trait observation'),
('ind_2', -0.91, 'Synthetic trait observation'),
('ind_3', -0.56, 'Synthetic trait observation'),
('ind_4', -0.20, 'Synthetic trait observation'),
('ind_5', 0.03, 'Synthetic trait observation'),
('ind_6', 0.28, 'Synthetic trait observation'),
('ind_7', 0.49, 'Synthetic trait observation'),
('ind_8', 0.77, 'Synthetic trait observation'),
('ind_9', 1.12, 'Synthetic trait observation'),
('ind_10', 1.48, 'Synthetic trait observation');

INSERT INTO variable_environment_scenarios
(environment_name, fitness_AA, fitness_Aa, fitness_aa, notes)
VALUES
('habitat1', 1.10, 1.00, 0.85, 'Synthetic habitat selection regime'),
('habitat2', 0.80, 1.00, 1.10, 'Synthetic habitat selection regime'),
('disturbance', 0.95, 1.02, 0.90, 'Synthetic disturbance selection regime');

INSERT INTO allele_frequency_timeseries
(time_value, allele_frequency, notes)
VALUES
(0, 0.18, 'Synthetic allele-frequency time series'),
(5, 0.21, 'Synthetic allele-frequency time series'),
(10, 0.29, 'Synthetic allele-frequency time series'),
(15, 0.37, 'Synthetic allele-frequency time series'),
(20, 0.49, 'Synthetic allele-frequency time series'),
(25, 0.61, 'Synthetic allele-frequency time series'),
(30, 0.73, 'Synthetic allele-frequency time series');

INSERT INTO selection_condition_sites
(site_name, standing_variation, selection_strength, environmental_match, demographic_stability, gene_flow_support, constraint_risk, notes)
VALUES
('reference_population', 0.72, 0.58, 0.70, 0.74, 0.62, 0.22, 'Synthetic selection condition site'),
('fragmented_adaptation_lag', 0.38, 0.76, 0.34, 0.40, 0.20, 0.71, 'Synthetic selection condition site'),
('pathogen_resistance_system', 0.84, 0.88, 0.79, 0.68, 0.55, 0.25, 'Synthetic selection condition site'),
('restoration_target_site', 0.61, 0.52, 0.57, 0.60, 0.48, 0.36, 'Synthetic selection condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('selection_scenarios.csv', 'synthetic_example', 'constructed_example', 'genotype-specific selection simulation', 'MIT-compatible example data', 'selection scenario setup', 'Not real genotype fitness data'),
('trait_observations.csv', 'synthetic_example', 'constructed_example', 'quantitative trait selection response', 'MIT-compatible example data', 'trait response setup', 'Not real trait data'),
('variable_environment_scenarios.csv', 'synthetic_example', 'constructed_example', 'variable-environment selection', 'MIT-compatible example data', 'environment selection setup', 'Not real habitat fitness data'),
('allele_frequency_timeseries.csv', 'synthetic_example', 'constructed_example', 'time-series allele-frequency screening', 'MIT-compatible example data', 'time-series setup', 'Not real allele-frequency data');
