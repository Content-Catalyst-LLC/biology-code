-- Taxonomy reproducibility schema.

DROP TABLE IF EXISTS taxa;
DROP TABLE IF EXISTS aligned_sequences;
DROP TABLE IF EXISTS community_counts;
DROP TABLE IF EXISTS occurrence_records;
DROP TABLE IF EXISTS taxonomic_assignments;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE taxa (
    taxon_id TEXT PRIMARY KEY,
    scientific_name TEXT NOT NULL,
    rank_name TEXT,
    parent_taxon_id TEXT,
    authority TEXT,
    notes TEXT
);

CREATE TABLE aligned_sequences (
    taxon_id TEXT PRIMARY KEY,
    sequence TEXT NOT NULL,
    marker_name TEXT,
    notes TEXT
);

CREATE TABLE community_counts (
    site_id TEXT NOT NULL,
    taxon_id TEXT NOT NULL,
    abundance INTEGER NOT NULL,
    PRIMARY KEY (site_id, taxon_id)
);

CREATE TABLE occurrence_records (
    record_id TEXT PRIMARY KEY,
    taxon_id TEXT NOT NULL,
    decimal_latitude REAL,
    decimal_longitude REAL,
    country TEXT,
    basis_of_record TEXT,
    identification_confidence REAL,
    notes TEXT
);

CREATE TABLE taxonomic_assignments (
    record_id TEXT PRIMARY KEY,
    candidate_taxon TEXT NOT NULL,
    sequence_similarity REAL NOT NULL,
    morphological_support REAL NOT NULL,
    geographic_plausibility REAL NOT NULL,
    phylogenetic_support REAL NOT NULL,
    uncertainty_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    shannon_diversity REAL,
    bray_curtis REAL,
    taxonomic_confidence_score REAL,
    confidence_class TEXT,
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

INSERT INTO taxa
(taxon_id, scientific_name, rank_name, parent_taxon_id, authority, notes)
VALUES
('taxon_A','Taxon alpha','species',NULL,'synthetic','Synthetic taxon'),
('taxon_B','Taxon beta','species',NULL,'synthetic','Synthetic taxon'),
('taxon_C','Taxon gamma','species',NULL,'synthetic','Synthetic taxon'),
('taxon_D','Taxon delta','species',NULL,'synthetic','Synthetic taxon'),
('taxon_E','Taxon epsilon','species',NULL,'synthetic','Synthetic taxon');

INSERT INTO aligned_sequences
(taxon_id, sequence, marker_name, notes)
VALUES
('taxon_A','ATGCTAGCTAAC','toy_marker','Synthetic aligned sequence'),
('taxon_B','ATGCTAGCTATC','toy_marker','Synthetic aligned sequence'),
('taxon_C','ATGCCAGCTATC','toy_marker','Synthetic aligned sequence'),
('taxon_D','TTGCCAGTTATC','toy_marker','Synthetic aligned sequence'),
('taxon_E','TTGCCGGTTATC','toy_marker','Synthetic aligned sequence');

INSERT INTO community_counts
(site_id, taxon_id, abundance)
VALUES
('reef_site','taxon_A',25),('reef_site','taxon_B',18),('reef_site','taxon_C',11),('reef_site','taxon_D',6),('reef_site','taxon_E',3),
('estuary_site','taxon_A',10),('estuary_site','taxon_B',24),('estuary_site','taxon_C',15),('estuary_site','taxon_D',12),('estuary_site','taxon_E',8),
('deep_site','taxon_A',4),('deep_site','taxon_B',8),('deep_site','taxon_C',22),('deep_site','taxon_D',30),('deep_site','taxon_E',18),
('mangrove_site','taxon_A',19),('mangrove_site','taxon_B',16),('mangrove_site','taxon_C',9),('mangrove_site','taxon_D',7),('mangrove_site','taxon_E',5);

INSERT INTO occurrence_records
(record_id, taxon_id, decimal_latitude, decimal_longitude, country, basis_of_record, identification_confidence, notes)
VALUES
('occ_001','taxon_A',25.7617,-80.1918,'United States','human_observation',0.92,'Synthetic occurrence'),
('occ_002','taxon_A',26.1224,-80.1373,'United States','preserved_specimen',0.96,'Synthetic occurrence'),
('occ_003','taxon_B',18.4655,-66.1057,'Puerto Rico','human_observation',0.88,'Synthetic occurrence'),
('occ_004','taxon_C',13.1939,-59.5432,'Barbados','machine_observation',0.74,'Synthetic occurrence'),
('occ_005','taxon_D',17.9712,-76.7936,'Jamaica','preserved_specimen',0.91,'Synthetic occurrence'),
('occ_006','taxon_E',10.6918,-61.2225,'Trinidad and Tobago','material_sample',0.83,'Synthetic occurrence');

INSERT INTO taxonomic_assignments
(record_id, candidate_taxon, sequence_similarity, morphological_support, geographic_plausibility, phylogenetic_support, uncertainty_penalty, notes)
VALUES
('obs_001','Species_A',0.98,0.90,0.88,0.94,0.05,'Synthetic assignment'),
('obs_002','Species_B',0.91,0.65,0.82,0.70,0.20,'Synthetic assignment'),
('obs_003','Species_C',0.84,0.78,0.55,0.62,0.32,'Synthetic assignment'),
('obs_004','Species_D',0.73,0.40,0.30,0.45,0.55,'Synthetic assignment'),
('obs_005','Species_E',0.89,0.72,0.76,0.81,0.18,'Synthetic assignment');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('aligned_sequences.csv','synthetic_example','constructed_example','p-distance and Jukes-Cantor distance','MIT-compatible example data','sequence setup','Not real sequence data'),
('community_counts.csv','synthetic_example','constructed_example','Shannon diversity and Bray-Curtis dissimilarity','MIT-compatible example data','community setup','Not real biodiversity monitoring data'),
('occurrence_records.csv','synthetic_example','constructed_example','occurrence summary','MIT-compatible example data','occurrence setup','Not real GBIF data'),
('taxonomic_assignments.csv','synthetic_example','constructed_example','taxonomic confidence scoring','MIT-compatible example data','assignment setup','Not authoritative taxonomic identification');
