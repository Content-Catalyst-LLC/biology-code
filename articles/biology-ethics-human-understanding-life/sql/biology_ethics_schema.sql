DROP TABLE IF EXISTS biology_ethics_projects;
DROP TABLE IF EXISTS consent_records;
DROP TABLE IF EXISTS justice_benefit;
DROP TABLE IF EXISTS ecological_risk;
DROP TABLE IF EXISTS governance_requirements;
DROP TABLE IF EXISTS governance_notes;
DROP TABLE IF EXISTS provenance_artifacts;

CREATE TABLE biology_ethics_projects (
    project TEXT PRIMARY KEY,
    domain TEXT NOT NULL,
    expected_benefit REAL NOT NULL,
    expected_harm REAL NOT NULL,
    uncertainty REAL NOT NULL,
    consent_quality REAL NOT NULL,
    justice_score REAL NOT NULL,
    reversibility REAL NOT NULL,
    governance_readiness REAL NOT NULL
);

CREATE TABLE consent_records (
    study TEXT PRIMARY KEY,
    elements_required INTEGER NOT NULL,
    elements_understood INTEGER NOT NULL,
    participant_group TEXT NOT NULL,
    plain_language_available INTEGER NOT NULL,
    withdrawal_explained INTEGER NOT NULL
);

CREATE TABLE justice_benefit (
    intervention TEXT PRIMARY KEY,
    expected_benefit REAL NOT NULL,
    inequality_penalty REAL NOT NULL,
    primary_beneficiary TEXT NOT NULL,
    access_constraint TEXT NOT NULL
);

CREATE TABLE ecological_risk (
    project TEXT PRIMARY KEY,
    exposure_probability REAL NOT NULL,
    harm_magnitude REAL NOT NULL,
    uncertainty REAL NOT NULL,
    reversibility REAL NOT NULL,
    monitoring_capacity REAL NOT NULL
);

CREATE TABLE governance_requirements (
    project TEXT PRIMARY KEY,
    requires_irb INTEGER NOT NULL,
    requires_animal_review INTEGER NOT NULL,
    requires_biosafety_review INTEGER NOT NULL,
    requires_community_consultation INTEGER NOT NULL,
    requires_data_governance INTEGER NOT NULL,
    requires_ecological_assessment INTEGER NOT NULL
);

CREATE TABLE governance_notes (
    note_id INTEGER PRIMARY KEY AUTOINCREMENT,
    topic TEXT NOT NULL,
    note TEXT NOT NULL
);

CREATE TABLE provenance_artifacts (
    artifact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    artifact_name TEXT NOT NULL,
    artifact_type TEXT NOT NULL,
    relative_path TEXT NOT NULL,
    checksum_sha256 TEXT,
    notes TEXT
);

INSERT INTO biology_ethics_projects VALUES
('clinical_genomics_study','human_research',0.80,0.25,0.30,0.75,0.60,0.70,0.78),
('animal_model_experiment','animal_research',0.60,0.45,0.35,0.00,0.45,0.30,0.65),
('environmental_biosensor_release','ecological_intervention',0.70,0.40,0.55,0.40,0.50,0.35,0.48),
('biodiversity_data_platform','ecology_data',0.65,0.20,0.25,0.55,0.65,0.80,0.70),
('synthetic_biology_chassis','biotechnology',0.72,0.38,0.50,0.20,0.52,0.45,0.55),
('public_health_surveillance','public_health',0.82,0.30,0.35,0.45,0.58,0.65,0.75);

INSERT INTO consent_records VALUES
('biobank',8,5,'general_patients',1,1),
('clinical_trial',10,8,'patients_with_condition',1,1),
('genomics_platform',9,6,'community_cohort',0,1),
('public_health_surveillance',7,4,'regional_population',0,0),
('environmental_biosensor_release',6,3,'affected_community',0,0);

INSERT INTO justice_benefit VALUES
('gene_therapy',0.88,0.65,'specialized_clinical_patients','high_cost'),
('waterborne_pathogen_surveillance',0.76,0.25,'community_public_health','infrastructure'),
('crop_biodiversity_program',0.70,0.20,'smallholder_farmers','seed_system_access'),
('urban_air_quality_biomonitoring',0.82,0.45,'urban_residents','policy_followthrough'),
('genomic_medicine_platform',0.84,0.55,'clinical_patients','data_access_and_cost');

INSERT INTO ecological_risk VALUES
('contained_lab',0.05,0.20,0.20,0.90,0.85),
('field_biosensor',0.35,0.40,0.45,0.55,0.65),
('engineered_microbe_release',0.75,0.70,0.80,0.20,0.45),
('habitat_restoration',0.20,0.25,0.35,0.70,0.60),
('gene_drive_release',0.90,0.85,0.90,0.10,0.40);

INSERT INTO governance_requirements VALUES
('clinical_genomics_study',1,0,0,0,1,0),
('animal_model_experiment',0,1,1,0,0,0),
('environmental_biosensor_release',0,0,1,1,1,1),
('biodiversity_data_platform',0,0,0,1,1,1),
('synthetic_biology_chassis',0,0,1,0,1,0),
('public_health_surveillance',1,0,0,1,1,0);

INSERT INTO governance_notes (topic, note) VALUES
('human_subjects','Research involving people requires consent, risk review, justice analysis, and independent oversight.'),
('animal_research','Animal research requires replacement, reduction, refinement, welfare monitoring, and scientific validity.'),
('ecology','Ecological interventions require risk assessment, reversibility analysis, monitoring, and community consultation.'),
('data_governance','Biological data can affect individuals, relatives, communities, ecosystems, and future uses.');

INSERT INTO provenance_artifacts (artifact_name, artifact_type, relative_path, checksum_sha256, notes) VALUES
('biology_ethics_projects.csv','synthetic_data','data/biology_ethics_projects.csv',NULL,'Synthetic biology ethics project data'),
('consent_records.csv','synthetic_data','data/consent_records.csv',NULL,'Synthetic consent-completeness data'),
('justice_benefit.csv','synthetic_data','data/justice_benefit.csv',NULL,'Synthetic justice-adjusted benefit data'),
('ecological_risk.csv','synthetic_data','data/ecological_risk.csv',NULL,'Synthetic ecological risk data'),
('governance_requirements.csv','synthetic_data','data/governance_requirements.csv',NULL,'Synthetic governance requirements data');
