-- Life, death, and biological definition reproducibility schema.
--
-- This schema tracks viability observations, dormancy scenarios,
-- host-virus scenarios, life-criteria weights, borderline cases,
-- model outputs, and provenance.

DROP TABLE IF EXISTS viability_observations;
DROP TABLE IF EXISTS dormancy_scenarios;
DROP TABLE IF EXISTS host_virus_scenarios;
DROP TABLE IF EXISTS life_criteria_weights;
DROP TABLE IF EXISTS borderline_cases;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE viability_observations (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    live_cells REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE dormancy_scenarios (
    scenario_id TEXT PRIMARY KEY,
    dormant_initial REAL NOT NULL,
    active_initial REAL NOT NULL,
    mortality_rate REAL NOT NULL,
    reactivation_rate REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE host_virus_scenarios (
    scenario_id TEXT PRIMARY KEY,
    target_initial REAL NOT NULL,
    infected_initial REAL NOT NULL,
    virus_initial REAL NOT NULL,
    beta REAL NOT NULL,
    delta REAL NOT NULL,
    production REAL NOT NULL,
    clearance REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE life_criteria_weights (
    criterion TEXT PRIMARY KEY,
    weight REAL NOT NULL,
    notes TEXT
);

CREATE TABLE borderline_cases (
    case_id TEXT PRIMARY KEY,
    organization REAL NOT NULL,
    metabolism REAL NOT NULL,
    autonomy REAL NOT NULL,
    heredity REAL NOT NULL,
    responsiveness REAL NOT NULL,
    evolutionary_capacity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    loss_rate_per_h REAL,
    half_life_h REAL,
    survival_probability REAL,
    final_dormant REAL,
    final_active REAL,
    final_dead_or_lost REAL,
    final_target_cells REAL,
    final_infected_cells REAL,
    final_free_virus REAL,
    heuristic_life_score REAL,
    category TEXT,
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

INSERT INTO viability_observations
(time_h, live_cells, condition_name, notes)
VALUES
(0,1000000,'stress_condition','Synthetic viability observation'),
(12,740000,'stress_condition','Synthetic viability observation'),
(24,550000,'stress_condition','Synthetic viability observation'),
(36,380000,'stress_condition','Synthetic viability observation'),
(48,250000,'stress_condition','Synthetic viability observation'),
(0,1000000,'protective_condition','Synthetic viability observation'),
(12,860000,'protective_condition','Synthetic viability observation'),
(24,730000,'protective_condition','Synthetic viability observation'),
(36,630000,'protective_condition','Synthetic viability observation'),
(48,540000,'protective_condition','Synthetic viability observation');

INSERT INTO dormancy_scenarios
(scenario_id, dormant_initial, active_initial, mortality_rate, reactivation_rate, time_end, dt, notes)
VALUES
('baseline_dormancy',1000000,0,0.020,0.050,20,0.01,'Synthetic dormancy scenario'),
('low_reactivation',1000000,0,0.020,0.015,20,0.01,'Synthetic dormancy scenario'),
('high_mortality',1000000,0,0.080,0.050,20,0.01,'Synthetic dormancy scenario'),
('protective_dormancy',1000000,0,0.005,0.030,20,0.01,'Synthetic dormancy scenario');

INSERT INTO host_virus_scenarios
(scenario_id, target_initial, infected_initial, virus_initial, beta, delta, production, clearance, time_end, dt, notes)
VALUES
('baseline',1000000,0,1000,0.00000002,0.50,100,2.0,10,0.01,'Synthetic host-virus scenario'),
('low_infection',1000000,0,1000,0.000000005,0.50,100,2.0,10,0.01,'Synthetic host-virus scenario'),
('high_clearance',1000000,0,1000,0.00000002,0.50,100,5.0,10,0.01,'Synthetic host-virus scenario'),
('low_production',1000000,0,1000,0.00000002,0.50,25,2.0,10,0.01,'Synthetic host-virus scenario');

INSERT INTO life_criteria_weights
(criterion, weight, notes)
VALUES
('organization',0.18,'Heuristic weight'),
('metabolism',0.18,'Heuristic weight'),
('autonomy',0.16,'Heuristic weight'),
('heredity',0.18,'Heuristic weight'),
('responsiveness',0.12,'Heuristic weight'),
('evolutionary_capacity',0.18,'Heuristic weight');

INSERT INTO borderline_cases
(case_id, organization, metabolism, autonomy, heredity, responsiveness, evolutionary_capacity, notes)
VALUES
('bacterium',0.95,0.90,0.88,0.90,0.85,0.90,'Synthetic borderline comparison case'),
('virus',0.55,0.05,0.10,0.82,0.25,0.88,'Synthetic borderline comparison case'),
('dormant_seed',0.80,0.20,0.45,0.86,0.40,0.80,'Synthetic borderline comparison case'),
('sterile_mule',0.95,0.88,0.92,0.80,0.90,0.20,'Synthetic borderline comparison case'),
('fungal_spore',0.82,0.18,0.50,0.84,0.38,0.78,'Synthetic borderline comparison case'),
('synthetic_cell_candidate',0.70,0.55,0.50,0.60,0.45,0.35,'Synthetic borderline comparison case'),
('crystal',0.35,0.00,0.00,0.00,0.05,0.00,'Synthetic borderline comparison case');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('viability_observations.csv', 'synthetic_example', 'constructed_example', 'log-linear viability-decay fitting', 'MIT-compatible example data', 'viability setup', 'Not real clinical or assay data'),
('dormancy_scenarios.csv', 'synthetic_example', 'constructed_example', 'dormancy loss and reactivation simulation', 'MIT-compatible example data', 'dormancy setup', 'Not real seed-bank or microbial persistence data'),
('host_virus_scenarios.csv', 'synthetic_example', 'constructed_example', 'host-virus dynamics simulation', 'MIT-compatible example data', 'viral dynamics setup', 'Not real viral kinetics data'),
('borderline_cases.csv', 'synthetic_example', 'constructed_example', 'heuristic life-criteria matrix', 'MIT-compatible example data', 'criteria setup', 'Not a universal definition of life'),
('life_criteria_weights.csv', 'synthetic_example', 'constructed_example', 'explicit criteria weighting', 'MIT-compatible example data', 'weight setup', 'Weights are illustrative assumptions');
