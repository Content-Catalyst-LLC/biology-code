-- R for biological data analysis and visualization schema.

DROP TABLE IF EXISTS samples;
DROP TABLE IF EXISTS measurements;
DROP TABLE IF EXISTS species_counts;
DROP TABLE IF EXISTS dose_response;
DROP TABLE IF EXISTS data_dictionary;
DROP TABLE IF EXISTS provenance_manifest;
DROP TABLE IF EXISTS figures;
DROP TABLE IF EXISTS artifacts;

CREATE TABLE samples (
    sample_id TEXT PRIMARY KEY,
    treatment TEXT,
    tissue TEXT,
    batch_id TEXT,
    instrument_id TEXT,
    notes TEXT
);

CREATE TABLE measurements (
    measurement_id INTEGER PRIMARY KEY,
    sample_id TEXT NOT NULL,
    treatment TEXT NOT NULL,
    tissue TEXT NOT NULL,
    batch_id TEXT NOT NULL,
    instrument_id TEXT NOT NULL,
    value REAL,
    unit TEXT NOT NULL,
    qc_flag TEXT NOT NULL CHECK (qc_flag IN ('pass', 'review', 'fail')),
    notes TEXT
);

CREATE TABLE species_counts (
    record_id INTEGER PRIMARY KEY,
    site TEXT NOT NULL,
    habitat TEXT NOT NULL,
    species TEXT NOT NULL,
    count INTEGER NOT NULL CHECK (count >= 0),
    survey_effort_hours REAL NOT NULL
);

CREATE TABLE dose_response (
    record_id INTEGER PRIMARY KEY,
    sample_id TEXT NOT NULL,
    dose REAL NOT NULL CHECK (dose >= 0),
    response REAL NOT NULL,
    unit TEXT NOT NULL,
    qc_flag TEXT NOT NULL CHECK (qc_flag IN ('pass', 'review', 'fail'))
);

CREATE TABLE data_dictionary (
    column_name TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    unit TEXT,
    required INTEGER NOT NULL,
    allowed_values TEXT
);

