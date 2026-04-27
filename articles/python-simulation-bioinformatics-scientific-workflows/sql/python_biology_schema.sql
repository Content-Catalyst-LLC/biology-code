-- Python for simulation, bioinformatics, and scientific workflows schema.

DROP TABLE IF EXISTS simulation_parameters;
DROP TABLE IF EXISTS sequences;
DROP TABLE IF EXISTS sequence_metadata;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS validation_checks;

CREATE TABLE simulation_parameters (
    scenario TEXT PRIMARY KEY,
    initial_population REAL NOT NULL CHECK (initial_population >= 0),
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL CHECK (carrying_capacity > 0),
    dt REAL NOT NULL CHECK (dt > 0),
    steps INTEGER NOT NULL CHECK (steps >= 0),
    random_seed INTEGER,
    noise_sd REAL NOT NULL CHECK (noise_sd >= 0)
);

CREATE TABLE sequences (
    sequence_id TEXT PRIMARY KEY,
    sequence_text TEXT NOT NULL,
    sequence_length INTEGER NOT NULL,
    gc_content REAL,
    ambiguous_bases INTEGER NOT NULL
);

CREATE TABLE sequence_metadata (
    sequence_id TEXT PRIMARY KEY,
    organism TEXT NOT NULL,
    condition TEXT NOT NULL,
    batch TEXT NOT NULL,
    qc_flag TEXT NOT NULL CHECK (qc_flag IN ('pass', 'review', 'fail')),
    notes TEXT
);

CREATE TABLE workflow_steps (
    step_id INTEGER PRIMARY KEY,
    operation TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    script TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE artifacts (
    artifact_id INTEGER PRIMARY KEY,
    artifact_name TEXT NOT NULL,
    artifact_role TEXT NOT NULL,
    status TEXT NOT NULL,
    sha256 TEXT,
    notes TEXT
);

CREATE TABLE validation_checks (
    check_id INTEGER PRIMARY KEY,
    check_name TEXT NOT NULL,
    passed INTEGER NOT NULL,
    details TEXT,
    checked_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO simulation_parameters
(scenario, initial_population, growth_rate, carrying_capacity, dt, steps, random_seed, noise_sd)
VALUES
('baseline',25,0.35,1000,0.1,200,101,0.00),
('low_growth',25,0.18,1000,0.1,200,102,0.00),
('high_capacity',25,0.35,1500,0.1,200,103,0.00),
('stochastic_baseline',25,0.35,1000,0.1,200,104,4.50);

INSERT INTO sequences
(sequence_id, sequence_text, sequence_length, gc_content, ambiguous_bases)
VALUES
('sample_01','ATGCGCGTAATTAACCGGTTACCGTAGCTA',32,0.53125,0),
('sample_02','ATATATGGCCNNATGCGTAACCGGTTAACTA',34,0.46875,2),
('sample_03','GCGCGCGCTTATATATACCGGTTAACCGGTA',34,0.55882,0);

INSERT INTO sequence_metadata
(sequence_id, organism, condition, batch, qc_flag, notes)
VALUES
('sample_01','model_species','control','batch_01','pass','Synthetic sequence record'),
('sample_02','model_species','treated','batch_01','review','Contains ambiguous bases'),
('sample_03','model_species','treated','batch_02','pass','Synthetic sequence record');

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'logistic_growth_simulation','simulation_parameters.csv','python/01_logistic_growth_simulation.py','outputs/simulations/logistic_growth_outputs.csv','Run deterministic simulation scenarios'),
(2,'stochastic_population_simulation','simulation_parameters.csv','python/02_stochastic_population_simulation.py','outputs/simulations/stochastic_population_outputs.csv','Run stochastic simulation scaffold'),
(3,'sequence_summary','sequences.fasta','python/03_sequence_summary.py','outputs/tables/sequence_summary.csv','Summarize FASTA records'),
(4,'kmer_counting','sequences.fasta','python/04_kmer_counting.py','outputs/tables/kmer_counts.csv','Count DNA k-mers'),
(5,'metadata_validation','sequence_metadata.csv','python/05_metadata_validation.py','outputs/tables/metadata_validation_report.csv','Validate sequence metadata'),
(6,'workflow_manifest','workflow_steps.csv','python/06_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record provenance and checksums');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('simulation_parameters.csv','input','archived',NULL,'Synthetic simulation parameter table'),
('sequences.fasta','input','archived',NULL,'Synthetic FASTA file'),
('sequence_metadata.csv','metadata','archived',NULL,'Synthetic sequence metadata'),
('logistic_growth_outputs.csv','output','generated',NULL,'Deterministic simulation output'),
('stochastic_population_outputs.csv','output','generated',NULL,'Stochastic simulation output'),
('sequence_summary.csv','output','generated',NULL,'Sequence summary table'),
('kmer_counts.csv','output','generated',NULL,'K-mer count table');

INSERT INTO validation_checks
(check_name, passed, details)
VALUES
('simulation_parameters_positive_capacity',1,'All carrying-capacity values are positive'),
('sequence_metadata_qc_flags_valid',1,'All QC flags use controlled values'),
('sequence_ids_unique',1,'Sequence identifiers are unique');
