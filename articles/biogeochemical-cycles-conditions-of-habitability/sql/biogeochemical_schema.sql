-- Biogeochemical cycles and habitability reproducibility schema.
--
-- This schema tracks reservoirs, fluxes, observations, scenarios, indicator
-- scores, and provenance metadata.

DROP TABLE IF EXISTS reservoirs;
DROP TABLE IF EXISTS flux_records;
DROP TABLE IF EXISTS observation_records;
DROP TABLE IF EXISTS habitability_scores;
DROP TABLE IF EXISTS scenarios;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE reservoirs (
    reservoir_id INTEGER PRIMARY KEY,
    reservoir_name TEXT NOT NULL UNIQUE,
    cycle_name TEXT NOT NULL,
    reservoir_type TEXT,
    notes TEXT
);

CREATE TABLE flux_records (
    flux_id INTEGER PRIMARY KEY,
    source_reservoir TEXT,
    target_reservoir TEXT,
    cycle_name TEXT NOT NULL,
    flux_name TEXT NOT NULL,
    flux_direction TEXT NOT NULL,
    value REAL NOT NULL,
    unit_of_measure TEXT,
    uncertainty_notes TEXT
);

CREATE TABLE observation_records (
    observation_id INTEGER PRIMARY KEY,
    site_id TEXT NOT NULL,
    event_date TEXT NOT NULL,
    observer TEXT,
    method TEXT,
    indicator TEXT NOT NULL,
    value REAL NOT NULL,
    unit_of_measure TEXT
);

CREATE TABLE habitability_scores (
    score_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL,
    model_name TEXT NOT NULL,
    carbon_uptake_capacity REAL NOT NULL,
    water_regulation REAL NOT NULL,
    nitrogen_retention REAL NOT NULL,
    phosphorus_buffering REAL NOT NULL,
    oxygen_stability REAL NOT NULL,
    disturbance_pressure REAL NOT NULL,
    acidification_pressure REAL NOT NULL,
    nutrient_loading REAL NOT NULL,
    habitability_support REAL NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    oxygen_stability_change REAL NOT NULL,
    nutrient_loading_change REAL NOT NULL,
    acidification_pressure_change REAL NOT NULL,
    notes TEXT
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

INSERT INTO reservoirs
(reservoir_name, cycle_name, reservoir_type, notes)
VALUES
('atmosphere', 'carbon', 'active', 'Synthetic atmospheric carbon reservoir'),
('land_biosphere', 'carbon', 'active', 'Synthetic land uptake reservoir'),
('ocean', 'carbon', 'active', 'Synthetic ocean uptake reservoir'),
('coastal_water', 'nitrogen', 'active', 'Synthetic coastal nutrient reservoir'),
('sediments', 'phosphorus', 'slow', 'Synthetic sediment storage reservoir'),
('soil', 'multi_cycle', 'interface', 'Synthetic soil interface reservoir');

INSERT INTO flux_records
(source_reservoir, target_reservoir, cycle_name, flux_name, flux_direction, value, unit_of_measure, uncertainty_notes)
VALUES
('fossil_source', 'atmosphere', 'carbon', 'fossil_emissions', 'input', 10.0, 'carbon_units', 'synthetic example'),
('land_use', 'atmosphere', 'carbon', 'land_use_emissions', 'input', 1.0, 'carbon_units', 'synthetic example'),
('disturbance', 'atmosphere', 'carbon', 'disturbance_release', 'input', 0.5, 'carbon_units', 'synthetic example'),
('atmosphere', 'land_biosphere', 'carbon', 'land_uptake', 'output', 3.0, 'carbon_units', 'synthetic example'),
('atmosphere', 'ocean', 'carbon', 'ocean_uptake', 'output', 2.6, 'carbon_units', 'synthetic example'),
('watershed', 'coastal_water', 'nitrogen', 'reactive_nitrogen_loading', 'input', 1.0, 'nitrogen_units', 'synthetic example');

INSERT INTO scenarios
(scenario_name, oxygen_stability_change, nutrient_loading_change, acidification_pressure_change, notes)
VALUES
('baseline', 0.00, 0.00, 0.00, 'Current synthetic condition'),
('warming_and_nutrient_loading', -0.10, 0.12, 0.05, 'Lower oxygen stability and higher nutrient loading'),
('restoration_buffering', 0.08, -0.10, -0.03, 'Improved retention and lower pressure'),
('acidification_stress', -0.05, 0.04, 0.15, 'Higher acidification pressure');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('habitability_units.csv', 'synthetic_example', 'constructed_example', 'weighted composite scoring', 'MIT-compatible example data', 'normalized indicators to 0-1 scale', 'Not real management data');
