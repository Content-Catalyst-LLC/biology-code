-- Biomes, habitats, and biogeography reproducibility schema.
--
-- This schema tracks biome classes, habitat records, occurrence records,
-- environmental predictors, spatial scenarios, and provenance metadata.

DROP TABLE IF EXISTS biome_classes;
DROP TABLE IF EXISTS habitat_records;
DROP TABLE IF EXISTS occurrence_records;
DROP TABLE IF EXISTS environmental_predictors;
DROP TABLE IF EXISTS spatial_scenarios;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE biome_classes (
    biome_id INTEGER PRIMARY KEY,
    biome_name TEXT NOT NULL UNIQUE,
    realm TEXT NOT NULL,
    defining_gradient TEXT,
    notes TEXT
);

CREATE TABLE habitat_records (
    habitat_id INTEGER PRIMARY KEY,
    habitat_code TEXT NOT NULL UNIQUE,
    biome_name TEXT NOT NULL,
    habitat_type TEXT NOT NULL,
    region TEXT,
    substrate TEXT,
    dominant_disturbance TEXT,
    FOREIGN KEY (biome_name) REFERENCES biome_classes(biome_name)
);

CREATE TABLE occurrence_records (
    occurrence_id INTEGER PRIMARY KEY,
    site_id TEXT NOT NULL,
    species_code TEXT NOT NULL,
    event_date TEXT,
    occurrence INTEGER NOT NULL CHECK (occurrence IN (0, 1)),
    observation_method TEXT,
    uncertainty_notes TEXT
);

CREATE TABLE environmental_predictors (
    predictor_id INTEGER PRIMARY KEY,
    site_id TEXT NOT NULL,
    temperature REAL,
    precipitation REAL,
    soil_quality REAL,
    connectivity REAL,
    disturbance REAL,
    land_use_pressure REAL
);

CREATE TABLE spatial_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    area_multiplier REAL NOT NULL,
    land_use_pressure_change REAL NOT NULL,
    connectivity_change REAL NOT NULL,
    notes TEXT
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

INSERT INTO biome_classes
(biome_name, realm, defining_gradient, notes)
VALUES
('tropical_forest', 'terrestrial', 'precipitation_and_temperature', 'Synthetic biome class'),
('temperate_forest', 'terrestrial', 'seasonal_temperature', 'Synthetic biome class'),
('grassland', 'terrestrial', 'seasonality_and_disturbance', 'Synthetic biome class'),
('desert', 'terrestrial', 'water_limitation', 'Synthetic biome class'),
('wetland', 'freshwater', 'hydroperiod', 'Synthetic biome class'),
('river', 'freshwater', 'flow_regime', 'Synthetic biome class'),
('reef', 'marine', 'light_depth_and_substrate', 'Synthetic biome class'),
('estuary', 'coastal', 'salinity_gradient', 'Synthetic biome class');

INSERT INTO habitat_records
(habitat_code, biome_name, habitat_type, region, substrate, dominant_disturbance)
VALUES
('H1', 'tropical_forest', 'riparian_forest', 'example_region', 'alluvial_soil', 'flood_pulse'),
('H2', 'temperate_forest', 'old_growth_patch', 'example_region', 'loam', 'windthrow'),
('H3', 'grassland', 'fire_maintained_prairie', 'example_region', 'deep_soil', 'fire'),
('H4', 'desert', 'wash_microhabitat', 'example_region', 'sandy_alluvium', 'drought'),
('H5', 'wetland', 'emergent_marsh', 'example_region', 'organic_sediment', 'flooding'),
('H6', 'river', 'coldwater_reach', 'example_region', 'gravel', 'flow_variation'),
('H7', 'reef', 'coral_framework', 'example_region', 'carbonate', 'thermal_stress'),
('H8', 'estuary', 'seagrass_bed', 'example_region', 'soft_sediment', 'nutrient_loading');

INSERT INTO spatial_scenarios
(scenario_name, area_multiplier, land_use_pressure_change, connectivity_change, notes)
VALUES
('baseline', 1.00, 0.00, 0.00, 'Current synthetic condition'),
('fragmentation_30_percent_area_loss', 0.70, 0.10, -0.15, 'Habitat area loss and reduced connectivity'),
('restoration_connectivity_gain', 1.05, -0.10, 0.20, 'Restoration and corridor improvement'),
('land_use_intensification', 0.85, 0.20, -0.10, 'Increased land-use pressure');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, license, processing_step, uncertainty_notes)
VALUES
('habitat_sites.csv', 'synthetic_example', 'constructed_example', 'MIT-compatible example data', 'normalized selected indicators', 'Not real spatial data');
