-- Biological methods reproducibility schema.

DROP TABLE IF EXISTS growth_observations;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS assay_validation;
DROP TABLE IF EXISTS reference_sequences;
DROP TABLE IF EXISTS query_sequences;
DROP TABLE IF EXISTS imaging_features;
DROP TABLE IF EXISTS experimental_signal_scores;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE growth_observations (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    abundance REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE logistic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    initial_abundance REAL NOT NULL,
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE assay_validation (
    assay_id TEXT PRIMARY KEY,
    true_positive INTEGER NOT NULL,
    false_negative INTEGER NOT NULL,
    true_negative INTEGER NOT NULL,
    false_positive INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE reference_sequences (
    strain_id TEXT PRIMARY KEY,
    sequence TEXT NOT NULL,
    marker_name TEXT,
    notes TEXT
);

CREATE TABLE query_sequences (
    query_id TEXT PRIMARY KEY,
    sequence TEXT NOT NULL,
    marker_name TEXT,
    notes TEXT
);

CREATE TABLE imaging_features (
    cell_id TEXT PRIMARY KEY,
    condition_name TEXT NOT NULL,
    area_um2 REAL NOT NULL,
    mean_intensity REAL NOT NULL,
    roundness REAL NOT NULL,
    notes TEXT
);

CREATE TABLE experimental_signal_scores (
    experiment_id TEXT PRIMARY KEY,
    signal_strength REAL NOT NULL,
    reproducibility REAL NOT NULL,
    control_separation REAL NOT NULL,
    noise_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    growth_rate REAL,
    doubling_time REAL,
    sensitivity REAL,
    specificity REAL,
    positive_predictive_value REAL,
    negative_predictive_value REAL,
    accuracy REAL,
    signal_quality_score REAL,
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

INSERT INTO growth_observations
(time_h, abundance, condition_name, notes)
VALUES
(0,100000,'baseline','Synthetic growth observation'),
(2,160000,'baseline','Synthetic growth observation'),
(4,270000,'baseline','Synthetic growth observation'),
(6,430000,'baseline','Synthetic growth observation'),
(8,680000,'baseline','Synthetic growth observation'),
(10,1000000,'baseline','Synthetic growth observation'),
(0,100000,'nutrient_limited','Synthetic growth observation'),
(2,132000,'nutrient_limited','Synthetic growth observation'),
(4,175000,'nutrient_limited','Synthetic growth observation'),
(6,232000,'nutrient_limited','Synthetic growth observation'),
(8,307000,'nutrient_limited','Synthetic growth observation'),
(10,407000,'nutrient_limited','Synthetic growth observation'),
(0,100000,'treatment','Synthetic growth observation'),
(2,118000,'treatment','Synthetic growth observation'),
(4,139000,'treatment','Synthetic growth observation'),
(6,164000,'treatment','Synthetic growth observation'),
(8,194000,'treatment','Synthetic growth observation'),
(10,229000,'treatment','Synthetic growth observation');

INSERT INTO logistic_scenarios
(scenario_id, initial_abundance, growth_rate, carrying_capacity, time_end, dt, notes)
VALUES
('baseline',100000,0.45,2000000,24,0.25,'Synthetic logistic scenario'),
('nutrient_limited',100000,0.25,900000,24,0.25,'Synthetic logistic scenario'),
('treatment',100000,0.12,500000,24,0.25,'Synthetic logistic scenario'),
('high_density',250000,0.30,1200000,24,0.25,'Synthetic logistic scenario');

INSERT INTO assay_validation
(assay_id, true_positive, false_negative, true_negative, false_positive, notes)
VALUES
('biosensor_A',84,16,91,9,'Synthetic assay validation'),
('biosensor_B',76,24,95,5,'Synthetic assay validation'),
('sequence_test_A',92,8,88,12,'Synthetic assay validation'),
('field_test_A',68,32,89,11,'Synthetic assay validation');

INSERT INTO reference_sequences
(strain_id, sequence, marker_name, notes)
VALUES
('strain_A','ATGCTAGCTAAC','toy_marker','Synthetic reference sequence'),
('strain_B','ATGCTAGCTATC','toy_marker','Synthetic reference sequence'),
('strain_C','ATGCCAGCTATC','toy_marker','Synthetic reference sequence'),
('strain_D','TTGCCAGTTATC','toy_marker','Synthetic reference sequence');

INSERT INTO query_sequences
(query_id, sequence, marker_name, notes)
VALUES
('query_001','ATGCTAGCTATC','toy_marker','Synthetic query sequence'),
('query_002','ATGCCAGCTAAC','toy_marker','Synthetic query sequence'),
('query_003','TTGCCAGTTATC','toy_marker','Synthetic query sequence');

INSERT INTO imaging_features
(cell_id, condition_name, area_um2, mean_intensity, roundness, notes)
VALUES
('cell_001','control',820,1450,0.74,'Synthetic imaging feature'),
('cell_002','control',790,1390,0.76,'Synthetic imaging feature'),
('cell_003','treated',640,1180,0.68,'Synthetic imaging feature'),
('cell_004','treated',610,1110,0.66,'Synthetic imaging feature'),
('cell_005','treated',660,1205,0.69,'Synthetic imaging feature'),
('cell_006','hypoxic',700,1225,0.70,'Synthetic imaging feature'),
('cell_007','hypoxic',685,1205,0.69,'Synthetic imaging feature');

INSERT INTO experimental_signal_scores
(experiment_id, signal_strength, reproducibility, control_separation, noise_penalty, notes)
VALUES
('growth_assay_A',0.86,0.82,0.78,0.14,'Synthetic signal score'),
('growth_assay_B',0.70,0.74,0.62,0.28,'Synthetic signal score'),
('biosensor_A',0.84,0.80,0.88,0.18,'Synthetic signal score'),
('field_monitoring_A',0.62,0.58,0.54,0.36,'Synthetic signal score'),
('imaging_assay_A',0.76,0.70,0.72,0.22,'Synthetic signal score');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('growth_observations.csv','synthetic_example','constructed_example','exponential growth fitting','MIT-compatible example data','growth setup','Not real assay data'),
('logistic_scenarios.csv','synthetic_example','constructed_example','logistic growth simulation','MIT-compatible example data','logistic setup','Not real growth data'),
('assay_validation.csv','synthetic_example','constructed_example','sensitivity and specificity calculation','MIT-compatible example data','assay setup','Not real validation data'),
('reference_sequences.csv','synthetic_example','constructed_example','sequence matching','MIT-compatible example data','reference setup','Not real sequence data'),
('query_sequences.csv','synthetic_example','constructed_example','sequence matching','MIT-compatible example data','query setup','Not real sequence data'),
('imaging_features.csv','synthetic_example','constructed_example','imaging feature summary','MIT-compatible example data','imaging setup','Not real microscopy data'),
('experimental_signal_scores.csv','synthetic_example','constructed_example','signal-quality scoring','MIT-compatible example data','signal setup','Not a validated quality model');
