-- DNA, RNA, and molecular logic reproducibility schema.
--
-- This schema tracks sequence records, transcript decay observations,
-- expression observations, codon counts, molecular condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS sequence_records;
DROP TABLE IF EXISTS transcript_decay_observations;
DROP TABLE IF EXISTS sample_metadata;
DROP TABLE IF EXISTS expression_observations;
DROP TABLE IF EXISTS codon_counts;
DROP TABLE IF EXISTS molecular_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE sequence_records (
    sequence_id INTEGER PRIMARY KEY,
    sample_name TEXT NOT NULL UNIQUE,
    sequence_text TEXT NOT NULL,
    molecule_type TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE transcript_decay_observations (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    expression_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE sample_metadata (
    sample_id TEXT PRIMARY KEY,
    sample_group TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE expression_observations (
    observation_id INTEGER PRIMARY KEY,
    gene_name TEXT NOT NULL,
    sample_id TEXT NOT NULL,
    count_value REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (sample_id) REFERENCES sample_metadata(sample_id)
);

CREATE TABLE codon_counts (
    codon TEXT PRIMARY KEY,
    codon_count INTEGER NOT NULL,
    amino_acid TEXT,
    notes TEXT
);

CREATE TABLE molecular_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    replication_fidelity REAL NOT NULL,
    transcription_signal REAL NOT NULL,
    rna_stability REAL NOT NULL,
    translation_support REAL NOT NULL,
    repair_capacity REAL NOT NULL,
    regulatory_context REAL NOT NULL,
    damage_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    decay_constant REAL,
    half_life_h REAL,
    area_under_curve REAL,
    log2_fc REAL,
    gc_fraction REAL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    codon_fraction REAL,
    molecular_condition_score REAL,
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

INSERT INTO sequence_records
(sample_name, sequence_text, molecule_type, notes)
VALUES
('sample_A', 'ATGCTAGCTAACGGTACCTA', 'DNA', 'Synthetic sequence'),
('sample_B', 'ATGCTGGCTATCGGTACCTA', 'DNA', 'Synthetic sequence'),
('sample_C', 'ATGATGGCTATCGGTTCCTA', 'DNA', 'Synthetic sequence'),
('sample_D', 'ATGCTAGTTAACGGAACCTG', 'DNA', 'Synthetic sequence');

INSERT INTO transcript_decay_observations
(time_h, expression_value, notes)
VALUES
(0, 100, 'Synthetic transcript decay observation'),
(1, 76, 'Synthetic transcript decay observation'),
(2, 59, 'Synthetic transcript decay observation'),
(3, 42, 'Synthetic transcript decay observation'),
(4, 25, 'Synthetic transcript decay observation'),
(5, 19, 'Synthetic transcript decay observation'),
(6, 14, 'Synthetic transcript decay observation');

INSERT INTO sample_metadata
(sample_id, sample_group, notes)
VALUES
('sample_1', 'control', 'Synthetic sample metadata'),
('sample_2', 'control', 'Synthetic sample metadata'),
('sample_3', 'control', 'Synthetic sample metadata'),
('sample_4', 'control', 'Synthetic sample metadata'),
('sample_5', 'treated', 'Synthetic sample metadata'),
('sample_6', 'treated', 'Synthetic sample metadata'),
('sample_7', 'treated', 'Synthetic sample metadata'),
('sample_8', 'treated', 'Synthetic sample metadata');

INSERT INTO expression_observations
(gene_name, sample_id, count_value, notes)
VALUES
('gene_1','sample_1',81,'Synthetic expression observation'),
('gene_1','sample_2',79,'Synthetic expression observation'),
('gene_1','sample_3',84,'Synthetic expression observation'),
('gene_1','sample_4',77,'Synthetic expression observation'),
('gene_1','sample_5',126,'Synthetic expression observation'),
('gene_1','sample_6',124,'Synthetic expression observation'),
('gene_1','sample_7',131,'Synthetic expression observation'),
('gene_1','sample_8',128,'Synthetic expression observation'),
('gene_2','sample_1',90,'Synthetic expression observation'),
('gene_2','sample_2',86,'Synthetic expression observation'),
('gene_2','sample_3',88,'Synthetic expression observation'),
('gene_2','sample_4',91,'Synthetic expression observation'),
('gene_2','sample_5',137,'Synthetic expression observation'),
('gene_2','sample_6',134,'Synthetic expression observation'),
('gene_2','sample_7',130,'Synthetic expression observation'),
('gene_2','sample_8',132,'Synthetic expression observation'),
('gene_3','sample_1',73,'Synthetic expression observation'),
('gene_3','sample_2',78,'Synthetic expression observation'),
('gene_3','sample_3',75,'Synthetic expression observation'),
('gene_3','sample_4',80,'Synthetic expression observation'),
('gene_3','sample_5',113,'Synthetic expression observation'),
('gene_3','sample_6',119,'Synthetic expression observation'),
('gene_3','sample_7',116,'Synthetic expression observation'),
('gene_3','sample_8',118,'Synthetic expression observation'),
('gene_4','sample_1',110,'Synthetic expression observation'),
('gene_4','sample_2',107,'Synthetic expression observation'),
('gene_4','sample_3',112,'Synthetic expression observation'),
('gene_4','sample_4',109,'Synthetic expression observation'),
('gene_4','sample_5',75,'Synthetic expression observation'),
('gene_4','sample_6',79,'Synthetic expression observation'),
('gene_4','sample_7',78,'Synthetic expression observation'),
('gene_4','sample_8',76,'Synthetic expression observation');

INSERT INTO codon_counts
(codon, codon_count, amino_acid, notes)
VALUES
('ATG', 1, 'M', 'Synthetic codon count'),
('GCC', 2, 'A', 'Synthetic codon count'),
('GAA', 1, 'E', 'Synthetic codon count'),
('CTG', 1, 'L', 'Synthetic codon count'),
('ATC', 1, 'I', 'Synthetic codon count'),
('GTC', 1, 'V', 'Synthetic codon count'),
('AAG', 1, 'K', 'Synthetic codon count'),
('GGT', 1, 'G', 'Synthetic codon count'),
('AAA', 1, 'K', 'Synthetic codon count'),
('CCC', 1, 'P', 'Synthetic codon count'),
('GGG', 1, 'G', 'Synthetic codon count'),
('TTT', 1, 'F', 'Synthetic codon count'),
('TAA', 1, '*', 'Synthetic stop codon count');

INSERT INTO molecular_condition_sites
(site_name, replication_fidelity, transcription_signal, rna_stability, translation_support, repair_capacity, regulatory_context, damage_risk, notes)
VALUES
('reference_cell_state',0.86,0.72,0.70,0.78,0.82,0.74,0.18,'Synthetic molecular condition site'),
('stress_response_state',0.70,0.88,0.46,0.66,0.64,0.82,0.38,'Synthetic molecular condition site'),
('damage_repair_deficient',0.42,0.58,0.54,0.61,0.28,0.50,0.77,'Synthetic molecular condition site'),
('high_expression_program',0.74,0.92,0.69,0.84,0.66,0.79,0.29,'Synthetic molecular condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence distance and Jukes-Cantor correction', 'MIT-compatible example data', 'sequence comparison setup', 'Not real sequence data'),
('transcript_decay.csv', 'synthetic_example', 'constructed_example', 'transcript decay fitting and AUC', 'MIT-compatible example data', 'transcript kinetics setup', 'Not real transcript abundance data'),
('expression_matrix.csv', 'synthetic_example', 'constructed_example', 'log2 fold change and PCA-style ordination', 'MIT-compatible example data', 'expression matrix setup', 'Not real expression data'),
('coding_sequence.txt', 'synthetic_example', 'constructed_example', 'codon usage, translation, and GC fraction', 'MIT-compatible example data', 'coding-sequence setup', 'Not a real annotated coding sequence');
