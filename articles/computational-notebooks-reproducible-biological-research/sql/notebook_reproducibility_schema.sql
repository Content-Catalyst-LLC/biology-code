DROP TABLE IF EXISTS biological_samples;
DROP TABLE IF EXISTS data_dictionary;
DROP TABLE IF EXISTS notebook_runs;
DROP TABLE IF EXISTS notebook_artifacts;
DROP TABLE IF EXISTS workflow_steps;

CREATE TABLE biological_samples (
    sample_id TEXT PRIMARY KEY,
    species TEXT NOT NULL,
    tissue_or_environment TEXT NOT NULL,
    treatment TEXT NOT NULL,
    batch TEXT NOT NULL,
    collection_site TEXT NOT NULL,
    collection_date TEXT NOT NULL,
    response_value REAL NOT NULL
);

CREATE TABLE data_dictionary (
    column_name TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    unit_or_type TEXT NOT NULL,
    required TEXT NOT NULL
);

CREATE TABLE notebook_runs (
    run_id TEXT PRIMARY KEY,
    notebook_name TEXT NOT NULL,
    kernel TEXT NOT NULL,
    clean_run INTEGER NOT NULL,
    failed_cells INTEGER NOT NULL,
    executed_cells INTEGER NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notebook_artifacts (
    artifact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    artifact_name TEXT NOT NULL,
    artifact_type TEXT NOT NULL,
    relative_path TEXT NOT NULL,
    checksum_sha256 TEXT,
    notes TEXT
);

CREATE TABLE workflow_steps (
    step_id INTEGER PRIMARY KEY,
    step_name TEXT NOT NULL,
    notebook_section TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    description TEXT NOT NULL
);

INSERT INTO biological_samples VALUES
('BIO001','Danio rerio','embryo','control','B1','lab_a','2026-01-10',1.20),
('BIO002','Danio rerio','embryo','control','B1','lab_a','2026-01-10',1.40),
('BIO003','Danio rerio','embryo','exposed','B2','lab_a','2026-01-11',2.10),
('BIO004','Danio rerio','embryo','exposed','B2','lab_a','2026-01-11',2.40),
('BIO005','Arabidopsis thaliana','leaf','control','B3','greenhouse_1','2026-02-03',0.80),
('BIO006','Arabidopsis thaliana','leaf','exposed','B3','greenhouse_1','2026-02-03',1.30),
('BIO007','Mytilus edulis','gill','control','B4','marine_site_1','2026-03-15',1.10),
('BIO008','Mytilus edulis','gill','exposed','B4','marine_site_1','2026-03-15',1.90);

INSERT INTO data_dictionary VALUES
('sample_id','Unique biological sample identifier','text','yes'),
('species','Scientific species name','text','yes'),
('tissue_or_environment','Tissue type or environmental matrix','text','yes'),
('treatment','Experimental or observational group','text','yes'),
('batch','Laboratory analytical batch or processing group','text','yes'),
('collection_site','Collection site or laboratory setting','text','yes'),
('collection_date','Date of sample collection','YYYY-MM-DD','yes'),
('response_value','Synthetic biological response value','arbitrary units','yes');

INSERT INTO notebook_runs VALUES
('NBR001','computational_notebooks_biological_research_workflow.ipynb','python3',1,0,4,CURRENT_TIMESTAMP);

INSERT INTO workflow_steps VALUES
(1,'load_metadata','Data loading','biological_sample_metadata.csv','outputs/tables/loaded_sample_count.csv','Load biological metadata from CSV'),
(2,'validate_metadata','Quality control','biological_sample_metadata.csv','outputs/tables/metadata_validation.csv','Check required fields and unique identifiers'),
(3,'summarize_groups','Exploratory summary','biological_sample_metadata.csv','outputs/tables/group_summary.csv','Summarize samples by treatment species and batch'),
(4,'record_provenance','Provenance','biological_sample_metadata.csv;data_dictionary.csv','outputs/manifests/provenance_manifest.csv','Record checksums for input artifacts'),
(5,'execution_check','Notebook execution','notebooks/computational_notebooks_biological_research_workflow.ipynb','outputs/tables/notebook_execution_check.csv','Inspect notebook scaffold metadata'),
(6,'report','Reporting','outputs/tables/group_summary.csv;outputs/manifests/provenance_manifest.csv','outputs/reports/reproducibility_report.md','Generate reproducibility report');

INSERT INTO notebook_artifacts (artifact_name, artifact_type, relative_path, checksum_sha256, notes) VALUES
('biological_sample_metadata.csv','input_data','data/biological_sample_metadata.csv',NULL,'Synthetic educational biological metadata'),
('data_dictionary.csv','metadata','data/data_dictionary.csv',NULL,'Synthetic educational data dictionary'),
('computational_notebooks_biological_research_workflow.ipynb','notebook','notebooks/computational_notebooks_biological_research_workflow.ipynb',NULL,'Minimal notebook scaffold');
