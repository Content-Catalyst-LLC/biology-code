-- Biosphere life-support reproducibility schema.
--
-- This schema tracks biosphere units, observations, scenarios, indicator scores,
-- and provenance metadata.

DROP TABLE IF EXISTS biosphere_units;
DROP TABLE IF EXISTS biosphere_observations;
DROP TABLE IF EXISTS carbon_scenarios;
DROP TABLE IF EXISTS functional_integrity_scores;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE biosphere_units (
    unit_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL UNIQUE,
    unit_type TEXT NOT NULL,
    biome TEXT,
    region TEXT,
    notes TEXT
);

CREATE TABLE biosphere_observations (
    observation_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL,
    event_date TEXT NOT NULL,
    observer TEXT,
    method TEXT,
    indicator TEXT NOT NULL,
    value REAL NOT NULL,
    unit_of_measure TEXT,
    FOREIGN KEY (unit_code) REFERENCES biosphere_units(unit_code)
);

CREATE TABLE carbon_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    emissions_start REAL NOT NULL,
    emissions_growth REAL NOT NULL,
    land_uptake_mean REAL NOT NULL,
    ocean_uptake_mean REAL NOT NULL,
    disturbance_mean REAL NOT NULL,
    notes TEXT
);

CREATE TABLE functional_integrity_scores (
    score_id INTEGER PRIMARY KEY,
    unit_code TEXT NOT NULL,
    model_name TEXT NOT NULL,
    primary_production REAL NOT NULL,
    water_regulation REAL NOT NULL,
    nutrient_retention REAL NOT NULL,
    habitat_complexity REAL NOT NULL,
    connectivity REAL NOT NULL,
    disturbance_pressure REAL NOT NULL,
    biodiversity_signal REAL NOT NULL,
    functional_integrity REAL NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (unit_code) REFERENCES biosphere_units(unit_code)
);

CREATE TABLE provenance_records (
    provenance_id INTEGER PRIMARY KEY,
    dataset_name TEXT NOT NULL,
    source_name TEXT NOT NULL,
    observation_method TEXT,
    license TEXT,
    processing_step TEXT,
    uncertainty_notes TEXT,
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO biosphere_units
(unit_code, unit_type, biome, region, notes)
VALUES
('A', 'watershed', 'temperate_forest', 'example_region', 'Synthetic biosphere unit A'),
('B', 'wetland_complex', 'freshwater_wetland', 'example_region', 'Synthetic biosphere unit B'),
('C', 'dryland_landscape', 'semi_arid_grassland', 'example_region', 'Synthetic biosphere unit C'),
('D', 'coastal_marine_system', 'marine_coastal', 'example_region', 'Synthetic biosphere unit D'),
('E', 'agroecological_mosaic', 'mixed_land_use', 'example_region', 'Synthetic biosphere unit E');

INSERT INTO carbon_scenarios
(scenario_name, emissions_start, emissions_growth, land_uptake_mean, ocean_uptake_mean, disturbance_mean, notes)
VALUES
('baseline', 11.0, 0.010, 3.2, 2.7, 0.6, 'Current synthetic condition'),
('high_disturbance', 11.0, 0.010, 3.0, 2.6, 1.1, 'Higher disturbance pressure'),
('restoration_gain', 10.5, 0.004, 3.8, 2.8, 0.45, 'Improved land uptake and lower disturbance'),
('ocean_stress', 11.0, 0.010, 3.2, 2.1, 0.7, 'Reduced ocean uptake');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, license, processing_step, uncertainty_notes)
VALUES
('biosphere_units.csv', 'synthetic_example', 'constructed_example', 'MIT-compatible example data', 'normalized indicators to 0-1 scale', 'Not real Earth-system data');
