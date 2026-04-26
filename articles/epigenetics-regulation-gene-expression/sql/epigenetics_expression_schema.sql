-- Epigenetics, regulation, and gene expression reproducibility schema.
--
-- This schema tracks expression time courses, methylation observations,
-- expression/accessibility comparisons, regulatory switching scenarios,
-- cell-state transition records, epigenetic condition sites, model outputs,
-- and provenance.

DROP TABLE IF EXISTS expression_timecourse;
DROP TABLE IF EXISTS methylation_counts;
DROP TABLE IF EXISTS expression_accessibility;
DROP TABLE IF EXISTS regulatory_scenarios;
DROP TABLE IF EXISTS cell_state_transition_matrix;
DROP TABLE IF EXISTS epigenetic_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE expression_timecourse (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    expression_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE methylation_counts (
    locus_id INTEGER PRIMARY KEY,
    locus_name TEXT NOT NULL UNIQUE,
    methylated_count INTEGER NOT NULL,
    unmethylated_count INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE expression_accessibility (
    gene_id INTEGER PRIMARY KEY,
    gene_name TEXT NOT NULL UNIQUE,
    control_expr REAL NOT NULL,
    treated_expr REAL NOT NULL,
    control_access REAL NOT NULL,
    treated_access REAL NOT NULL,
    notes TEXT
);

CREATE TABLE regulatory_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    kon REAL NOT NULL,
    koff REAL NOT NULL,
    alpha_on REAL NOT NULL,
    alpha_off REAL NOT NULL,
    beta REAL NOT NULL,
    p_on_initial REAL NOT NULL,
    expression_initial REAL NOT NULL,
    t_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE cell_state_transition_matrix (
    row_id INTEGER PRIMARY KEY,
    state_name TEXT NOT NULL UNIQUE,
    stem_like REAL NOT NULL,
    primed REAL NOT NULL,
    differentiated REAL NOT NULL,
    notes TEXT
);

CREATE TABLE epigenetic_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    expression_stability REAL NOT NULL,
    accessibility_signal REAL NOT NULL,
    methylation_quality REAL NOT NULL,
    state_memory REAL NOT NULL,
    environmental_responsiveness REAL NOT NULL,
    batch_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    decay_constant REAL,
    half_life_h REAL,
    area_under_curve REAL,
    methylation_fraction REAL,
    log2fc_expr REAL,
    delta_access REAL,
    p_on REAL,
    expression_value REAL,
    epigenetic_condition_score REAL,
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

INSERT INTO expression_timecourse
(time_h, expression_value, notes)
VALUES
(0, 120, 'Synthetic expression observation'),
(1, 98, 'Synthetic expression observation'),
(2, 76, 'Synthetic expression observation'),
(4, 49, 'Synthetic expression observation'),
(6, 31, 'Synthetic expression observation'),
(8, 20, 'Synthetic expression observation');

INSERT INTO methylation_counts
(locus_name, methylated_count, unmethylated_count, notes)
VALUES
('locus_1', 85, 15, 'Synthetic methylation observation'),
('locus_2', 20, 80, 'Synthetic methylation observation'),
('locus_3', 61, 39, 'Synthetic methylation observation'),
('locus_4', 42, 58, 'Synthetic methylation observation'),
('locus_5', 95, 5, 'Synthetic methylation observation'),
('locus_6', 14, 86, 'Synthetic methylation observation'),
('locus_7', 50, 50, 'Synthetic methylation observation'),
('locus_8', 73, 27, 'Synthetic methylation observation');

INSERT INTO expression_accessibility
(gene_name, control_expr, treated_expr, control_access, treated_access, notes)
VALUES
('GATA3', 12.0, 25.0, 0.32, 0.56, 'Synthetic paired expression/accessibility observation'),
('HSP70', 18.0, 60.0, 0.41, 0.73, 'Synthetic paired expression/accessibility observation'),
('DNMT1', 22.0, 17.0, 0.55, 0.46, 'Synthetic paired expression/accessibility observation'),
('MYC', 45.0, 30.0, 0.71, 0.49, 'Synthetic paired expression/accessibility observation'),
('COL1A1', 31.0, 20.0, 0.48, 0.33, 'Synthetic paired expression/accessibility observation'),
('NRF2', 14.0, 29.0, 0.36, 0.61, 'Synthetic paired expression/accessibility observation');

INSERT INTO regulatory_scenarios
(scenario_name, kon, koff, alpha_on, alpha_off, beta, p_on_initial, expression_initial, t_end, dt, notes)
VALUES
('baseline_activation', 0.28, 0.10, 14.0, 1.0, 0.35, 0.05, 2.0, 30, 0.05, 'Synthetic regulatory scenario'),
('stable_activation', 0.40, 0.05, 12.0, 1.0, 0.25, 0.10, 2.0, 30, 0.05, 'Synthetic regulatory scenario'),
('transient_low_activation', 0.14, 0.20, 10.0, 1.0, 0.40, 0.05, 2.0, 30, 0.05, 'Synthetic regulatory scenario');

INSERT INTO cell_state_transition_matrix
(state_name, stem_like, primed, differentiated, notes)
VALUES
('stem_like', 0.78, 0.20, 0.02, 'Synthetic transition row'),
('primed', 0.05, 0.80, 0.15, 'Synthetic transition row'),
('differentiated', 0.00, 0.08, 0.92, 'Synthetic transition row');

INSERT INTO epigenetic_condition_sites
(site_name, expression_stability, accessibility_signal, methylation_quality, state_memory, environmental_responsiveness, batch_risk, notes)
VALUES
('reference_cell_system', 0.72, 0.76, 0.70, 0.74, 0.62, 0.20, 'Synthetic epigenetic condition site'),
('stressed_plant_tissue', 0.58, 0.68, 0.61, 0.52, 0.86, 0.28, 'Synthetic epigenetic condition site'),
('tumor_like_dysregulation', 0.31, 0.82, 0.77, 0.34, 0.66, 0.36, 'Synthetic epigenetic condition site'),
('microbial_stress_response', 0.49, 0.43, 0.22, 0.41, 0.88, 0.32, 'Synthetic epigenetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('expression_timecourse.csv', 'synthetic_example', 'constructed_example', 'exponential decay fitting and AUC', 'MIT-compatible example data', 'expression kinetics setup', 'Not real transcriptomic data'),
('methylation_counts.csv', 'synthetic_example', 'constructed_example', 'methylation fraction calculation', 'MIT-compatible example data', 'methylation summary setup', 'Not real methylation data'),
('expression_accessibility.csv', 'synthetic_example', 'constructed_example', 'expression/accessibility concordance screening', 'MIT-compatible example data', 'regulatory integration setup', 'Not real epigenomic data'),
('regulatory_scenarios.csv', 'synthetic_example', 'constructed_example', 'two-state regulatory switching', 'MIT-compatible example data', 'regulatory dynamics setup', 'Not real regulatory-state data');
