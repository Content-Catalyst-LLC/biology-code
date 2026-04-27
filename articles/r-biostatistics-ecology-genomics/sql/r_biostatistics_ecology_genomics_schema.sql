-- R for biostatistics, ecology, and genomics schema.

DROP TABLE IF EXISTS biostat_measurements;
DROP TABLE IF EXISTS ecology_counts;
DROP TABLE IF EXISTS genomics_counts_long;
DROP TABLE IF EXISTS genomics_metadata;
DROP TABLE IF EXISTS data_dictionary;
DROP TABLE IF EXISTS provenance_manifest;
DROP TABLE IF EXISTS artifacts;

CREATE TABLE biostat_measurements (
    sample_id TEXT PRIMARY KEY,
    treatment TEXT NOT NULL,
    batch TEXT NOT NULL,
    subject_id TEXT,
    response REAL NOT NULL,
    binary_response INTEGER NOT NULL,
    time REAL,
    event INTEGER,
    qc_flag TEXT NOT NULL CHECK (qc_flag IN ('pass', 'review', 'fail'))
);

CREATE TABLE ecology_counts (
    record_id INTEGER PRIMARY KEY,
    site TEXT NOT NULL,
    habitat TEXT NOT NULL,
    species TEXT NOT NULL,
    count INTEGER NOT NULL CHECK (count >= 0),
    sampling_effort_hours REAL NOT NULL
);

CREATE TABLE genomics_counts_long (
    record_id INTEGER PRIMARY KEY,
    gene_id TEXT NOT NULL,
    sample_id TEXT NOT NULL,
    raw_count INTEGER NOT NULL CHECK (raw_count >= 0)
);

CREATE TABLE genomics_metadata (
    sample_id TEXT PRIMARY KEY,
    condition TEXT NOT NULL,
    batch TEXT NOT NULL,
    library_prep TEXT,
    organism TEXT,
    tissue TEXT
);

CREATE TABLE data_dictionary (
    column_name TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    unit TEXT,
    required INTEGER NOT NULL,
    domain_name TEXT NOT NULL
);

