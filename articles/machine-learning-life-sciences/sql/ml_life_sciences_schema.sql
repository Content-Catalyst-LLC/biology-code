DROP TABLE IF EXISTS biological_samples;
DROP TABLE IF EXISTS biomarker_features;
DROP TABLE IF EXISTS model_runs;
DROP TABLE IF EXISTS model_metrics;
DROP TABLE IF EXISTS data_provenance;

CREATE TABLE biological_samples (
    sample_id TEXT PRIMARY KEY,
    organism TEXT NOT NULL,
    tissue_or_environment TEXT NOT NULL,
    condition TEXT NOT NULL,
    batch_id TEXT NOT NULL,
    collection_site TEXT NOT NULL
);

CREATE TABLE biomarker_features (
    sample_id TEXT PRIMARY KEY,
    immune_score REAL NOT NULL,
    metabolic_score REAL NOT NULL,
    morphology_score REAL NOT NULL,
    stress_response_score REAL NOT NULL,
    sequencing_depth INTEGER NOT NULL,
    FOREIGN KEY (sample_id) REFERENCES biological_samples(sample_id)
);

CREATE TABLE model_runs (
    run_id TEXT PRIMARY KEY,
    model_name TEXT NOT NULL,
    script TEXT NOT NULL,
    random_seed INTEGER NOT NULL,
    intended_use TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE model_metrics (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    run_id TEXT NOT NULL,
    metric_name TEXT NOT NULL,
    metric_value REAL NOT NULL,
    evaluation_split TEXT NOT NULL,
    FOREIGN KEY (run_id) REFERENCES model_runs(run_id)
);

CREATE TABLE data_provenance (
    artifact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    artifact_name TEXT NOT NULL,
    artifact_type TEXT NOT NULL,
    source_description TEXT NOT NULL,
    checksum_sha256 TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO biological_samples VALUES
('S001','human','blood','case','B1','clinic_a'),
('S002','human','blood','case','B1','clinic_a'),
('S003','human','tissue','case','B2','clinic_b'),
('S004','human','tissue','case','B2','clinic_b'),
('S005','human','blood','control','B1','clinic_a'),
('S006','human','blood','control','B1','clinic_a'),
('S007','human','tissue','control','B2','clinic_b'),
('S008','human','tissue','control','B2','clinic_b'),
('S009','human','blood','case','B3','clinic_c'),
('S010','human','tissue','case','B3','clinic_c'),
('S011','human','blood','control','B3','clinic_c'),
('S012','human','tissue','control','B3','clinic_c');

INSERT INTO biomarker_features VALUES
('S001',0.81,0.20,0.78,0.73,42000000),
('S002',0.77,0.25,0.74,0.70,40500000),
('S003',0.66,0.34,0.62,0.61,39000000),
('S004',0.59,0.39,0.57,0.58,38000000),
('S005',0.45,0.55,0.49,0.44,41000000),
('S006',0.41,0.61,0.44,0.40,40000000),
('S007',0.28,0.70,0.31,0.34,39500000),
('S008',0.25,0.73,0.29,0.31,38500000),
('S009',0.73,0.28,0.71,0.68,43000000),
('S010',0.69,0.32,0.67,0.65,41500000),
('S011',0.36,0.66,0.37,0.39,39700000),
('S012',0.31,0.69,0.34,0.35,39200000);

INSERT INTO model_runs VALUES
('MLLS001','random_forest_biomarker_classifier','python/01_train_biomarker_classifier.py',42,'educational synthetic biomarker classification',CURRENT_TIMESTAMP);

INSERT INTO data_provenance (artifact_name, artifact_type, source_description, checksum_sha256) VALUES
('biological_samples.csv','synthetic_data','Synthetic educational sample metadata for article workflow',NULL),
('biomarker_features.csv','synthetic_data','Synthetic educational biomarker feature table for article workflow',NULL),
('external_validation_samples.csv','synthetic_data','Synthetic educational external validation table',NULL);
