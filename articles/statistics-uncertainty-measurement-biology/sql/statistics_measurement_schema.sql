-- Statistics, uncertainty, and measurement in biology reproducibility schema.

DROP TABLE IF EXISTS measurements;
DROP TABLE IF EXISTS uncertainty_components;
DROP TABLE IF EXISTS calibration_standards;
DROP TABLE IF EXISTS biological_technical_replicates;
DROP TABLE IF EXISTS assay_qc;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE measurements (
    sample_id TEXT PRIMARY KEY,
    group_name TEXT NOT NULL,
    measurement_value REAL NOT NULL,
    unit TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE uncertainty_components (
    source_id TEXT PRIMARY KEY,
    standard_uncertainty REAL NOT NULL,
    unit TEXT NOT NULL,
    category TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE calibration_standards (
    standard_id TEXT PRIMARY KEY,
    concentration REAL NOT NULL,
    response REAL NOT NULL,
    notes TEXT
);

CREATE TABLE biological_technical_replicates (
    biological_unit TEXT NOT NULL,
    technical_replicate INTEGER NOT NULL,
    measurement REAL NOT NULL,
    notes TEXT,
    PRIMARY KEY (biological_unit, technical_replicate)
);

CREATE TABLE assay_qc (
    run_id TEXT PRIMARY KEY,
    control_low REAL NOT NULL,
    control_high REAL NOT NULL,
    blank_response REAL NOT NULL,
    positive_control REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    mean_value REAL,
    standard_deviation REAL,
    standard_error REAL,
    ci_lower REAL,
    ci_upper REAL,
    combined_uncertainty REAL,
    expanded_uncertainty REAL,
    calibration_slope REAL,
    calibration_intercept REAL,
    r_squared REAL,
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

INSERT INTO measurements
(sample_id, group_name, measurement_value, unit, notes)
VALUES
('s001','control',10.2,'arbitrary_units','Synthetic measurement'),
('s002','control',11.1,'arbitrary_units','Synthetic measurement'),
('s003','control',9.8,'arbitrary_units','Synthetic measurement'),
('s004','control',10.5,'arbitrary_units','Synthetic measurement'),
('s005','control',10.9,'arbitrary_units','Synthetic measurement'),
('s006','control',11.0,'arbitrary_units','Synthetic measurement'),
('s007','control',9.9,'arbitrary_units','Synthetic measurement'),
('s008','control',10.4,'arbitrary_units','Synthetic measurement'),
('s009','control',11.3,'arbitrary_units','Synthetic measurement'),
('s010','control',10.7,'arbitrary_units','Synthetic measurement'),
('s011','treated',12.1,'arbitrary_units','Synthetic measurement'),
('s012','treated',11.7,'arbitrary_units','Synthetic measurement'),
('s013','treated',12.4,'arbitrary_units','Synthetic measurement'),
('s014','treated',11.9,'arbitrary_units','Synthetic measurement'),
('s015','treated',12.0,'arbitrary_units','Synthetic measurement'),
('s016','treated',12.6,'arbitrary_units','Synthetic measurement'),
('s017','treated',11.8,'arbitrary_units','Synthetic measurement'),
('s018','treated',12.3,'arbitrary_units','Synthetic measurement');

INSERT INTO uncertainty_components
(source_id, standard_uncertainty, unit, category, notes)
VALUES
('instrument_repeatability',0.12,'arbitrary_units','technical','Synthetic uncertainty component'),
('calibration_standard',0.08,'arbitrary_units','calibration','Synthetic uncertainty component'),
('sample_preparation',0.15,'arbitrary_units','preparation','Synthetic uncertainty component'),
('operator_variability',0.06,'arbitrary_units','operator','Synthetic uncertainty component'),
('temperature_effect',0.05,'arbitrary_units','environmental','Synthetic uncertainty component');

INSERT INTO calibration_standards
(standard_id, concentration, response, notes)
VALUES
('std_00',0,0.05,'Synthetic standard'),
('std_01',1,0.82,'Synthetic standard'),
('std_02',2,1.58,'Synthetic standard'),
('std_05',5,3.95,'Synthetic standard'),
('std_10',10,7.84,'Synthetic standard'),
('std_20',20,15.70,'Synthetic standard');

INSERT INTO biological_technical_replicates
(biological_unit, technical_replicate, measurement, notes)
VALUES
('unit_01',1,8.91,'Synthetic replicate'),
('unit_01',2,9.14,'Synthetic replicate'),
('unit_01',3,9.02,'Synthetic replicate'),
('unit_01',4,9.21,'Synthetic replicate'),
('unit_02',1,10.82,'Synthetic replicate'),
('unit_02',2,10.65,'Synthetic replicate'),
('unit_02',3,10.95,'Synthetic replicate'),
('unit_02',4,10.71,'Synthetic replicate'),
('unit_03',1,11.42,'Synthetic replicate'),
('unit_03',2,11.31,'Synthetic replicate'),
('unit_03',3,11.58,'Synthetic replicate'),
('unit_03',4,11.49,'Synthetic replicate'),
('unit_04',1,9.78,'Synthetic replicate'),
('unit_04',2,9.91,'Synthetic replicate'),
('unit_04',3,9.73,'Synthetic replicate'),
('unit_04',4,9.84,'Synthetic replicate'),
('unit_05',1,12.22,'Synthetic replicate'),
('unit_05',2,12.09,'Synthetic replicate'),
('unit_05',3,12.35,'Synthetic replicate'),
('unit_05',4,12.17,'Synthetic replicate'),
('unit_06',1,10.31,'Synthetic replicate'),
('unit_06',2,10.44,'Synthetic replicate'),
('unit_06',3,10.20,'Synthetic replicate'),
('unit_06',4,10.38,'Synthetic replicate');

INSERT INTO assay_qc
(run_id, control_low, control_high, blank_response, positive_control, notes)
VALUES
('run_001',2.05,9.92,0.03,15.21,'synthetic_qc'),
('run_002',2.12,10.05,0.04,15.44,'synthetic_qc'),
('run_003',1.98,9.85,0.02,15.10,'synthetic_qc'),
('run_004',2.25,10.31,0.06,15.60,'synthetic_qc'),
('run_005',2.01,9.98,0.03,15.29,'synthetic_qc');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('measurements.csv','synthetic_example','constructed_example','descriptive uncertainty and confidence interval','MIT-compatible example data','measurement setup','Not real biological measurement data'),
('uncertainty_components.csv','synthetic_example','constructed_example','root-sum-of-squares uncertainty budget','MIT-compatible example data','uncertainty budget setup','Assumes independent components'),
('calibration_standards.csv','synthetic_example','constructed_example','linear calibration curve','MIT-compatible example data','calibration setup','Not real calibration data'),
('biological_technical_replicates.csv','synthetic_example','constructed_example','variance component scaffold','MIT-compatible example data','replicate setup','Simplified replicate design'),
('assay_qc.csv','synthetic_example','constructed_example','assay quality-control summary','MIT-compatible example data','qc setup','Synthetic QC values only');
