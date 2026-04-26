-- Development, differentiation, and organism formation reproducibility schema.
--
-- This schema tracks developmental growth observations, lineage scenarios,
-- morphogen-gradient observations, state transitions, developmental condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS developmental_growth;
DROP TABLE IF EXISTS lineage_scenarios;
DROP TABLE IF EXISTS morphogen_gradient;
DROP TABLE IF EXISTS state_transition_matrix;
DROP TABLE IF EXISTS developmental_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE developmental_growth (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    cells REAL NOT NULL,
    notes TEXT
);

CREATE TABLE lineage_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    t_end REAL NOT NULL,
    dt REAL NOT NULL,
    progenitor_initial REAL NOT NULL,
    k1 REAL NOT NULL,
    k2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE morphogen_gradient (
    observation_id INTEGER PRIMARY KEY,
    position REAL NOT NULL,
    morphogen REAL NOT NULL,
    fate TEXT,
    notes TEXT
);

CREATE TABLE state_transition_matrix (
    row_id INTEGER PRIMARY KEY,
    state_name TEXT NOT NULL UNIQUE,
    progenitor REAL NOT NULL,
    transitional REAL NOT NULL,
    lineage_A REAL NOT NULL,
    lineage_B REAL NOT NULL,
    notes TEXT
);

CREATE TABLE developmental_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    growth_coherence REAL NOT NULL,
    differentiation_signal REAL NOT NULL,
    patterning_signal REAL NOT NULL,
    morphogenesis_quality REAL NOT NULL,
    environmental_stability REAL NOT NULL,
    perturbation_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    growth_rate REAL,
    doubling_time_h REAL,
    predicted_cells REAL,
    progenitor_value REAL,
    lineage_1_value REAL,
    lineage_2_value REAL,
    morphogen_value REAL,
    fate TEXT,
    developmental_condition_score REAL,
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

INSERT INTO developmental_growth
(time_h, cells, notes)
VALUES
(0, 10000, 'Synthetic developmental growth observation'),
(6, 14000, 'Synthetic developmental growth observation'),
(12, 20000, 'Synthetic developmental growth observation'),
(18, 28000, 'Synthetic developmental growth observation'),
(24, 40000, 'Synthetic developmental growth observation'),
(30, 51000, 'Synthetic developmental growth observation'),
(36, 58000, 'Synthetic developmental growth observation');

INSERT INTO lineage_scenarios
(scenario_name, t_end, dt, progenitor_initial, k1, k2, notes)
VALUES
('balanced_branching', 30, 0.1, 1000, 0.14, 0.09, 'Synthetic lineage branching scenario'),
('lineage1_dominant', 30, 0.1, 1000, 0.20, 0.05, 'Synthetic lineage branching scenario'),
('lineage2_dominant', 30, 0.1, 1000, 0.07, 0.17, 'Synthetic lineage branching scenario'),
('slow_commitment', 30, 0.1, 1000, 0.06, 0.04, 'Synthetic lineage branching scenario');

INSERT INTO morphogen_gradient
(position, morphogen, fate, notes)
VALUES
(0.00, 1.0000, 'fate_A', 'Synthetic morphogen observation'),
(0.05, 0.7788, 'fate_A', 'Synthetic morphogen observation'),
(0.10, 0.6065, 'fate_A', 'Synthetic morphogen observation'),
(0.15, 0.4724, 'fate_B', 'Synthetic morphogen observation'),
(0.20, 0.3679, 'fate_B', 'Synthetic morphogen observation'),
(0.25, 0.2865, 'fate_B', 'Synthetic morphogen observation'),
(0.30, 0.2231, 'fate_C', 'Synthetic morphogen observation'),
(0.35, 0.1738, 'fate_C', 'Synthetic morphogen observation'),
(0.40, 0.1353, 'fate_C', 'Synthetic morphogen observation'),
(0.45, 0.1054, 'fate_C', 'Synthetic morphogen observation'),
(0.50, 0.0821, 'fate_C', 'Synthetic morphogen observation'),
(0.55, 0.0639, 'fate_C', 'Synthetic morphogen observation'),
(0.60, 0.0498, 'fate_C', 'Synthetic morphogen observation'),
(0.65, 0.0388, 'fate_C', 'Synthetic morphogen observation'),
(0.70, 0.0302, 'fate_C', 'Synthetic morphogen observation'),
(0.75, 0.0235, 'fate_C', 'Synthetic morphogen observation'),
(0.80, 0.0183, 'fate_C', 'Synthetic morphogen observation'),
(0.85, 0.0143, 'fate_C', 'Synthetic morphogen observation'),
(0.90, 0.0111, 'fate_C', 'Synthetic morphogen observation'),
(0.95, 0.0087, 'fate_C', 'Synthetic morphogen observation'),
(1.00, 0.0067, 'fate_C', 'Synthetic morphogen observation');

INSERT INTO state_transition_matrix
(state_name, progenitor, transitional, lineage_A, lineage_B, notes)
VALUES
('progenitor', 0.76, 0.20, 0.03, 0.01, 'Synthetic state transition row'),
('transitional', 0.04, 0.72, 0.16, 0.08, 'Synthetic state transition row'),
('lineage_A', 0.00, 0.03, 0.94, 0.03, 'Synthetic state transition row'),
('lineage_B', 0.00, 0.02, 0.04, 0.94, 'Synthetic state transition row');

INSERT INTO developmental_condition_sites
(site_name, growth_coherence, differentiation_signal, patterning_signal, morphogenesis_quality, environmental_stability, perturbation_risk, notes)
VALUES
('reference_embryoid_system', 0.74, 0.78, 0.72, 0.70, 0.68, 0.20, 'Synthetic developmental condition site'),
('stressed_larval_system', 0.42, 0.55, 0.48, 0.44, 0.30, 0.72, 'Synthetic developmental condition site'),
('restoration_seedling_stage', 0.61, 0.58, 0.52, 0.50, 0.46, 0.38, 'Synthetic developmental condition site'),
('organoid_screening_model', 0.68, 0.82, 0.63, 0.59, 0.74, 0.31, 'Synthetic developmental condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('developmental_growth.csv', 'synthetic_example', 'constructed_example', 'exponential and logistic growth modeling', 'MIT-compatible example data', 'developmental growth setup', 'Not real developmental growth data'),
('lineage_scenarios.csv', 'synthetic_example', 'constructed_example', 'branching lineage dynamics', 'MIT-compatible example data', 'lineage scenario setup', 'Not real lineage-tracing data'),
('morphogen_gradient.csv', 'synthetic_example', 'constructed_example', 'threshold-based fate assignment', 'MIT-compatible example data', 'morphogen gradient setup', 'Not real morphogen data'),
('state_transition_matrix.csv', 'synthetic_example', 'constructed_example', 'Markov-style developmental state transitions', 'MIT-compatible example data', 'state transition setup', 'Not real single-cell data');
