-- Biostatistics and experimental design reproducibility schema.

DROP TABLE IF EXISTS experimental_units;
DROP TABLE IF EXISTS treatment_allocation;
DROP TABLE IF EXISTS two_group_measurements;
DROP TABLE IF EXISTS blocked_design;
DROP TABLE IF EXISTS factorial_design_observations;
DROP TABLE IF EXISTS nested_replicates;
DROP TABLE IF EXISTS assay_plate_layout;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE experimental_units (
    experimental_unit_id TEXT PRIMARY KEY,
    unit_type TEXT NOT NULL,
    biological_level TEXT NOT NULL,
    block_id TEXT,
    notes TEXT
);

CREATE TABLE treatment_allocation (
    allocation_id INTEGER PRIMARY KEY,
    experimental_unit_id TEXT NOT NULL,
    block_id TEXT,
    treatment TEXT NOT NULL,
    allocation_method TEXT NOT NULL,
    seed INTEGER,
    notes TEXT
);

CREATE TABLE two_group_measurements (
    sample_id TEXT PRIMARY KEY,
    group_name TEXT NOT NULL,
    measurement_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE blocked_design (
    block_id TEXT NOT NULL,
    treatment TEXT NOT NULL,
    response REAL NOT NULL,
    notes TEXT,
    PRIMARY KEY (block_id, treatment)
);

CREATE TABLE factorial_design_observations (
    experimental_unit_id TEXT PRIMARY KEY,
    temperature TEXT NOT NULL,
    nutrient TEXT NOT NULL,
    replicate INTEGER NOT NULL,
    response REAL NOT NULL,
    notes TEXT
);

CREATE TABLE nested_replicates (
    biological_unit TEXT NOT NULL,
    technical_replicate INTEGER NOT NULL,
    treatment TEXT NOT NULL,
    response REAL NOT NULL,
    notes TEXT,
    PRIMARY KEY (biological_unit, technical_replicate)
);

CREATE TABLE assay_plate_layout (
    well TEXT PRIMARY KEY,
    row_label TEXT NOT NULL,
    column_number INTEGER NOT NULL,
    treatment TEXT NOT NULL,
    block_id TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    mean_difference REAL,
    pooled_sd REAL,
    effect_size_d REAL,
    standard_error REAL,
    ci_lower REAL,
    ci_upper REAL,
    estimated_power REAL,
    p_value REAL,
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

INSERT INTO two_group_measurements
(sample_id, group_name, measurement_value, notes)
VALUES
('s001','control',10.2,'Synthetic two-group measurement'),
('s002','control',11.1,'Synthetic two-group measurement'),
('s003','control',9.8,'Synthetic two-group measurement'),
('s004','control',10.5,'Synthetic two-group measurement'),
('s005','control',10.9,'Synthetic two-group measurement'),
('s006','control',11.0,'Synthetic two-group measurement'),
('s007','control',9.9,'Synthetic two-group measurement'),
('s008','control',10.4,'Synthetic two-group measurement'),
('s009','treated',12.1,'Synthetic two-group measurement'),
('s010','treated',11.7,'Synthetic two-group measurement'),
('s011','treated',12.4,'Synthetic two-group measurement'),
('s012','treated',11.9,'Synthetic two-group measurement'),
('s013','treated',12.0,'Synthetic two-group measurement'),
('s014','treated',12.6,'Synthetic two-group measurement'),
('s015','treated',11.8,'Synthetic two-group measurement'),
('s016','treated',12.3,'Synthetic two-group measurement');

INSERT INTO blocked_design
(block_id, treatment, response, notes)
VALUES
('block_01','control',10.1,'Synthetic blocked design'),
('block_01','treated',11.8,'Synthetic blocked design'),
('block_02','control',9.9,'Synthetic blocked design'),
('block_02','treated',11.5,'Synthetic blocked design'),
('block_03','control',10.6,'Synthetic blocked design'),
('block_03','treated',12.2,'Synthetic blocked design'),
('block_04','control',10.4,'Synthetic blocked design'),
('block_04','treated',12.0,'Synthetic blocked design'),
('block_05','control',9.7,'Synthetic blocked design'),
('block_05','treated',11.1,'Synthetic blocked design'),
('block_06','control',10.2,'Synthetic blocked design'),
('block_06','treated',11.9,'Synthetic blocked design');

INSERT INTO factorial_design_observations
(experimental_unit_id, temperature, nutrient, replicate, response, notes)
VALUES
('ambient_low_1','ambient','low',1,10.1,'Synthetic factorial observation'),
('ambient_low_2','ambient','low',2,10.4,'Synthetic factorial observation'),
('ambient_low_3','ambient','low',3,10.2,'Synthetic factorial observation'),
('ambient_low_4','ambient','low',4,10.5,'Synthetic factorial observation'),
('ambient_high_1','ambient','high',1,12.0,'Synthetic factorial observation'),
('ambient_high_2','ambient','high',2,12.3,'Synthetic factorial observation'),
('ambient_high_3','ambient','high',3,11.8,'Synthetic factorial observation'),
('ambient_high_4','ambient','high',4,12.1,'Synthetic factorial observation'),
('hot_low_1','high_temperature','low',1,9.6,'Synthetic factorial observation'),
('hot_low_2','high_temperature','low',2,9.8,'Synthetic factorial observation'),
('hot_low_3','high_temperature','low',3,9.4,'Synthetic factorial observation'),
('hot_low_4','high_temperature','low',4,9.7,'Synthetic factorial observation'),
('hot_high_1','high_temperature','high',1,13.4,'Synthetic factorial observation'),
('hot_high_2','high_temperature','high',2,13.1,'Synthetic factorial observation'),
('hot_high_3','high_temperature','high',3,13.8,'Synthetic factorial observation'),
('hot_high_4','high_temperature','high',4,13.5,'Synthetic factorial observation');

INSERT INTO nested_replicates
(biological_unit, technical_replicate, treatment, response, notes)
VALUES
('unit_01',1,'control',10.1,'Synthetic nested replicate'),
('unit_01',2,'control',10.3,'Synthetic nested replicate'),
('unit_01',3,'control',10.2,'Synthetic nested replicate'),
('unit_02',1,'control',9.8,'Synthetic nested replicate'),
('unit_02',2,'control',10.0,'Synthetic nested replicate'),
('unit_02',3,'control',9.9,'Synthetic nested replicate'),
('unit_03',1,'control',10.7,'Synthetic nested replicate'),
('unit_03',2,'control',10.5,'Synthetic nested replicate'),
('unit_03',3,'control',10.6,'Synthetic nested replicate'),
('unit_04',1,'treated',12.0,'Synthetic nested replicate'),
('unit_04',2,'treated',12.2,'Synthetic nested replicate'),
('unit_04',3,'treated',12.1,'Synthetic nested replicate'),
('unit_05',1,'treated',11.7,'Synthetic nested replicate'),
('unit_05',2,'treated',11.9,'Synthetic nested replicate'),
('unit_05',3,'treated',11.8,'Synthetic nested replicate'),
('unit_06',1,'treated',12.5,'Synthetic nested replicate'),
('unit_06',2,'treated',12.7,'Synthetic nested replicate'),
('unit_06',3,'treated',12.6,'Synthetic nested replicate');

INSERT INTO assay_plate_layout
(well, row_label, column_number, treatment, block_id, notes)
VALUES
('A01','A',1,'control','plate_1','Synthetic plate layout'),
('A02','A',2,'treated','plate_1','Synthetic plate layout'),
('A03','A',3,'low_dose','plate_1','Synthetic plate layout'),
('A04','A',4,'high_dose','plate_1','Synthetic plate layout'),
('B01','B',1,'treated','plate_1','Synthetic plate layout'),
('B02','B',2,'control','plate_1','Synthetic plate layout'),
('B03','B',3,'high_dose','plate_1','Synthetic plate layout'),
('B04','B',4,'low_dose','plate_1','Synthetic plate layout'),
('C01','C',1,'low_dose','plate_1','Synthetic plate layout'),
('C02','C',2,'high_dose','plate_1','Synthetic plate layout'),
('C03','C',3,'control','plate_1','Synthetic plate layout'),
('C04','C',4,'treated','plate_1','Synthetic plate layout');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('two_group_measurements.csv','synthetic_example','constructed_example','two-group effect-size estimation','MIT-compatible example data','two-group setup','Not real biological experiment data'),
('blocked_design.csv','synthetic_example','constructed_example','blocked design summary','MIT-compatible example data','blocking setup','Synthetic block structure only'),
('factorial_design_observations.csv','synthetic_example','constructed_example','factorial design with interaction scaffold','MIT-compatible example data','factorial setup','Synthetic factorial observations only'),
('nested_replicates.csv','synthetic_example','constructed_example','nested replicate scaffold','MIT-compatible example data','nested setup','Technical and biological nesting simplified'),
('assay_plate_layout.csv','synthetic_example','constructed_example','assay plate allocation summary','MIT-compatible example data','plate layout setup','Synthetic plate layout only');
