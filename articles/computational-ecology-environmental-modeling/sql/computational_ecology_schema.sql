-- Computational ecology and environmental modeling schema.

DROP TABLE IF EXISTS sites;
DROP TABLE IF EXISTS environmental_grid;
DROP TABLE IF EXISTS scenarios;
DROP TABLE IF EXISTS validation_observations;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_records;
DROP TABLE IF EXISTS validation_checks;

CREATE TABLE sites (
    site_id TEXT PRIMARY KEY,
    x REAL NOT NULL,
    y REAL NOT NULL,
    temperature_c REAL NOT NULL,
    precipitation_mm REAL NOT NULL,
    habitat_quality REAL NOT NULL CHECK (habitat_quality >= 0 AND habitat_quality <= 1),
    disturbance REAL NOT NULL CHECK (disturbance >= 0 AND disturbance <= 1),
    observed_presence INTEGER NOT NULL CHECK (observed_presence IN (0, 1)),
    observed_abundance REAL NOT NULL
);

CREATE TABLE environmental_grid (
    cell_id TEXT PRIMARY KEY,
    x REAL NOT NULL,
    y REAL NOT NULL,
    precipitation_mm REAL NOT NULL,
    infiltration_fraction REAL NOT NULL CHECK (infiltration_fraction >= 0 AND infiltration_fraction <= 1),
    runoff_coefficient REAL NOT NULL CHECK (runoff_coefficient >= 0 AND runoff_coefficient <= 1),
    land_cover TEXT NOT NULL,
    habitat_quality REAL NOT NULL CHECK (habitat_quality >= 0 AND habitat_quality <= 1)
);

CREATE TABLE scenarios (
    scenario TEXT PRIMARY KEY,
    temperature_anomaly REAL NOT NULL,
    water_deficit REAL NOT NULL CHECK (water_deficit >= 0 AND water_deficit <= 1),
    disturbance REAL NOT NULL CHECK (disturbance >= 0 AND disturbance <= 1),
    habitat_gain REAL NOT NULL CHECK (habitat_gain >= 0 AND habitat_gain <= 1),
    colonization REAL NOT NULL CHECK (colonization >= 0 AND colonization <= 1),
    extinction REAL NOT NULL CHECK (extinction >= 0 AND extinction <= 1),
    initial_occupancy REAL NOT NULL CHECK (initial_occupancy >= 0 AND initial_occupancy <= 1)
);

CREATE TABLE validation_observations (
    site_id TEXT PRIMARY KEY,
    observed_abundance REAL NOT NULL,
    predicted_abundance REAL NOT NULL
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

INSERT INTO sites
(site_id, x, y, temperature_c, precipitation_mm, habitat_quality, disturbance, observed_presence, observed_abundance)
VALUES
('site_A',0,0,16.2,820,0.82,0.18,1,18),
('site_B',1,0,22.5,640,0.64,0.35,1,12),
('site_C',0,1,28.1,410,0.31,0.72,0,4),
('site_D',1,1,19.4,910,0.76,0.21,1,15),
('site_E',2,1,24.8,560,0.48,0.46,1,9),
('site_F',2,2,30.2,380,0.22,0.81,0,2);

INSERT INTO environmental_grid
(cell_id, x, y, precipitation_mm, infiltration_fraction, runoff_coefficient, land_cover, habitat_quality)
VALUES
('cell_01',0,0,42,0.62,0.30,'forest',0.82),
('cell_02',1,0,55,0.48,0.42,'grassland',0.64),
('cell_03',0,1,38,0.72,0.22,'wetland',0.88),
('cell_04',1,1,61,0.35,0.58,'urban_edge',0.31),
('cell_05',2,1,47,0.55,0.36,'shrubland',0.52),
('cell_06',2,2,33,0.41,0.63,'degraded',0.21);

INSERT INTO scenarios
(scenario, temperature_anomaly, water_deficit, disturbance, habitat_gain, colonization, extinction, initial_occupancy)
VALUES
('baseline',0.0,0.15,0.25,0.00,0.12,0.08,0.42),
('warming',2.5,0.25,0.35,0.00,0.10,0.12,0.42),
('drying',1.5,0.45,0.40,0.00,0.08,0.16,0.42),
('restoration',1.5,0.22,0.18,0.20,0.18,0.06,0.42),
('fragmentation',1.0,0.30,0.55,0.00,0.05,0.18,0.42);

INSERT INTO validation_observations
(site_id, observed_abundance, predicted_abundance)
VALUES
('site_A',18,16.5),
('site_B',12,13.1),
('site_C',4,5.2),
('site_D',15,12.7),
('site_E',9,8.4),
('site_F',2,3.6);

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'habitat_suitability','sites.csv','python/01_habitat_suitability.py','outputs/tables/habitat_suitability.csv','Estimate suitability from environmental covariates'),
(2,'patch_occupancy','scenarios.csv','python/02_patch_occupancy.py','outputs/simulations/patch_occupancy.csv','Simulate occupancy dynamics across scenarios'),
(3,'environmental_stress_scenarios','scenarios.csv','python/03_environmental_stress_scenarios.py','outputs/tables/environmental_stress.csv','Compare climate stress and restoration scenarios'),
(4,'runoff_scaffold','environmental_grid.csv','python/04_runoff_scaffold.py','outputs/tables/runoff_scaffold.csv','Calculate simplified runoff by grid cell'),
(5,'validation_metrics','validation_observations.csv','python/05_validation_metrics.py','outputs/tables/validation_metrics.csv','Calculate model validation metrics'),
(6,'workflow_manifest','workflow_steps.csv','python/06_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record workflow artifacts and checksums'),
(7,'generate_report','habitat_suitability.csv;environmental_stress.csv;validation_metrics.csv','python/07_generate_report.py','outputs/reports/computational_ecology_report.md','Generate reproducible modeling report');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('sites.csv','input','archived',NULL,'Synthetic ecological site observations'),
('environmental_grid.csv','input','archived',NULL,'Synthetic environmental grid data'),
('scenarios.csv','input','archived',NULL,'Synthetic environmental scenarios'),
('validation_observations.csv','input','archived',NULL,'Synthetic validation observations'),
('habitat_suitability.csv','output','generated',NULL,'Habitat suitability table'),
('patch_occupancy.csv','output','generated',NULL,'Patch occupancy simulation output'),
('environmental_stress.csv','output','generated',NULL,'Scenario stress table'),
('runoff_scaffold.csv','output','generated',NULL,'Runoff scaffold table'),
('validation_metrics.csv','output','generated',NULL,'Validation metrics table'),
('computational_ecology_report.md','report','generated',NULL,'Generated modeling report');

INSERT INTO provenance_records
(operation, input_artifact, output_artifact, script, notes)
SELECT operation, input_artifact, output_artifact, script, notes
FROM workflow_steps;

INSERT INTO validation_checks
(check_name, passed, details)
VALUES
('site_ids_unique',1,'Synthetic site identifiers are unique'),
('habitat_quality_bounded',1,'Habitat quality values are between zero and one'),
('scenario_rates_bounded',1,'Colonization and extinction rates are between zero and one'),
('runoff_inputs_bounded',1,'Infiltration and runoff coefficients are bounded');
