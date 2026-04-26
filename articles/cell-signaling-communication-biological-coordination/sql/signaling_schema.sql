-- Cell signaling reproducibility schema.
--
-- This schema tracks receptor response observations, signaling decay traces,
-- pathway activation summaries, signaling condition sites, model outputs,
-- and provenance.

DROP TABLE IF EXISTS receptor_response_observations;
DROP TABLE IF EXISTS signaling_decay_observations;
DROP TABLE IF EXISTS pathway_activation_observations;
DROP TABLE IF EXISTS signaling_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE receptor_response_observations (
    observation_id INTEGER PRIMARY KEY,
    ligand_concentration REAL NOT NULL,
    observed_response REAL NOT NULL,
    notes TEXT
);

CREATE TABLE signaling_decay_observations (
    observation_id INTEGER PRIMARY KEY,
    time_min REAL NOT NULL,
    signal_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE pathway_activation_observations (
    sample_id TEXT PRIMARY KEY,
    ligand TEXT NOT NULL,
    pathway TEXT NOT NULL,
    activation_score REAL NOT NULL,
    cell_context TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE signaling_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    receptor_detection REAL NOT NULL,
    transduction_integrity REAL NOT NULL,
    second_messenger_capacity REAL NOT NULL,
    feedback_control REAL NOT NULL,
    response_specificity REAL NOT NULL,
    context_integration REAL NOT NULL,
    noise_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    receptor_occupancy REAL,
    hill_response REAL,
    decay_constant REAL,
    half_life_min REAL,
    pathway_peak REAL,
    feedback_peak REAL,
    quorum_threshold_time REAL,
    signaling_condition_score REAL,
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

INSERT INTO receptor_response_observations
(ligand_concentration, observed_response, notes)
VALUES
(0.01,0.004,'Synthetic receptor response observation'),
(0.03,0.009,'Synthetic receptor response observation'),
(0.10,0.031,'Synthetic receptor response observation'),
(0.30,0.095,'Synthetic receptor response observation'),
(1.00,0.333,'Synthetic receptor response observation'),
(2.00,0.548,'Synthetic receptor response observation'),
(3.00,0.671,'Synthetic receptor response observation'),
(5.00,0.802,'Synthetic receptor response observation'),
(10.00,0.910,'Synthetic receptor response observation');

INSERT INTO signaling_decay_observations
(time_min, signal_value, notes)
VALUES
(0,100,'Synthetic signaling decay observation'),
(1,70,'Synthetic signaling decay observation'),
(2,50,'Synthetic signaling decay observation'),
(3,35,'Synthetic signaling decay observation'),
(4,25,'Synthetic signaling decay observation');

INSERT INTO pathway_activation_observations
(sample_id, ligand, pathway, activation_score, cell_context, notes)
VALUES
('sample_1','EGF','MAPK',0.82,'epithelial','Synthetic pathway activation observation'),
('sample_2','EGF','PI3K',0.61,'epithelial','Synthetic pathway activation observation'),
('sample_3','insulin','AKT',0.78,'metabolic','Synthetic pathway activation observation'),
('sample_4','TNF','NFkB',0.86,'immune','Synthetic pathway activation observation'),
('sample_5','calcium_ion','CaMK',0.72,'neuronal','Synthetic pathway activation observation'),
('sample_6','cAMP','PKA',0.69,'endocrine','Synthetic pathway activation observation'),
('sample_7','quorum_signal','biofilm',0.74,'microbial','Synthetic pathway activation observation'),
('sample_8','auxin','growth',0.81,'plant','Synthetic pathway activation observation');

INSERT INTO signaling_condition_sites
(site_name, receptor_detection, transduction_integrity, second_messenger_capacity, feedback_control, response_specificity, context_integration, noise_risk, notes)
VALUES
('reference_cell_state',0.84,0.80,0.78,0.74,0.76,0.72,0.20,'Synthetic signaling condition site'),
('feedback_deficient_state',0.72,0.68,0.70,0.32,0.48,0.52,0.64,'Synthetic signaling condition site'),
('immune_activation_state',0.88,0.82,0.86,0.70,0.80,0.78,0.28,'Synthetic signaling condition site'),
('microbial_quorum_state',0.76,0.70,0.62,0.58,0.66,0.74,0.34,'Synthetic signaling condition site'),
('plant_stress_state',0.80,0.76,0.68,0.64,0.72,0.84,0.30,'Synthetic signaling condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('receptor_response.csv', 'synthetic_example', 'constructed_example', 'receptor occupancy and Hill response calculation', 'MIT-compatible example data', 'receptor response setup', 'Not real receptor assay data'),
('signaling_decay.csv', 'synthetic_example', 'constructed_example', 'exponential decay and half-life estimation', 'MIT-compatible example data', 'signaling decay setup', 'Not real signaling trace data'),
('pathway_activation.csv', 'synthetic_example', 'constructed_example', 'pathway activation summary', 'MIT-compatible example data', 'pathway activation setup', 'Not real pathway activation data'),
('signaling_condition_sites.csv', 'synthetic_example', 'constructed_example', 'signaling condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
