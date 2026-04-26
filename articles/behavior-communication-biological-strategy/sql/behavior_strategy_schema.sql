-- Behavior, communication, and biological strategy reproducibility schema.
--
-- This schema tracks behavioral options, signaling strategies, environmental
-- scenarios, conflict parameters, model outputs, and provenance metadata.

DROP TABLE IF EXISTS behavioral_options;
DROP TABLE IF EXISTS signaling_strategies;
DROP TABLE IF EXISTS environmental_scenarios;
DROP TABLE IF EXISTS hawk_dove_parameters;
DROP TABLE IF EXISTS behavior_observations;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE behavioral_options (
    option_id INTEGER PRIMARY KEY,
    option_name TEXT NOT NULL UNIQUE,
    benefit REAL NOT NULL,
    energetic_cost REAL NOT NULL,
    predation_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE signaling_strategies (
    strategy_id INTEGER PRIMARY KEY,
    strategy_name TEXT NOT NULL UNIQUE,
    mate_benefit REAL NOT NULL,
    energetic_cost REAL NOT NULL,
    predator_exposure REAL NOT NULL,
    receiver_detectability REAL NOT NULL,
    notes TEXT
);

CREATE TABLE environmental_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    predation_weight REAL NOT NULL,
    noise_penalty REAL NOT NULL,
    receiver_state REAL NOT NULL,
    notes TEXT
);

CREATE TABLE hawk_dove_parameters (
    parameter_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    resource_value REAL NOT NULL,
    conflict_cost REAL NOT NULL,
    hawk_frequency REAL NOT NULL
);

CREATE TABLE behavior_observations (
    observation_id INTEGER PRIMARY KEY,
    event_date TEXT NOT NULL,
    observer TEXT,
    context TEXT,
    behavior_category TEXT,
    signal_modality TEXT,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    focal_strategy TEXT,
    utility REAL,
    choice_probability REAL,
    receiver_response REAL,
    combined_score REAL,
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

INSERT INTO behavioral_options
(option_name, benefit, energetic_cost, predation_risk, notes)
VALUES
('safe_foraging', 8, 2, 1, 'Synthetic behavioral option'),
('risky_foraging', 14, 5, 6, 'Synthetic behavioral option'),
('territorial_display', 10, 4, 3, 'Synthetic behavioral option'),
('mate_search', 12, 6, 5, 'Synthetic behavioral option');

INSERT INTO signaling_strategies
(strategy_name, mate_benefit, energetic_cost, predator_exposure, receiver_detectability, notes)
VALUES
('quiet_signal', 6, 1, 1, 0.45, 'Synthetic signaling strategy'),
('loud_signal', 12, 5, 7, 0.90, 'Synthetic signaling strategy'),
('multimodal_signal', 10, 4, 4, 0.85, 'Synthetic signaling strategy'),
('cryptic_display', 4, 1, 0.5, 0.30, 'Synthetic signaling strategy');

INSERT INTO environmental_scenarios
(scenario_name, predation_weight, noise_penalty, receiver_state, notes)
VALUES
('baseline', 1.2, 0.00, 0.75, 'Baseline behavioral condition'),
('high_predation', 1.8, 0.00, 0.75, 'Predator pressure increases behavioral cost'),
('noisy_environment', 1.2, 0.20, 0.75, 'Signal detectability is reduced'),
('low_receiver_attention', 1.2, 0.00, 0.55, 'Receiver state lowers response probability'),
('combined_stress', 1.8, 0.20, 0.60, 'Predation pressure and noise increase together');

INSERT INTO hawk_dove_parameters
(scenario_name, resource_value, conflict_cost, hawk_frequency)
VALUES
('low_cost_conflict', 10, 8, 0.50),
('balanced_conflict', 10, 20, 0.50),
('high_cost_conflict', 10, 40, 0.50),
('hawk_dominated', 10, 20, 0.80),
('dove_dominated', 10, 20, 0.20);

INSERT INTO behavior_observations
(event_date, observer, context, behavior_category, signal_modality, notes)
VALUES
('2026-04-01', 'field_team', 'foraging', 'safe_foraging', 'none', 'Synthetic observation'),
('2026-04-01', 'field_team', 'foraging', 'risky_foraging', 'none', 'Synthetic observation'),
('2026-04-02', 'field_team', 'courtship', 'mate_search', 'visual_acoustic', 'Synthetic observation'),
('2026-04-02', 'field_team', 'territoriality', 'territorial_display', 'visual_postural', 'Synthetic observation'),
('2026-04-03', 'field_team', 'communication', 'loud_signal', 'acoustic', 'Synthetic observation');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('behavioral_options.csv', 'synthetic_example', 'constructed_example', 'softmax choice modeling', 'MIT-compatible example data', 'behavioral option utility scoring', 'Not real behavioral data'),
('signaling_strategies.csv', 'synthetic_example', 'constructed_example', 'sender-receiver signaling model', 'MIT-compatible example data', 'communication strategy screening', 'Not real behavioral data'),
('hawk_dove_parameters.csv', 'synthetic_example', 'constructed_example', 'game-theoretic conflict model', 'MIT-compatible example data', 'Hawk-Dove conflict screening', 'Not real behavioral data');