CREATE TABLE provenance_manifest (
    step_id INTEGER PRIMARY KEY,
    input_artifact TEXT NOT NULL,
    operation TEXT NOT NULL,
    script TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE figures (
    figure_id INTEGER PRIMARY KEY,
    figure_name TEXT NOT NULL,
    source_script TEXT NOT NULL,
    input_data TEXT NOT NULL,
    output_path TEXT NOT NULL,
    figure_purpose TEXT
);

CREATE TABLE artifacts (
    artifact_id INTEGER PRIMARY KEY,
    artifact_name TEXT NOT NULL,
    artifact_role TEXT NOT NULL,
    status TEXT NOT NULL,
    generated_by TEXT,
    notes TEXT
);

INSERT INTO samples
(sample_id, treatment, tissue, batch_id, instrument_id, notes)
VALUES
('sample_01','control','liver','batch_01','instrument_A','Synthetic sample'),
('sample_02','control','liver','batch_01','instrument_A','Synthetic sample'),
('sample_03','control','liver','batch_01','instrument_A','Synthetic sample'),
('sample_04','control','liver','batch_01','instrument_A','Synthetic sample'),
('sample_05','control','liver','batch_02','instrument_A','Synthetic sample'),
('sample_06','control','liver','batch_02','instrument_A','Synthetic sample'),
('sample_07','treated','liver','batch_02','instrument_A','Synthetic sample'),
('sample_08','treated','liver','batch_02','instrument_A','Synthetic sample'),
('sample_09','treated','liver','batch_03','instrument_B','Synthetic sample'),
('sample_10','treated','liver','batch_03','instrument_B','Synthetic sample'),
('sample_11','treated','liver','batch_03','instrument_B','Synthetic sample'),
('sample_12','treated','liver','batch_03','instrument_B','Synthetic sample');

INSERT INTO measurements
(sample_id, treatment, tissue, batch_id, instrument_id, value, unit, qc_flag, notes)
VALUES
('sample_01','control','liver','batch_01','instrument_A',10.2,'mmol/L','pass','Synthetic measurement'),
('sample_02','control','liver','batch_01','instrument_A',10.5,'mmol/L','pass','Synthetic measurement'),
('sample_03','control','liver','batch_01','instrument_A',10.1,'mmol/L','pass','Synthetic measurement'),
('sample_04','control','liver','batch_01','instrument_A',10.4,'mmol/L','pass','Synthetic measurement'),
('sample_05','control','liver','batch_02','instrument_A',10.3,'mmol/L','pass','Synthetic measurement'),
('sample_06','control','liver','batch_02','instrument_A',10.6,'mmol/L','pass','Synthetic measurement'),
('sample_07','treated','liver','batch_02','instrument_A',12.1,'mmol/L','pass','Synthetic measurement'),
('sample_08','treated','liver','batch_02','instrument_A',12.4,'mmol/L','pass','Synthetic measurement'),
('sample_09','treated','liver','batch_03','instrument_B',11.9,'mmol/L','pass','Synthetic measurement'),
('sample_10','treated','liver','batch_03','instrument_B',12.8,'mmol/L','review','Synthetic measurement under review'),
('sample_11','treated','liver','batch_03','instrument_B',NULL,'mmol/L','fail','Synthetic failed measurement'),
('sample_12','treated','liver','batch_03','instrument_B',12.5,'mmol/L','pass','Synthetic measurement');

INSERT INTO species_counts
(site, habitat, species, count, survey_effort_hours)
VALUES
('reef_A','restored','sp_1',18,2),
('reef_A','restored','sp_2',7,2),
('reef_A','restored','sp_3',3,2),
('reef_A','restored','sp_4',0,2),
('reef_B','reference','sp_1',10,2),
('reef_B','reference','sp_2',11,2),
('reef_B','reference','sp_3',9,2),
('reef_B','reference','sp_4',4,2),
('reef_C','degraded','sp_1',21,2),
('reef_C','degraded','sp_2',2,2),
('reef_C','degraded','sp_3',1,2),
('reef_C','degraded','sp_4',0,2);

INSERT INTO dose_response
(sample_id, dose, response, unit, qc_flag)
VALUES
('dose_01',0,0.05,'relative_response','pass'),
('dose_02',0,0.03,'relative_response','pass'),
('dose_03',0,0.06,'relative_response','pass'),
('dose_04',1,0.12,'relative_response','pass'),
('dose_05',1,0.15,'relative_response','pass'),
('dose_06',1,0.11,'relative_response','pass'),
('dose_07',3,0.25,'relative_response','pass'),
('dose_08',3,0.28,'relative_response','pass'),
('dose_09',3,0.22,'relative_response','pass'),
('dose_10',10,0.54,'relative_response','pass'),
('dose_11',10,0.58,'relative_response','pass'),
('dose_12',10,0.51,'relative_response','pass'),
('dose_13',30,0.78,'relative_response','pass'),
('dose_14',30,0.82,'relative_response','pass'),
('dose_15',30,0.76,'relative_response','pass'),
('dose_16',100,0.91,'relative_response','pass'),
('dose_17',100,0.94,'relative_response','pass'),
('dose_18',100,0.89,'relative_response','pass');

INSERT INTO data_dictionary
(column_name, description, unit, required, allowed_values)
VALUES
('sample_id','Unique biological sample identifier',NULL,1,NULL),
('treatment','Experimental treatment group',NULL,1,'control|treated'),
('tissue','Tissue or biological material',NULL,1,NULL),
('batch_id','Analytical batch identifier',NULL,1,NULL),
('instrument_id','Instrument identifier',NULL,1,NULL),
('value','Measured biological quantity','mmol/L',1,NULL),
('unit','Measurement unit',NULL,1,'mmol/L'),
('qc_flag','Quality-control status',NULL,1,'pass|review|fail'),
('site','Ecological sampling site',NULL,0,NULL),
('habitat','Habitat or site condition',NULL,0,'restored|reference|degraded'),
('species','Species or taxon identifier',NULL,0,NULL),
('count','Observed count','count',0,NULL),
('dose','Experimental dose','arbitrary',0,NULL),
('response','Measured response','relative_response',0,NULL);

INSERT INTO provenance_manifest
(step_id, input_artifact, operation, script, output_artifact, notes)
VALUES
(1,'measurements.csv','measurement_summary','r/01_measurement_quality_summary.R','outputs/tables/measurement_summary.csv','Summarize valid pass-QC measurements'),
(2,'measurements.csv','assay_visualization','r/02_assay_visualization.R','outputs/figures/assay_plot.png','Create reproducible assay visualization'),
(3,'species_counts.csv','ecological_diversity','r/03_ecological_diversity.R','outputs/tables/ecological_diversity.csv','Calculate richness and Shannon diversity'),
(4,'dose_response.csv','dose_response_visualization','r/04_dose_response_visualization.R','outputs/figures/dose_response_plot.png','Create descriptive dose-response plot'),
(5,'provenance_manifest.csv','reproducibility_manifest','r/05_reproducibility_manifest.R','outputs/tables/artifact_manifest.csv','Record project artifacts');

INSERT INTO figures
(figure_name, source_script, input_data, output_path, figure_purpose)
VALUES
('assay_plot','r/02_assay_visualization.R','measurements.csv','outputs/figures/assay_plot.png','Treatment-level assay visualization'),
('dose_response_plot','r/04_dose_response_visualization.R','dose_response.csv','outputs/figures/dose_response_plot.png','Descriptive dose-response visualization');

INSERT INTO artifacts
(artifact_name, artifact_role, status, generated_by, notes)
VALUES
('measurements.csv','input','archived','manual synthetic setup','Synthetic measurement input'),
('species_counts.csv','input','archived','manual synthetic setup','Synthetic ecological count input'),
('dose_response.csv','input','archived','manual synthetic setup','Synthetic dose-response input'),
('measurement_summary.csv','output','generated','r/01_measurement_quality_summary.R','Derived measurement summary'),
('assay_plot.png','figure','generated','r/02_assay_visualization.R','Generated assay figure'),
('ecological_diversity.csv','output','generated','r/03_ecological_diversity.R','Derived ecological diversity table'),
('dose_response_plot.png','figure','generated','r/04_dose_response_visualization.R','Generated dose-response figure');
