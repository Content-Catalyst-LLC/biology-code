-- Immunology and biological defense reproducibility schema.
--
-- This schema tracks immune compartments, scenarios, thresholds, model outputs,
-- and provenance metadata.

DROP TABLE IF EXISTS immune_compartments;
DROP TABLE IF EXISTS immune_scenarios;
DROP TABLE IF EXISTS immune_thresholds;
DROP TABLE IF EXISTS immune_condition_scenarios;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE immune_compartments (
    compartment_id INTEGER PRIMARY KEY,
    compartment_name TEXT NOT NULL UNIQUE,
    description TEXT,
    example_measure TEXT
);

CREATE TABLE immune_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_pathogen REAL NOT NULL,
    initial_immune REAL NOT NULL,
    initial_damage REAL NOT NULL,
    pathogen_growth_rate REAL NOT NULL,
    clearance_coefficient REAL NOT NULL,
    immune_activation_rate REAL NOT NULL,
    immune_decay_rate REAL NOT NULL,
    damage_generation_rate REAL NOT NULL,
    repair_resolution_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE immune_thresholds (
    threshold_id INTEGER PRIMARY KEY,
    threshold_name TEXT NOT NULL UNIQUE,
    value REAL NOT NULL,
    description TEXT
);

CREATE TABLE immune_condition_scenarios (
    condition_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    clearance_capacity REAL NOT NULL,
    activation_capacity REAL NOT NULL,
    regulatory_capacity REAL NOT NULL,
    damage_pressure REAL NOT NULL,
    stress_load REAL NOT NULL,
    memory_support REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    peak_pathogen REAL,
    peak_immune REAL,
    peak_damage REAL,
    final_pathogen REAL,
    final_immune REAL,
    final_damage REAL,
    risk_class TEXT,
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

INSERT INTO immune_compartments
(compartment_name, description, example_measure)
VALUES
('pathogen_load', 'replicating infectious burden', 'viral copies or bacterial abundance'),
('immune_activity', 'effector immune response intensity', 'immune-cell activity or cytokine proxy'),
('damage_burden', 'inflammatory or tissue-damage burden', 'tissue injury or inflammation proxy'),
('regulatory_capacity', 'immune damping and tolerance capacity', 'anti-inflammatory regulation proxy'),
('memory_support', 'durable memory or trained response proxy', 'memory cells or protective antibody proxy');

INSERT INTO immune_scenarios
(scenario_name, initial_pathogen, initial_immune, initial_damage, pathogen_growth_rate, clearance_coefficient, immune_activation_rate, immune_decay_rate, damage_generation_rate, repair_resolution_rate, notes)
VALUES
('weak_clearance', 50, 2, 0, 0.45, 0.08, 0.06, 0.18, 0.06, 0.10, 'Weak immune clearance synthetic scenario'),
('moderate_clearance', 50, 2, 0, 0.45, 0.12, 0.08, 0.18, 0.06, 0.10, 'Moderate immune clearance synthetic scenario'),
('strong_clearance', 50, 2, 0, 0.45, 0.18, 0.10, 0.18, 0.06, 0.10, 'Strong immune clearance synthetic scenario'),
('hyperinflammatory', 50, 2, 0, 0.45, 0.14, 0.12, 0.18, 0.12, 0.10, 'Higher immune activation and damage generation'),
('immune_suppressed', 50, 2, 0, 0.45, 0.06, 0.04, 0.24, 0.05, 0.10, 'Reduced activation and clearance synthetic scenario');

INSERT INTO immune_thresholds
(threshold_name, value, description)
VALUES
('peak_pathogen_high', 200, 'illustrative high pathogen burden threshold'),
('peak_pathogen_stressed', 100, 'illustrative stressed pathogen burden threshold'),
('peak_damage_high', 20, 'illustrative high inflammatory damage threshold'),
('peak_damage_stressed', 10, 'illustrative stressed inflammatory damage threshold');

INSERT INTO immune_condition_scenarios
(scenario_name, clearance_capacity, activation_capacity, regulatory_capacity, damage_pressure, stress_load, memory_support, notes)
VALUES
('baseline', 0.75, 0.70, 0.72, 0.25, 0.25, 0.70, 'Baseline immune condition'),
('high_pathogen_pressure', 0.70, 0.75, 0.65, 0.45, 0.40, 0.68, 'Higher pathogen pressure and stress'),
('immune_suppression', 0.45, 0.40, 0.70, 0.30, 0.55, 0.50, 'Suppressed activation and clearance'),
('hyperinflammatory', 0.78, 0.90, 0.35, 0.75, 0.50, 0.65, 'High activation with weak regulation'),
('recovery_supported', 0.82, 0.74, 0.84, 0.20, 0.18, 0.78, 'Improved regulation and memory support');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('immune_scenarios.csv', 'synthetic_example', 'constructed_example', 'coupled host-pathogen-immune model', 'MIT-compatible example data', 'scenario setup for immune dynamics', 'Not real immunological data'),
('immune_condition_scenarios.csv', 'synthetic_example', 'constructed_example', 'immune condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not real immunological data'),
('immune_thresholds.csv', 'synthetic_example', 'constructed_example', 'threshold risk classification', 'MIT-compatible example data', 'illustrative threshold setup', 'Not clinical thresholds');
