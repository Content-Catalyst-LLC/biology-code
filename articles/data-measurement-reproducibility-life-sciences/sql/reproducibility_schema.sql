-- Data, measurement, and reproducibility in life sciences schema.

DROP TABLE IF EXISTS samples;
DROP TABLE IF EXISTS measurements;
DROP TABLE IF EXISTS data_dictionary;
DROP TABLE IF EXISTS uncertainty_components;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_steps;
DROP TABLE IF EXISTS quality_control_rules;
DROP TABLE IF EXISTS workflow_runs;

CREATE TABLE samples (
    sample_id TEXT PRIMARY KEY,
    organism TEXT NOT NULL,
    tissue TEXT,
    collection_context TEXT,
    notes TEXT
);

CREATE TABLE measurements (
    measurement_id INTEGER PRIMARY KEY,
    sample_id TEXT NOT NULL,
    measurement_value REAL,
    unit TEXT NOT NULL,
    instrument_id TEXT NOT NULL,
    batch_id TEXT NOT NULL,
    qc_flag TEXT NOT NULL CHECK (qc_flag IN ('pass', 'review', 'fail')),
    measured_at TEXT,
    notes TEXT
);

CREATE TABLE data_dictionary (
    column_name TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    unit TEXT,
    required INTEGER NOT NULL,
    allowed_values TEXT
);

CREATE TABLE uncertainty_components (
    component_id INTEGER PRIMARY KEY,
    component_name TEXT NOT NULL,
    standard_uncertainty REAL NOT NULL CHECK (standard_uncertainty >= 0),
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE artifacts (
    artifact_id INTEGER PRIMARY KEY,
    artifact_name TEXT NOT NULL,
    artifact_role TEXT NOT NULL,
    owner TEXT,
    status TEXT,
    license TEXT,
    sha256 TEXT,
    notes TEXT
);

CREATE TABLE provenance_steps (
    step_id INTEGER PRIMARY KEY,
    input_artifact TEXT NOT NULL,
    operation TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    responsible_role TEXT,
    notes TEXT
);

CREATE TABLE quality_control_rules (
    rule_id INTEGER PRIMARY KEY,
    rule_name TEXT NOT NULL,
    field_name TEXT NOT NULL,
    rule_description TEXT NOT NULL,
    severity TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE workflow_runs (
    run_id INTEGER PRIMARY KEY,
    workflow_name TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    software_environment TEXT,
    run_status TEXT NOT NULL,
    run_timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);

INSERT INTO samples
(sample_id, organism, tissue, collection_context, notes)
VALUES
('sample_01','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_02','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_03','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_04','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_05','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_06','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_07','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_08','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_09','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_10','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_11','model_species','liver','synthetic laboratory example','Synthetic sample'),
('sample_12','model_species','liver','synthetic laboratory example','Synthetic sample');

INSERT INTO measurements
(sample_id, measurement_value, unit, instrument_id, batch_id, qc_flag, notes)
VALUES
('sample_01',10.2,'mmol/L','instrument_A','batch_01','pass','Synthetic measurement'),
('sample_02',10.5,'mmol/L','instrument_A','batch_01','pass','Synthetic measurement'),
('sample_03',10.1,'mmol/L','instrument_A','batch_01','pass','Synthetic measurement'),
('sample_04',10.4,'mmol/L','instrument_A','batch_01','pass','Synthetic measurement'),
('sample_05',10.8,'mmol/L','instrument_A','batch_02','pass','Synthetic measurement'),
('sample_06',11.0,'mmol/L','instrument_A','batch_02','review','Synthetic measurement'),
('sample_07',10.7,'mmol/L','instrument_A','batch_02','pass','Synthetic measurement'),
('sample_08',10.6,'mmol/L','instrument_A','batch_02','pass','Synthetic measurement'),
('sample_09',10.3,'mmol/L','instrument_B','batch_03','pass','Synthetic measurement'),
('sample_10',NULL,'mmol/L','instrument_B','batch_03','fail','Synthetic missing measurement'),
('sample_11',10.9,'mmol/L','instrument_B','batch_03','pass','Synthetic measurement'),
('sample_12',10.4,'mmol/L','instrument_B','batch_03','pass','Synthetic measurement');

INSERT INTO data_dictionary
(column_name, description, unit, required, allowed_values)
VALUES
('sample_id','Unique sample identifier',NULL,1,NULL),
('organism','Organism or biological source',NULL,1,NULL),
('tissue','Tissue or biological material',NULL,1,NULL),
('measurement_value','Measured biological quantity','mmol/L',1,NULL),
('unit','Measurement unit',NULL,1,'mmol/L'),
('instrument_id','Instrument identifier',NULL,1,NULL),
('batch_id','Analytical batch identifier',NULL,1,NULL),
('qc_flag','Quality-control status',NULL,1,'pass|review|fail');

INSERT INTO uncertainty_components
(component_name, standard_uncertainty, unit, notes)
VALUES
('instrument_repeatability',0.08,'mmol/L','Synthetic repeatability component'),
('calibration',0.05,'mmol/L','Synthetic calibration component'),
('sample_preparation',0.11,'mmol/L','Synthetic preparation component'),
('operator_variation',0.06,'mmol/L','Synthetic operator component');

INSERT INTO artifacts
(artifact_name, artifact_role, owner, status, license, sha256, notes)
VALUES
('measurements.csv','input','lab_team','archived','CC-BY-4.0-compatible-example',NULL,'Synthetic measurement table'),
('data_dictionary.csv','metadata','analysis_team','versioned','CC-BY-4.0-compatible-example',NULL,'Synthetic data dictionary'),
('uncertainty_components.csv','input','analysis_team','versioned','CC-BY-4.0-compatible-example',NULL,'Synthetic uncertainty budget input'),
('provenance_steps.csv','provenance','analysis_team','versioned','CC-BY-4.0-compatible-example',NULL,'Synthetic workflow provenance'),
('summary_table.csv','output','analysis_team','generated','CC-BY-4.0-compatible-example',NULL,'Derived output');

INSERT INTO provenance_steps
(step_id, input_artifact, operation, output_artifact, responsible_role, notes)
VALUES
(1,'raw_measurements.csv','quality_control','clean_measurements.csv','analysis_team','Apply predefined QC flags'),
(2,'clean_measurements.csv','statistical_summary','summary_table.csv','analysis_team','Generate measurement quality summary'),
(3,'uncertainty_components.csv','uncertainty_budget','uncertainty_summary.csv','analysis_team','Combine uncertainty components'),
(4,'summary_table.csv','report_generation','reproducibility_report.md','analysis_team','Generate reproducibility report');

INSERT INTO quality_control_rules
(rule_name, field_name, rule_description, severity, notes)
VALUES
('required_sample_id','sample_id','Sample identifier must be present','error','Synthetic QC rule'),
('valid_qc_flag','qc_flag','QC flag must be pass review or fail','error','Synthetic QC rule'),
('unit_present','unit','Measurement unit must be present','error','Synthetic QC rule'),
('numeric_measurement','measurement_value','Measurement value should be numeric when not missing','warning','Synthetic QC rule');

INSERT INTO workflow_runs
(workflow_name, input_artifact, output_artifact, software_environment, run_status, notes)
VALUES
('measurement_quality_summary','measurements.csv','summary_table.csv','python pandas environment','completed','Synthetic workflow run'),
('uncertainty_budget','uncertainty_components.csv','uncertainty_summary.csv','python pandas environment','completed','Synthetic workflow run');
