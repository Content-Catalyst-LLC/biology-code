DROP TABLE IF EXISTS biotechnology_interventions;
DROP TABLE IF EXISTS containment_layers;
DROP TABLE IF EXISTS ecological_release_scenarios;
DROP TABLE IF EXISTS access_equity;
DROP TABLE IF EXISTS governance_notes;
DROP TABLE IF EXISTS provenance_artifacts;

CREATE TABLE biotechnology_interventions (
    intervention TEXT PRIMARY KEY,
    domain TEXT NOT NULL,
    scale TEXT NOT NULL,
    expected_benefit REAL NOT NULL,
    expected_harm REAL NOT NULL,
    uncertainty REAL NOT NULL,
    reversibility REAL NOT NULL,
    access_equity REAL NOT NULL,
    governance_readiness REAL NOT NULL
);

CREATE TABLE containment_layers (
    layer TEXT PRIMARY KEY,
    category TEXT NOT NULL,
    failure_probability REAL NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE ecological_release_scenarios (
    scenario TEXT PRIMARY KEY,
    exposure REAL NOT NULL,
    magnitude REAL NOT NULL,
    uncertainty REAL NOT NULL,
    monitoring_capacity REAL NOT NULL,
    reversibility REAL NOT NULL
);

CREATE TABLE access_equity (
    intervention TEXT PRIMARY KEY,
    nominal_availability REAL NOT NULL,
    inequality_penalty REAL NOT NULL,
    implementation_infrastructure TEXT NOT NULL
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

INSERT INTO biotechnology_interventions VALUES
('somatic_gene_therapy','medicine','individual',0.85,0.20,0.30,0.60,0.35,0.70),
('engineered_microbe_bioremediation','environment','ecosystem',0.70,0.35,0.45,0.40,0.55,0.50),
('gene_drive_vector_control','public_health','population',0.80,0.55,0.70,0.15,0.50,0.35),
('drought_tolerant_crop','agriculture','land_system',0.65,0.25,0.35,0.55,0.45,0.65),
('cellular_immunotherapy','medicine','individual',0.78,0.30,0.35,0.50,0.25,0.75),
('synthetic_biology_biosensor','environment','contained_field_use',0.60,0.20,0.30,0.65,0.60,0.60);

INSERT INTO containment_layers VALUES
('physical_containment','facility',0.010,'Facility and equipment containment layer'),
('procedural_controls','practice',0.020,'Training protocols and standard operating procedures'),
('genetic_safeguard','biological',0.050,'Auxotrophy kill switch or genetic dependency'),
('waste_decontamination','operations',0.015,'Validated decontamination and waste handling'),
('access_control','security',0.010,'Physical and procedural access control'),
('inventory_tracking','governance',0.012,'Material inventory and chain-of-custody tracking');

INSERT INTO ecological_release_scenarios VALUES
('contained_lab',0.10,0.20,0.20,0.90,0.80),
('clinical_somatic',0.25,0.40,0.35,0.80,0.60),
('agricultural_field',0.55,0.55,0.50,0.60,0.45),
('ecological_release',0.85,0.75,0.80,0.40,0.15),
('gene_drive_release',0.95,0.85,0.90,0.35,0.10);

INSERT INTO access_equity VALUES
('somatic_gene_therapy',0.70,0.65,'specialized_clinical_centers'),
('engineered_microbe_bioremediation',0.60,0.35,'environmental_monitoring_capacity'),
('gene_drive_vector_control',0.50,0.40,'public_health_governance'),
('drought_tolerant_crop',0.80,0.45,'seed_systems_and_extension'),
('cellular_immunotherapy',0.65,0.75,'specialized_cell_processing'),
('synthetic_biology_biosensor',0.75,0.30,'field_deployable_monitoring');

INSERT INTO governance_notes (topic, note) VALUES
('biosafety','Containment assumptions require expert review and facility-specific assessment.'),
('biosecurity','Dual-use risk requires access control, screening, training, and responsible governance.'),
('ecological_release','Environmental release requires ecological risk assessment, monitoring, and public accountability.'),
('equity','Access should be treated as part of biotechnology responsibility, not an afterthought.');

INSERT INTO provenance_artifacts (artifact_name, artifact_type, relative_path, checksum_sha256, notes) VALUES
('biotechnology_interventions.csv','synthetic_data','data/biotechnology_interventions.csv',NULL,'Synthetic intervention scenario data'),
('containment_layers.csv','synthetic_data','data/containment_layers.csv',NULL,'Synthetic containment-layer data'),
('ecological_release_scenarios.csv','synthetic_data','data/ecological_release_scenarios.csv',NULL,'Synthetic ecological release scenario data'),
('access_equity.csv','synthetic_data','data/access_equity.csv',NULL,'Synthetic access-equity data');
