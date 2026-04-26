-- Physiology and regulation of living systems reproducibility schema.
--
-- This schema tracks physiological variables, feedback scenarios, regulatory
-- thresholds, condition scenarios, model outputs, and provenance metadata.

DROP TABLE IF EXISTS physiological_variables;
DROP TABLE IF EXISTS feedback_scenarios;
DROP TABLE IF EXISTS physiological_condition_scenarios;
DROP TABLE IF EXISTS regulatory_thresholds;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE physiological_variables (
    variable_id INTEGER PRIMARY KEY,
    variable_name TEXT NOT NULL UNIQUE,
    description TEXT,
    example_measure TEXT
);

CREATE TABLE feedback_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_regulated_variable REAL NOT NULL,
    target_value REAL NOT NULL,
    input_rate REAL NOT NULL,
    sensing_strength REAL NOT NULL,
    signal_decay REAL NOT NULL,
    effector_activation REAL NOT NULL,
    effector_decay REAL NOT NULL,
    baseline_uptake REAL NOT NULL,
    signal_dependent_uptake REAL NOT NULL,
    notes TEXT
);

CREATE TABLE physiological_condition_scenarios (
    condition_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    feedback_capacity REAL NOT NULL,
    effector_capacity REAL NOT NULL,
    signal_integrity REAL NOT NULL,
    stress_load REAL NOT NULL,
    environmental_pressure REAL NOT NULL,
    recovery_support REAL NOT NULL,
    notes TEXT
);

CREATE TABLE regulatory_thresholds (
    threshold_id INTEGER PRIMARY KEY,
    threshold_name TEXT NOT NULL UNIQUE,
    value REAL NOT NULL,
    description TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    peak_regulated_variable REAL,
    peak_hormonal_signal REAL,
    peak_effector_response REAL,
    final_regulated_variable REAL,
    recovery_error REAL,
    regulatory_class TEXT,
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

INSERT INTO physiological_variables
(variable_name, description, example_measure)
VALUES
('regulated_variable', 'internal quantity under control', 'glucose osmotic state temperature or pH proxy'),
('hormonal_signal', 'signaling intermediate that responds to deviation', 'hormone or regulatory signal proxy'),
('effector_response', 'downstream corrective process', 'uptake secretion heat loss or transport proxy'),
('stress_load', 'systemic physiological burden', 'thermal dehydration hypoxia or toxic stress proxy'),
('recovery_error', 'distance from regulated target', 'absolute difference from target state');

INSERT INTO feedback_scenarios
(scenario_name, initial_regulated_variable, target_value, input_rate, sensing_strength, signal_decay, effector_activation, effector_decay, baseline_uptake, signal_dependent_uptake, notes)
VALUES
('weak_feedback', 10, 5, 0.6, 0.5, 0.5, 0.7, 0.4, 0.3, 0.15, 'Weak feedback and weak uptake response'),
('moderate_feedback', 10, 5, 0.6, 0.9, 0.5, 0.7, 0.4, 0.3, 0.25, 'Moderate feedback synthetic baseline'),
('strong_feedback', 10, 5, 0.6, 1.3, 0.6, 0.8, 0.4, 0.3, 0.35, 'Stronger correction and effector response'),
('stress_high_input', 10, 5, 0.9, 0.9, 0.5, 0.7, 0.4, 0.3, 0.25, 'Higher input load under stress'),
('weak_effector', 10, 5, 0.6, 0.9, 0.5, 0.7, 0.4, 0.3, 0.12, 'Impaired signal-dependent uptake');

INSERT INTO physiological_condition_scenarios
(scenario_name, feedback_capacity, effector_capacity, signal_integrity, stress_load, environmental_pressure, recovery_support, notes)
VALUES
('baseline', 0.76, 0.74, 0.78, 0.25, 0.25, 0.72, 'Baseline physiological condition'),
('high_heat_stress', 0.70, 0.68, 0.72, 0.55, 0.60, 0.60, 'Heat stress and environmental pressure'),
('dehydration_pressure', 0.66, 0.62, 0.70, 0.50, 0.58, 0.55, 'Water balance stress scenario'),
('weak_effector_capacity', 0.72, 0.45, 0.74, 0.35, 0.40, 0.58, 'Reduced effector capacity'),
('recovery_supported', 0.82, 0.80, 0.84, 0.20, 0.18, 0.82, 'Improved recovery support and signal integrity');

INSERT INTO regulatory_thresholds
(threshold_name, value, description)
VALUES
('recovery_error_well_regulated', 0.5, 'illustrative recovery error threshold for good regulation'),
('recovery_error_strained', 1.5, 'illustrative recovery error threshold for strained regulation'),
('condition_score_buffered', 0.60, 'illustrative condition score for relatively buffered regulation'),
('condition_score_stressed', 0.42, 'illustrative condition score for stressed regulation');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('feedback_scenarios.csv', 'synthetic_example', 'constructed_example', 'coupled physiological feedback model', 'MIT-compatible example data', 'scenario setup for regulatory dynamics', 'Not real physiological data'),
('physiological_condition_scenarios.csv', 'synthetic_example', 'constructed_example', 'physiological condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not real physiological data'),
('regulatory_thresholds.csv', 'synthetic_example', 'constructed_example', 'threshold classification', 'MIT-compatible example data', 'illustrative threshold setup', 'Not clinical thresholds');
