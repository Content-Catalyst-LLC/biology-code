-- Neurobiology and living response reproducibility schema.
--
-- This schema tracks neural units, input pulses, network weights, response
-- scenarios, model outputs, and provenance metadata.

DROP TABLE IF EXISTS neural_units;
DROP TABLE IF EXISTS input_pulses;
DROP TABLE IF EXISTS network_weights;
DROP TABLE IF EXISTS neural_condition_scenarios;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE neural_units (
    unit_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL UNIQUE,
    unit_type TEXT,
    functional_role TEXT,
    notes TEXT
);

CREATE TABLE input_pulses (
    pulse_id INTEGER PRIMARY KEY,
    start_time REAL NOT NULL,
    end_time REAL NOT NULL,
    input_amplitude REAL NOT NULL,
    description TEXT
);

CREATE TABLE network_weights (
    weight_id INTEGER PRIMARY KEY,
    source_unit TEXT NOT NULL,
    target_unit TEXT NOT NULL,
    weight_value REAL NOT NULL,
    interaction_type TEXT,
    notes TEXT
);

CREATE TABLE neural_condition_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    recovery_rate REAL NOT NULL,
    input_gain REAL NOT NULL,
    noise_pressure REAL NOT NULL,
    stress_load REAL NOT NULL,
    connectivity_integrity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    max_voltage REAL,
    event_count INTEGER,
    final_state REAL,
    neural_condition_score REAL,
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

INSERT INTO neural_units
(unit_code, unit_type, functional_role, notes)
VALUES
('unit_1', 'synthetic_neural_unit', 'sensory_response_proxy', 'Synthetic unit for demonstration'),
('unit_2', 'synthetic_neural_unit', 'integration_proxy', 'Synthetic unit for demonstration'),
('unit_3', 'synthetic_neural_unit', 'motor_or_output_proxy', 'Synthetic unit for demonstration');

INSERT INTO input_pulses
(start_time, end_time, input_amplitude, description)
VALUES
(5, 8, 8, 'first sensory-like input pulse'),
(15, 17, 5, 'second weaker input pulse'),
(28, 31, 10, 'third stronger input pulse');

INSERT INTO network_weights
(source_unit, target_unit, weight_value, interaction_type, notes)
VALUES
('unit_2', 'unit_1', 0.8, 'excitatory_proxy', 'Synthetic recurrent weight'),
('unit_3', 'unit_1', -0.4, 'inhibitory_proxy', 'Synthetic recurrent weight'),
('unit_1', 'unit_2', 0.6, 'excitatory_proxy', 'Synthetic recurrent weight'),
('unit_3', 'unit_2', 0.5, 'excitatory_proxy', 'Synthetic recurrent weight'),
('unit_1', 'unit_3', -0.3, 'inhibitory_proxy', 'Synthetic recurrent weight'),
('unit_2', 'unit_3', 0.7, 'excitatory_proxy', 'Synthetic recurrent weight');

INSERT INTO neural_condition_scenarios
(scenario_name, recovery_rate, input_gain, noise_pressure, stress_load, connectivity_integrity, notes)
VALUES
('baseline', 0.30, 1.00, 0.10, 0.20, 0.90, 'Baseline synthetic neural condition'),
('high_noise', 0.28, 0.90, 0.45, 0.25, 0.82, 'Higher noise and reduced input gain'),
('thermal_stress', 0.24, 0.85, 0.20, 0.55, 0.78, 'Thermal or metabolic stress scenario'),
('toxic_exposure', 0.20, 0.70, 0.30, 0.50, 0.62, 'Toxic exposure scenario'),
('restoration_recovery', 0.34, 1.05, 0.08, 0.15, 0.95, 'Improved recovery and connectivity');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('input_pulses.csv', 'synthetic_example', 'constructed_example', 'leaky integrator simulation', 'MIT-compatible example data', 'input pulse setup', 'Not real neural recording data'),
('network_weights.csv', 'synthetic_example', 'constructed_example', 'recurrent network simulation', 'MIT-compatible example data', 'small recurrent network setup', 'Not real neural recording data'),
('neural_condition_scenarios.csv', 'synthetic_example', 'constructed_example', 'neural condition screening', 'MIT-compatible example data', 'scenario scoring setup', 'Not real neural data');
