-- Genomics, sequence analysis, and biological data schema.

DROP TABLE IF EXISTS sequence_records;
DROP TABLE IF EXISTS sequence_metadata;
DROP TABLE IF EXISTS fastq_reads;
DROP TABLE IF EXISTS variants;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_records;
DROP TABLE IF EXISTS validation_checks;

CREATE TABLE sequence_records (
    sequence_id TEXT PRIMARY KEY,
    sequence_text TEXT NOT NULL,
    sequence_length INTEGER NOT NULL,
    gc_content REAL,
    ambiguous_bases INTEGER NOT NULL
);

CREATE TABLE sequence_metadata (
    sequence_id TEXT PRIMARY KEY,
    organism TEXT NOT NULL,
    source TEXT NOT NULL,
    condition TEXT NOT NULL,
    batch TEXT NOT NULL,
    qc_flag TEXT NOT NULL CHECK (qc_flag IN ('pass', 'review', 'fail')),
    notes TEXT
);

CREATE TABLE fastq_reads (
    read_id TEXT PRIMARY KEY,
    sequence_text TEXT NOT NULL,
    quality_text TEXT NOT NULL,
    read_length INTEGER NOT NULL,
    mean_phred REAL,
    ambiguous_bases INTEGER
);

CREATE TABLE variants (
    variant_id TEXT PRIMARY KEY,
    chromosome TEXT NOT NULL,
    position INTEGER NOT NULL CHECK (position > 0),
    reference TEXT NOT NULL,
    alternate TEXT NOT NULL,
    read_depth INTEGER NOT NULL CHECK (read_depth >= 0),
    alternate_depth INTEGER NOT NULL CHECK (alternate_depth >= 0),
    quality REAL,
    reference_version TEXT NOT NULL
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

CREATE TABLE provenance_records (
    provenance_id INTEGER PRIMARY KEY,
    operation TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    script TEXT NOT NULL,
    notes TEXT,
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE validation_checks (
    check_id INTEGER PRIMARY KEY,
    check_name TEXT NOT NULL,
    passed INTEGER NOT NULL,
    details TEXT,
    checked_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO sequence_records
(sequence_id, sequence_text, sequence_length, gc_content, ambiguous_bases)
VALUES
('sample_01','ATGCGCGTAATTAACCGGTTACCGTAGCTATAA',35,0.48571,0),
('sample_02','ATATATGGCCNNATGCGTAACCGGTTAACTATAG',36,0.47059,2),
('sample_03','GCGCGCGCTTATATATACCGGTTAACCGGTATGA',36,0.55556,0),
('sample_04','CCCATGAAACCCGGGTAGCCCATGTTTTAA',31,0.48387,0);

INSERT INTO sequence_metadata
(sequence_id, organism, source, condition, batch, qc_flag, notes)
VALUES
('sample_01','model_species','tissue','control','batch_01','pass','Synthetic sequence record'),
('sample_02','model_species','tissue','treated','batch_01','review','Contains ambiguous bases'),
('sample_03','microbial_model','environmental_sample','treated','batch_02','pass','Synthetic sequence record'),
('sample_04','model_species','coding_region','control','batch_02','pass','Synthetic coding-like sequence');

INSERT INTO fastq_reads
(read_id, sequence_text, quality_text, read_length, mean_phred, ambiguous_bases)
VALUES
('read_01','ATGCGCGTAATTAACC','IIIIIIIIIIIIIIII',16,40.0,0),
('read_02','ATATATGGCCNNATGC','IIIIIIIII###IIII',16,33.4375,2),
('read_03','GCGCGCGCTTATATAT','HHHHHHHHHHHHHHHH',16,39.0,0);

INSERT INTO variants
(variant_id, chromosome, position, reference, alternate, read_depth, alternate_depth, quality, reference_version)
VALUES
('var_001','chr1',1050,'A','G',42,18,61.5,'synthetic_ref_v1'),
('var_002','chr1',1088,'G','A',31,3,22.0,'synthetic_ref_v1'),
('var_003','chr2',2201,'T','C',8,4,18.2,'synthetic_ref_v1'),
('var_004','chr2',2310,'C','T',56,49,70.1,'synthetic_ref_v1');

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'sequence_summary','sequences.fasta','python/01_sequence_summary.py','outputs/tables/sequence_summary.csv','Summarize sequence length GC content and ambiguous bases'),
(2,'kmer_counting','sequences.fasta','python/02_kmer_counting.py','outputs/tables/kmer_counts.csv','Count valid DNA k-mers'),
(3,'orf_detection','sequences.fasta','python/03_orf_detection.py','outputs/tables/orf_summary.csv','Find simple forward-strand ORFs'),
(4,'translation_scaffold','sequences.fasta','python/04_translation_scaffold.py','outputs/tables/translation_summary.csv','Translate detected simple ORFs'),
(5,'fastq_quality_summary','reads.fastq','python/05_fastq_quality_summary.py','outputs/tables/fastq_quality_summary.csv','Summarize FASTQ-style quality scores'),
(6,'variant_validation','variants.csv','python/06_variant_validation.py','outputs/tables/variant_validation.csv','Validate variant table and calculate VAF'),
(7,'metadata_validation','sequence_metadata.csv','python/07_metadata_validation.py','outputs/tables/metadata_validation.csv','Validate sequence metadata against FASTA IDs'),
(8,'workflow_manifest','workflow_steps.csv','python/08_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record workflow artifacts and checksums'),
(9,'generate_report','sequence_summary.csv;variant_validation.csv','python/09_generate_report.py','outputs/reports/genomics_sequence_report.md','Generate reproducible report');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('sequences.fasta','input','archived',NULL,'Synthetic sequence records'),
('sequence_metadata.csv','metadata','archived',NULL,'Synthetic metadata table'),
('reads.fastq','input','archived',NULL,'Synthetic FASTQ-style reads'),
('variants.csv','input','archived',NULL,'Synthetic variant table'),
('sequence_summary.csv','output','generated',NULL,'Sequence summary output'),
('kmer_counts.csv','output','generated',NULL,'K-mer count table'),
('variant_validation.csv','output','generated',NULL,'Variant validation output');

INSERT INTO provenance_records
(operation, input_artifact, output_artifact, script, notes)
SELECT operation, input_artifact, output_artifact, script, notes
FROM workflow_steps;

INSERT INTO validation_checks
(check_name, passed, details)
VALUES
('sequence_ids_unique',1,'Synthetic sequence identifiers are unique'),
('metadata_qc_flags_valid',1,'QC flags use pass review fail vocabulary'),
('variant_depth_rule_applied',1,'Minimum read-depth threshold applied in workflow');