CREATE TABLE provenance_manifest (
    step_id INTEGER PRIMARY KEY,
    input_artifact TEXT NOT NULL,
    operation TEXT NOT NULL,
    script TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE artifacts (
    artifact_id INTEGER PRIMARY KEY,
    artifact_name TEXT NOT NULL,
    artifact_role TEXT NOT NULL,
    status TEXT NOT NULL,
    generated_by TEXT,
    notes TEXT
);

INSERT INTO biostat_measurements
(sample_id, treatment, batch, subject_id, response, binary_response, time, event, qc_flag)
VALUES
('sample_01','control','batch_01','subject_01',10.2,0,12,1,'pass'),
('sample_02','control','batch_01','subject_02',10.5,0,14,1,'pass'),
('sample_03','control','batch_01','subject_03',10.1,0,11,1,'pass'),
('sample_04','control','batch_02','subject_04',10.4,1,15,0,'pass'),
('sample_05','control','batch_02','subject_05',10.3,0,10,1,'pass'),
('sample_06','control','batch_02','subject_06',10.6,0,13,1,'pass'),
('sample_07','treated','batch_02','subject_07',12.1,1,18,0,'pass'),
('sample_08','treated','batch_02','subject_08',12.4,1,20,0,'pass'),
('sample_09','treated','batch_03','subject_09',11.9,1,17,1,'pass'),
('sample_10','treated','batch_03','subject_10',12.8,1,22,0,'review'),
('sample_11','treated','batch_03','subject_11',12.0,1,19,1,'pass'),
('sample_12','treated','batch_03','subject_12',12.5,1,21,0,'pass');

INSERT INTO ecology_counts
(site, habitat, species, count, sampling_effort_hours)
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
('reef_C','degraded','sp_4',0,2),
('reef_D','reference','sp_1',7,2),
('reef_D','reference','sp_2',13,2),
('reef_D','reference','sp_3',10,2),
('reef_D','reference','sp_4',8,2);

INSERT INTO genomics_metadata
(sample_id, condition, batch, library_prep, organism, tissue)
VALUES
('sample_01','control','batch_01','prep_A','model_species','liver'),
('sample_02','control','batch_01','prep_A','model_species','liver'),
('sample_03','control','batch_02','prep_B','model_species','liver'),
('sample_04','treated','batch_02','prep_B','model_species','liver'),
('sample_05','treated','batch_03','prep_C','model_species','liver'),
('sample_06','treated','batch_03','prep_C','model_species','liver');

INSERT INTO genomics_counts_long
(gene_id, sample_id, raw_count)
VALUES
('gene_A','sample_01',120),('gene_A','sample_02',130),('gene_A','sample_03',125),('gene_A','sample_04',300),('gene_A','sample_05',310),('gene_A','sample_06',290),
('gene_B','sample_01',500),('gene_B','sample_02',520),('gene_B','sample_03',510),('gene_B','sample_04',530),('gene_B','sample_05',540),('gene_B','sample_06',550),
('gene_C','sample_01',20),('gene_C','sample_02',25),('gene_C','sample_03',22),('gene_C','sample_04',80),('gene_C','sample_05',90),('gene_C','sample_06',85),
('gene_D','sample_01',900),('gene_D','sample_02',870),('gene_D','sample_03',910),('gene_D','sample_04',860),('gene_D','sample_05',855),('gene_D','sample_06',880),
('gene_E','sample_01',5),('gene_E','sample_02',4),('gene_E','sample_03',6),('gene_E','sample_04',15),('gene_E','sample_05',16),('gene_E','sample_06',14),
('gene_F','sample_01',200),('gene_F','sample_02',210),('gene_F','sample_03',205),('gene_F','sample_04',190),('gene_F','sample_05',195),('gene_F','sample_06',188);

INSERT INTO data_dictionary
(column_name, description, unit, required, domain_name)
VALUES
('sample_id','Unique biological sample identifier',NULL,1,'biostatistics/genomics'),
('treatment','Experimental treatment group',NULL,1,'biostatistics'),
('batch','Analytical batch identifier',NULL,1,'biostatistics/genomics'),
('response','Continuous biological response','arbitrary',1,'biostatistics'),
('binary_response','Binary biological response',NULL,0,'biostatistics'),
('time','Time-to-event observation time','days',0,'biostatistics'),
('event','Event indicator where 1 means event observed',NULL,0,'biostatistics'),
('site','Ecological sampling site',NULL,1,'ecology'),
('habitat','Habitat or site condition',NULL,1,'ecology'),
('species','Species or taxon identifier',NULL,1,'ecology'),
('count','Observed count','count',1,'ecology'),
('gene_id','Gene or genomic feature identifier',NULL,1,'genomics'),
('condition','Genomics experimental condition',NULL,1,'genomics'),
('library_prep','Library preparation identifier',NULL,0,'genomics');

INSERT INTO provenance_manifest
(step_id, input_artifact, operation, script, output_artifact, notes)
VALUES
(1,'biostat_measurements.csv','biostatistical_models','r/01_biostatistics_models.R','outputs/tables/biostatistics_model_summary.csv','Fit basic biostatistical models'),
(2,'ecology_counts.csv','ecological_diversity_ordination','r/02_ecology_diversity_ordination.R','outputs/tables/ecology_diversity_ordination.csv','Compute diversity and ordination scaffolds'),
(3,'genomics_counts.csv','genomics_count_normalization','r/03_genomics_count_workflow.R','outputs/tables/genomics_count_summary.csv','Normalize counts and compute log fold change'),
(4,'biostat_measurements.csv;ecology_counts.csv;genomics_counts.csv','visualization_suite','r/04_visualization_suite.R','outputs/figures/r_biology_workflow_panels.png','Create reproducible visualization outputs'),
(5,'provenance_manifest.csv','reproducibility_manifest','r/05_reproducibility_manifest.R','outputs/tables/reproducibility_manifest.csv','Record artifacts and workflow steps');

INSERT INTO artifacts
(artifact_name, artifact_role, status, generated_by, notes)
VALUES
('biostat_measurements.csv','input','archived','manual synthetic setup','Synthetic biostatistical data'),
('ecology_counts.csv','input','archived','manual synthetic setup','Synthetic ecological community data'),
('genomics_counts.csv','input','archived','manual synthetic setup','Synthetic genomics count data'),
('genomics_metadata.csv','metadata','archived','manual synthetic setup','Synthetic genomics sample metadata'),
('biostatistics_model_summary.csv','output','generated','r/01_biostatistics_models.R','Model coefficient summary'),
('ecology_diversity_ordination.csv','output','generated','r/02_ecology_diversity_ordination.R','Ecological diversity and ordination table'),
('genomics_count_summary.csv','output','generated','r/03_genomics_count_workflow.R','Genomics normalization summary'),
('r_biology_workflow_panels.png','figure','generated','r/04_visualization_suite.R','Integrated workflow figure');
