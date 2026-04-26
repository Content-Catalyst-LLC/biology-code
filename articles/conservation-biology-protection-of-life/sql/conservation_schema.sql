-- Conservation biology reproducibility schema.
--
-- This schema tracks conservation units, observations, threats, scoring
-- assumptions, and provenance metadata.

DROP TABLE IF EXISTS conservation_units;
DROP TABLE IF EXISTS observation_records;
DROP TABLE IF EXISTS threat_assessments;
DROP TABLE IF EXISTS priority_scores;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE conservation_units (
    unit_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL UNIQUE,
    unit_type TEXT NOT NULL,
    biome TEXT,
    region TEXT,
    notes TEXT
);

CREATE TABLE observation_records (
    observation_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL,
    event_date TEXT NOT NULL,
    observer TEXT,
    method TEXT,
    indicator TEXT NOT NULL,
    value REAL NOT NULL,
    unit_of_measure TEXT,
    FOREIGN KEY (unit_code) REFERENCES conservation_units(unit_code)
);

CREATE TABLE threat_assessments (
    threat_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL,
    threat_type TEXT NOT NULL,
    severity REAL NOT NULL CHECK (severity >= 0 AND severity <= 1),
    scope REAL NOT NULL CHECK (scope >= 0 AND scope <= 1),
    reversibility REAL NOT NULL CHECK (reversibility >= 0 AND reversibility <= 1),
    notes TEXT,
    FOREIGN KEY (unit_code) REFERENCES conservation_units(unit_code)
);

CREATE TABLE priority_scores (
    score_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL,
    model_name TEXT NOT NULL,
    extinction_risk REAL NOT NULL,
    endemism REAL NOT NULL,
    habitat_loss REAL NOT NULL,
    fragmentation REAL NOT NULL,
    recovery_potential REAL NOT NULL,
    cost_index REAL NOT NULL,
    priority_score REAL NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (unit_code) REFERENCES conservation_units(unit_code)
);

CREATE TABLE provenance_records (
    provenance_id INTEGER PRIMARY KEY,
    dataset_name TEXT NOT NULL,
    source_name TEXT NOT NULL,
    collection_method TEXT,
    license TEXT,
    processing_step TEXT,
    uncertainty_notes TEXT,
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO conservation_units
(unit_code, unit_type, biome, region, notes)
VALUES
('A', 'habitat_patch', 'temperate_forest', 'example_region', 'Synthetic conservation unit A'),
('B', 'wetland_complex', 'freshwater_wetland', 'example_region', 'Synthetic conservation unit B'),
('C', 'plant_population', 'grassland', 'example_region', 'Synthetic conservation unit C'),
('D', 'reef_site', 'marine', 'example_region', 'Synthetic conservation unit D'),
('E', 'watershed', 'freshwater', 'example_region', 'Synthetic conservation unit E');

INSERT INTO provenance_records
(dataset_name, source_name, collection_method, license, processing_step, uncertainty_notes)
VALUES
('conservation_units.csv', 'synthetic_example', 'constructed_example', 'MIT-compatible example data', 'normalized indicators to 0-1 scale', 'Not real management data');
