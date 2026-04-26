-- Population dynamics and ecological modeling reproducibility schema.
--
-- This schema tracks populations, vital rates, stage matrices, scenarios,
-- model runs, and provenance metadata.

DROP TABLE IF EXISTS populations;
DROP TABLE IF EXISTS vital_rates;
DROP TABLE IF EXISTS stage_matrix_entries;
DROP TABLE IF EXISTS scenario_definitions;
DROP TABLE IF EXISTS model_runs;
DROP TABLE IF EXISTS metapopulation_scenarios;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE populations (
    population_id TEXT PRIMARY KEY,
    species_code TEXT NOT NULL,
    habitat_type TEXT,
    region TEXT,
    initial_population REAL,
    notes TEXT
);

CREATE TABLE vital_rates (
    vital_rate_id INTEGER PRIMARY KEY,
    population_id TEXT NOT NULL,
    stage TEXT NOT NULL,
    survival REAL,
    transition_probability REAL,
    fecundity REAL,
    notes TEXT,
    FOREIGN KEY (population_id) REFERENCES populations(population_id)
);

CREATE TABLE stage_matrix_entries (
    entry_id INTEGER PRIMARY KEY,
    matrix_name TEXT NOT NULL,
    destination_stage TEXT NOT NULL,
    source_stage TEXT NOT NULL,
    value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE scenario_definitions (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_population REAL NOT NULL,
    growth_rate_mean REAL NOT NULL,
    growth_rate_sd REAL NOT NULL,
    carrying_capacity_mean REAL NOT NULL,
    carrying_capacity_sd REAL NOT NULL,
    harvest REAL NOT NULL,
    catastrophe_probability REAL NOT NULL,
    catastrophe_multiplier REAL NOT NULL,
    quasi_extinction_threshold REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_runs (
    run_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL,
    model_name TEXT NOT NULL,
    extinction_risk REAL,
    quasi_extinction_risk REAL,
    mean_final_population REAL,
    median_final_population REAL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (scenario_name) REFERENCES scenario_definitions(scenario_name)
);

CREATE TABLE metapopulation_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_occupancy REAL NOT NULL,
    colonization_rate REAL NOT NULL,
    extinction_rate REAL NOT NULL,
    years INTEGER NOT NULL,
    notes TEXT
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

INSERT INTO populations
(population_id, species_code, habitat_type, region, initial_population, notes)
VALUES
('pop_A', 'species_A', 'forest_patch', 'example_region', 80, 'Synthetic example population');

INSERT INTO vital_rates
(population_id, stage, survival, transition_probability, fecundity, notes)
VALUES
('pop_A', 'juveniles', 0.45, 0.45, 0.00, 'Synthetic juvenile stage'),
('pop_A', 'subadults', 0.70, 0.70, 0.00, 'Synthetic subadult stage'),
('pop_A', 'adults', 0.82, 0.82, 1.80, 'Synthetic adult stage');

INSERT INTO stage_matrix_entries
(matrix_name, destination_stage, source_stage, value, notes)
VALUES
('baseline_stage_matrix', 'juveniles', 'juveniles', 0.0, 'No juvenile self-loop in example'),
('baseline_stage_matrix', 'juveniles', 'subadults', 0.0, 'No subadult fecundity in example'),
('baseline_stage_matrix', 'juveniles', 'adults', 1.8, 'Adult fecundity'),
('baseline_stage_matrix', 'subadults', 'juveniles', 0.45, 'Juvenile survival to subadult'),
('baseline_stage_matrix', 'subadults', 'subadults', 0.0, 'No subadult self-loop in example'),
('baseline_stage_matrix', 'subadults', 'adults', 0.0, 'No adult to subadult transition'),
('baseline_stage_matrix', 'adults', 'juveniles', 0.0, 'No juvenile to adult direct transition'),
('baseline_stage_matrix', 'adults', 'subadults', 0.70, 'Subadult survival to adult'),
('baseline_stage_matrix', 'adults', 'adults', 0.82, 'Adult survival');

INSERT INTO scenario_definitions
(scenario_name, initial_population, growth_rate_mean, growth_rate_sd, carrying_capacity_mean, carrying_capacity_sd, harvest, catastrophe_probability, catastrophe_multiplier, quasi_extinction_threshold, notes)
VALUES
('baseline', 80, 0.18, 0.08, 500, 40, 5, 0.05, 0.60, 20, 'Current synthetic condition'),
('higher_harvest', 80, 0.18, 0.08, 500, 40, 15, 0.05, 0.60, 20, 'Higher harvest pressure'),
('lower_capacity', 80, 0.15, 0.10, 300, 60, 5, 0.06, 0.55, 20, 'Lower carrying capacity'),
('restoration_gain', 80, 0.20, 0.07, 650, 50, 3, 0.03, 0.70, 20, 'Improved capacity and lower pressure'),
('catastrophe_stress', 80, 0.18, 0.08, 500, 40, 5, 0.12, 0.50, 20, 'Higher catastrophe risk');

INSERT INTO metapopulation_scenarios
(scenario_name, initial_occupancy, colonization_rate, extinction_rate, years, notes)
VALUES
('baseline', 0.35, 0.28, 0.08, 60, 'Baseline occupancy'),
('fragmented', 0.35, 0.12, 0.12, 60, 'Reduced colonization and increased extinction'),
('corridor_restoration', 0.35, 0.38, 0.06, 60, 'Higher colonization and lower extinction'),
('disturbance_pressure', 0.35, 0.18, 0.18, 60, 'Increased local extinction pressure');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('population_scenarios.csv', 'synthetic_example', 'constructed_example', 'stochastic logistic viability simulation', 'MIT-compatible example data', 'scenario table for population viability examples', 'Not real population data');
