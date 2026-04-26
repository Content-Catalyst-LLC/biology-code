-- Coevolution and symbiosis reproducibility schema.
--
-- This schema tracks benefit-cost scenarios, reciprocal frequency scenarios,
-- host-pathogen scenarios, mutualistic network interactions, condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS benefit_cost_scenarios;
DROP TABLE IF EXISTS reciprocal_frequency_scenarios;
DROP TABLE IF EXISTS host_pathogen_scenarios;
DROP TABLE IF EXISTS network_interactions;
DROP TABLE IF EXISTS symbiosis_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE benefit_cost_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    stress REAL NOT NULL,
    baseline REAL NOT NULL,
    benefit_intercept REAL NOT NULL,
    benefit_stress_slope REAL NOT NULL,
    cost_intercept REAL NOT NULL,
    cost_stress_slope REAL NOT NULL,
    symbiont_load REAL NOT NULL,
    notes TEXT
);

CREATE TABLE reciprocal_frequency_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    host_initial REAL NOT NULL,
    symbiont_initial REAL NOT NULL,
    host_feedback REAL NOT NULL,
    symbiont_feedback REAL NOT NULL,
    steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE host_pathogen_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    host_defense REAL NOT NULL,
    pathogen_escape REAL NOT NULL,
    feedback REAL NOT NULL,
    steps INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE network_interactions (
    interaction_id INTEGER PRIMARY KEY,
    focal TEXT NOT NULL,
    partner TEXT NOT NULL,
    interaction_weight REAL NOT NULL,
    partner_reliability REAL NOT NULL,
    interaction_type TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE symbiosis_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    partner_presence REAL NOT NULL,
    interaction_stability REAL NOT NULL,
    environmental_stress REAL NOT NULL,
    cheating_pressure REAL NOT NULL,
    transmission_reliability REAL NOT NULL,
    functional_redundancy REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    net_effect REAL,
    host_net_performance REAL,
    relationship_state TEXT,
    final_host_match REAL,
    final_symbiont_match REAL,
    final_mismatch REAL,
    infection_pressure REAL,
    dependency_support REAL,
    condition_score REAL,
    risk_or_condition_class TEXT,
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

INSERT INTO benefit_cost_scenarios
(scenario_name, stress, baseline, benefit_intercept, benefit_stress_slope, cost_intercept, cost_stress_slope, symbiont_load, notes)
VALUES
('low_stress_mutualism', 0.10, 1.0, 0.8, 0.3, 0.2, 0.4, 0.75, 'Synthetic low stress scenario'),
('moderate_stress_threshold', 0.55, 1.0, 0.8, 0.3, 0.2, 0.4, 0.75, 'Synthetic threshold scenario'),
('high_stress_breakdown', 0.90, 1.0, 0.8, 0.3, 0.2, 0.4, 0.75, 'Synthetic breakdown scenario'),
('low_partner_load', 0.40, 1.0, 0.8, 0.3, 0.2, 0.4, 0.25, 'Synthetic low partner load scenario');

INSERT INTO reciprocal_frequency_scenarios
(scenario_name, host_initial, symbiont_initial, host_feedback, symbiont_feedback, steps, notes)
VALUES
('weak_feedback', 0.40, 0.50, 0.04, 0.05, 40, 'Synthetic weak feedback'),
('moderate_feedback', 0.40, 0.50, 0.08, 0.10, 40, 'Synthetic moderate feedback'),
('host_lag', 0.30, 0.65, 0.03, 0.10, 40, 'Synthetic host lag'),
('symbiont_lag', 0.65, 0.30, 0.10, 0.03, 40, 'Synthetic symbiont lag');

INSERT INTO host_pathogen_scenarios
(scenario_name, host_defense, pathogen_escape, feedback, steps, notes)
VALUES
('reference', 0.40, 0.50, 0.03, 60, 'Synthetic reference arms-race scenario'),
('high_escape', 0.35, 0.70, 0.04, 60, 'Synthetic high pathogen escape scenario'),
('strong_defense', 0.70, 0.45, 0.03, 60, 'Synthetic strong host defense scenario'),
('weak_feedback', 0.40, 0.50, 0.01, 60, 'Synthetic weak feedback scenario');

INSERT INTO network_interactions
(focal, partner, interaction_weight, partner_reliability, interaction_type, notes)
VALUES
('plant_a', 'pollinator_1', 0.50, 0.80, 'pollination', 'Synthetic interaction'),
('plant_a', 'pollinator_2', 0.30, 0.45, 'pollination', 'Synthetic interaction'),
('plant_a', 'pollinator_3', 0.20, 0.70, 'pollination', 'Synthetic interaction'),
('plant_b', 'pollinator_1', 0.20, 0.80, 'pollination', 'Synthetic interaction'),
('plant_b', 'pollinator_4', 0.80, 0.30, 'pollination', 'Synthetic interaction'),
('coral_a', 'symbiont_1', 0.70, 0.62, 'marine_symbiosis', 'Synthetic interaction'),
('coral_a', 'symbiont_2', 0.30, 0.40, 'marine_symbiosis', 'Synthetic interaction'),
('root_a', 'mycorrhiza_1', 0.60, 0.76, 'mycorrhizal_exchange', 'Synthetic interaction'),
('root_a', 'mycorrhiza_2', 0.40, 0.52, 'mycorrhizal_exchange', 'Synthetic interaction');

INSERT INTO symbiosis_condition_sites
(site_name, partner_presence, interaction_stability, environmental_stress, cheating_pressure, transmission_reliability, functional_redundancy, notes)
VALUES
('reference_reef', 0.88, 0.78, 0.20, 0.12, 0.82, 0.66, 'Synthetic condition site'),
('warming_stressed_reef', 0.62, 0.45, 0.74, 0.18, 0.56, 0.38, 'Synthetic condition site'),
('restored_prairie', 0.70, 0.63, 0.35, 0.20, 0.68, 0.55, 'Synthetic condition site'),
('degraded_soil_site', 0.41, 0.34, 0.62, 0.31, 0.42, 0.29, 'Synthetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('benefit_cost_scenarios.csv', 'synthetic_example', 'constructed_example', 'benefit-cost threshold screening', 'MIT-compatible example data', 'symbiosis outcome setup', 'Not real symbiosis data'),
('reciprocal_frequency_scenarios.csv', 'synthetic_example', 'constructed_example', 'reciprocal frequency dynamics', 'MIT-compatible example data', 'frequency feedback setup', 'Not real trait-frequency data'),
('host_pathogen_scenarios.csv', 'synthetic_example', 'constructed_example', 'host-pathogen arms-race simulation', 'MIT-compatible example data', 'disease coevolution setup', 'Not real disease data'),
('network_interactions.csv', 'synthetic_example', 'constructed_example', 'network dependency scoring', 'MIT-compatible example data', 'interaction network setup', 'Not real network data');
