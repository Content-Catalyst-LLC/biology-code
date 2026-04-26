-- Plant biology reproducibility schema.
--
-- This schema tracks productivity sites, light-response scenarios, biomass
-- recovery scenarios, plant condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS productivity_sites;
DROP TABLE IF EXISTS light_response_scenarios;
DROP TABLE IF EXISTS biomass_recovery_scenarios;
DROP TABLE IF EXISTS plant_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE productivity_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    gross_primary_productivity REAL NOT NULL,
    autotrophic_respiration REAL NOT NULL,
    heterotrophic_respiration REAL NOT NULL,
    notes TEXT
);

CREATE TABLE light_response_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    alpha REAL NOT NULL,
    amax REAL NOT NULL,
    dark_respiration REAL NOT NULL,
    notes TEXT
);

CREATE TABLE biomass_recovery_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_biomass REAL NOT NULL,
    regrowth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    mortality_rate REAL NOT NULL,
    pulse_day REAL,
    pulse_size REAL NOT NULL,
    notes TEXT
);

CREATE TABLE plant_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    canopy_condition REAL NOT NULL,
    water_availability REAL NOT NULL,
    nutrient_status REAL NOT NULL,
    soil_function REAL NOT NULL,
    disease_pressure REAL NOT NULL,
    drought_stress REAL NOT NULL,
    regeneration_support REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    net_primary_productivity REAL,
    net_ecosystem_productivity REAL,
    max_assimilation REAL,
    final_biomass REAL,
    condition_score REAL,
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

INSERT INTO productivity_sites
(site_name, gross_primary_productivity, autotrophic_respiration, heterotrophic_respiration, notes)
VALUES
('temperate_forest', 2200, 900, 700, 'Synthetic productivity site'),
('grassland', 1450, 600, 500, 'Synthetic productivity site'),
('wetland', 1800, 760, 680, 'Synthetic productivity site'),
('restoration_site', 1300, 620, 710, 'Synthetic productivity site');

INSERT INTO light_response_scenarios
(scenario_name, alpha, amax, dark_respiration, notes)
VALUES
('well_watered', 0.055, 20, 1.5, 'Synthetic well-watered scenario'),
('moderate_drought', 0.045, 15, 1.8, 'Synthetic moderate drought scenario'),
('severe_drought', 0.030, 9, 2.2, 'Synthetic severe drought scenario'),
('nutrient_limited', 0.040, 13, 1.7, 'Synthetic nutrient limitation scenario');

INSERT INTO biomass_recovery_scenarios
(scenario_name, initial_biomass, regrowth_rate, carrying_capacity, mortality_rate, pulse_day, pulse_size, notes)
VALUES
('unassisted_recovery', 40, 0.008, 180, 0.003, NULL, 0, 'Unassisted recovery scenario'),
('soil_repair', 40, 0.010, 220, 0.0025, NULL, 0, 'Soil repair scenario'),
('replanting', 40, 0.010, 220, 0.0025, 30, 15, 'Replanting pulse scenario'),
('replanting_plus_hydrology_repair', 40, 0.013, 280, 0.0020, 30, 20, 'Replanting and hydrology repair scenario');

INSERT INTO plant_condition_sites
(site_name, canopy_condition, water_availability, nutrient_status, soil_function, disease_pressure, drought_stress, regeneration_support, notes)
VALUES
('reference_forest', 0.86, 0.78, 0.74, 0.82, 0.10, 0.18, 0.80, 'Synthetic condition site'),
('restoration_plot', 0.62, 0.56, 0.59, 0.54, 0.17, 0.35, 0.61, 'Synthetic condition site'),
('drought_stressed_woodland', 0.48, 0.32, 0.50, 0.46, 0.22, 0.68, 0.39, 'Synthetic condition site'),
('riparian_repair_site', 0.70, 0.74, 0.64, 0.68, 0.14, 0.28, 0.72, 'Synthetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('productivity_sites.csv', 'synthetic_example', 'constructed_example', 'carbon balance accounting', 'MIT-compatible example data', 'NPP and NEP scenario setup', 'Not real productivity data'),
('light_response_scenarios.csv', 'synthetic_example', 'constructed_example', 'light-response screening', 'MIT-compatible example data', 'canopy physiology scenario setup', 'Not real plant physiology data'),
('biomass_recovery_scenarios.csv', 'synthetic_example', 'constructed_example', 'biomass recovery model', 'MIT-compatible example data', 'recovery scenario setup', 'Not real restoration data'),
('plant_condition_sites.csv', 'synthetic_example', 'constructed_example', 'condition scoring', 'MIT-compatible example data', 'plant condition scoring setup', 'Not real monitoring data');
