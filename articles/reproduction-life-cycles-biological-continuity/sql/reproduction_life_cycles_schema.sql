-- Reproduction, life cycles, and biological continuity reproducibility schema.
--
-- This schema tracks life stages, transition rates, reproductive scenarios,
-- life-history units, model outputs, and provenance metadata.

DROP TABLE IF EXISTS life_stages;
DROP TABLE IF EXISTS stage_matrix_entries;
DROP TABLE IF EXISTS initial_stage_vectors;
DROP TABLE IF EXISTS life_history_units;
DROP TABLE IF EXISTS reproductive_scenarios;
DROP TABLE IF EXISTS model_runs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE life_stages (
    stage_id INTEGER PRIMARY KEY,
    stage_name TEXT NOT NULL UNIQUE,
    stage_order INTEGER,
    primary_function TEXT,
    vulnerability_notes TEXT
);

CREATE TABLE stage_matrix_entries (
    entry_id INTEGER PRIMARY KEY,
    matrix_name TEXT NOT NULL,
    destination_stage TEXT NOT NULL,
    source_stage TEXT NOT NULL,
    value REAL NOT NULL,
    biological_interpretation TEXT
);

CREATE TABLE initial_stage_vectors (
    vector_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL,
    stage_name TEXT NOT NULL,
    count REAL NOT NULL
);

CREATE TABLE life_history_units (
    unit_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL UNIQUE,
    fecundity REAL NOT NULL,
    juvenile_survival REAL NOT NULL,
    adult_survival REAL NOT NULL,
    maturation_rate REAL NOT NULL,
    dormancy_or_buffering REAL NOT NULL,
    environmental_stress REAL NOT NULL,
    notes TEXT
);

CREATE TABLE reproductive_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    adult_survival_multiplier REAL NOT NULL,
    juvenile_survival_multiplier REAL NOT NULL,
    environmental_stress_increase REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_runs (
    run_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL,
    model_name TEXT NOT NULL,
    dominant_lambda REAL,
    final_total_abundance REAL,
    continuity_score_mean REAL,
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

INSERT INTO life_stages
(stage_name, stage_order, primary_function, vulnerability_notes)
VALUES
('dormant_propagule', 0, 'buffering and delayed recruitment', 'depends on viability and environmental trigger'),
('juvenile', 1, 'growth and early survival', 'high predation or establishment risk'),
('subadult', 2, 'maturation and transition', 'depends on growth and resource availability'),
('adult', 3, 'reproduction and persistence', 'sensitive to adult survival and fecundity');

INSERT INTO stage_matrix_entries
(matrix_name, destination_stage, source_stage, value, biological_interpretation)
VALUES
('baseline_life_cycle_matrix', 'juvenile', 'juvenile', 0.0, 'No juvenile self-loop in compact model'),
('baseline_life_cycle_matrix', 'juvenile', 'subadult', 0.0, 'No subadult fecundity in compact model'),
('baseline_life_cycle_matrix', 'juvenile', 'adult', 1.8, 'Adult fecundity producing juveniles'),
('baseline_life_cycle_matrix', 'subadult', 'juvenile', 0.45, 'Juvenile survival to subadult'),
('baseline_life_cycle_matrix', 'subadult', 'subadult', 0.0, 'No subadult self-loop in compact model'),
('baseline_life_cycle_matrix', 'subadult', 'adult', 0.0, 'No reverse transition'),
('baseline_life_cycle_matrix', 'adult', 'juvenile', 0.0, 'No direct juvenile to adult transition'),
('baseline_life_cycle_matrix', 'adult', 'subadult', 0.70, 'Subadult maturation to adult'),
('baseline_life_cycle_matrix', 'adult', 'adult', 0.82, 'Adult survival');

INSERT INTO initial_stage_vectors
(scenario_name, stage_name, count)
VALUES
('baseline', 'juvenile', 50),
('baseline', 'subadult', 20),
('baseline', 'adult', 15);

INSERT INTO life_history_units
(unit_code, fecundity, juvenile_survival, adult_survival, maturation_rate, dormancy_or_buffering, environmental_stress, notes)
VALUES
('A', 2.4, 0.35, 0.82, 0.50, 0.40, 0.25, 'Synthetic life-history unit A'),
('B', 1.9, 0.55, 0.88, 0.40, 0.52, 0.20, 'Synthetic life-history unit B'),
('C', 3.1, 0.22, 0.60, 0.65, 0.30, 0.50, 'Synthetic life-history unit C'),
('D', 1.3, 0.68, 0.92, 0.30, 0.60, 0.18, 'Synthetic life-history unit D'),
('E', 2.2, 0.40, 0.76, 0.48, 0.45, 0.32, 'Synthetic life-history unit E');

INSERT INTO reproductive_scenarios
(scenario_name, adult_survival_multiplier, juvenile_survival_multiplier, environmental_stress_increase, notes)
VALUES
('baseline', 1.00, 1.00, 0.00, 'Baseline synthetic condition'),
('adult_survival_decline', 0.90, 1.00, 0.00, 'Adult survival reduced by ten percent'),
('juvenile_stress', 1.00, 0.85, 0.10, 'Juvenile survival reduced and stress increased'),
('restoration_gain', 1.05, 1.10, -0.08, 'Improved survival and reduced stress'),
('high_stress', 0.95, 0.80, 0.18, 'Combined environmental stress scenario');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('stage_matrix.csv', 'synthetic_example', 'constructed_example', 'stage-structured projection matrix', 'MIT-compatible example data', 'life-cycle projection setup', 'Not real reproductive biology data'),
('life_history_units.csv', 'synthetic_example', 'constructed_example', 'continuity scoring model', 'MIT-compatible example data', 'comparative life-history screening', 'Not real reproductive biology data');
