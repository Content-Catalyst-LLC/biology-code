-- Ecology and interdependence reproducibility schema.
--
-- This schema tracks sites, species, abundance observations, interactions,
-- ecosystem indicators, network metrics, scenarios, and provenance metadata.

DROP TABLE IF EXISTS sites;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS abundance_observations;
DROP TABLE IF EXISTS interaction_records;
DROP TABLE IF EXISTS ecosystem_indicators;
DROP TABLE IF EXISTS network_metrics;
DROP TABLE IF EXISTS scenario_definitions;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE sites (
    site_id INTEGER PRIMARY KEY,
    site_code TEXT NOT NULL UNIQUE,
    habitat_type TEXT,
    region TEXT,
    notes TEXT
);

CREATE TABLE species (
    species_id INTEGER PRIMARY KEY,
    species_code TEXT NOT NULL UNIQUE,
    trophic_role TEXT,
    functional_group TEXT,
    notes TEXT
);

CREATE TABLE abundance_observations (
    observation_id INTEGER PRIMARY KEY,
    site_code TEXT NOT NULL,
    event_date TEXT NOT NULL,
    observer TEXT,
    method TEXT,
    species_code TEXT NOT NULL,
    count INTEGER NOT NULL,
    uncertainty_notes TEXT,
    FOREIGN KEY (site_code) REFERENCES sites(site_code),
    FOREIGN KEY (species_code) REFERENCES species(species_code)
);

CREATE TABLE interaction_records (
    interaction_id INTEGER PRIMARY KEY,
    source_species TEXT NOT NULL,
    target_species TEXT NOT NULL,
    interaction_type TEXT NOT NULL,
    interaction_strength REAL,
    evidence_level TEXT,
    notes TEXT
);

CREATE TABLE ecosystem_indicators (
    indicator_id INTEGER PRIMARY KEY,
    site_code TEXT NOT NULL,
    productivity REAL,
    nutrient_retention REAL,
    disturbance_pressure REAL,
    connectivity REAL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (site_code) REFERENCES sites(site_code)
);

CREATE TABLE network_metrics (
    metric_id INTEGER PRIMARY KEY,
    network_name TEXT NOT NULL,
    species_count INTEGER NOT NULL,
    link_count INTEGER NOT NULL,
    connectance REAL NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE scenario_definitions (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    disturbance_pressure_change REAL NOT NULL,
    connectivity_change REAL NOT NULL,
    productivity_change REAL NOT NULL,
    nutrient_retention_change REAL NOT NULL,
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

INSERT INTO sites
(site_code, habitat_type, region, notes)
VALUES
('site_A', 'forest_patch', 'example_region', 'Synthetic ecology site A'),
('site_B', 'wetland_complex', 'example_region', 'Synthetic ecology site B'),
('site_C', 'grassland_remnant', 'example_region', 'Synthetic ecology site C'),
('site_D', 'riparian_corridor', 'example_region', 'Synthetic ecology site D'),
('site_E', 'coastal_mosaic', 'example_region', 'Synthetic ecology site E');

INSERT INTO species
(species_code, trophic_role, functional_group, notes)
VALUES
('sp1', 'producer_or_primary_consumer', 'basal_or_herbivore_proxy', 'Synthetic species 1'),
('sp2', 'primary_consumer', 'herbivore_proxy', 'Synthetic species 2'),
('sp3', 'secondary_consumer', 'omnivore_proxy', 'Synthetic species 3'),
('sp4', 'predator', 'carnivore_proxy', 'Synthetic species 4'),
('sp5', 'decomposer_or_detritivore', 'decomposer_proxy', 'Synthetic species 5');

INSERT INTO interaction_records
(source_species, target_species, interaction_type, interaction_strength, evidence_level, notes)
VALUES
('sp1', 'sp2', 'resource_support', 0.30, 'synthetic', 'Producer or basal support link'),
('sp2', 'sp3', 'consumption_link', 0.25, 'synthetic', 'Primary consumer to secondary consumer link'),
('sp3', 'sp4', 'predation_link', 0.20, 'synthetic', 'Secondary consumer to predator link'),
('sp5', 'sp1', 'decomposition_feedback', 0.18, 'synthetic', 'Decomposer feedback to basal production');

INSERT INTO ecosystem_indicators
(site_code, productivity, nutrient_retention, disturbance_pressure, connectivity)
VALUES
('site_A', 0.84, 0.80, 0.18, 0.86),
('site_B', 0.78, 0.74, 0.27, 0.73),
('site_C', 0.62, 0.58, 0.61, 0.41),
('site_D', 0.71, 0.64, 0.44, 0.56),
('site_E', 0.75, 0.70, 0.30, 0.68);

INSERT INTO network_metrics
(network_name, species_count, link_count, connectance)
VALUES
('synthetic_interaction_network', 5, 8, 0.32);

INSERT INTO scenario_definitions
(scenario_name, disturbance_pressure_change, connectivity_change, productivity_change, nutrient_retention_change, notes)
VALUES
('baseline', 0.00, 0.00, 0.00, 0.00, 'Current synthetic condition'),
('disturbance_intensification', 0.15, -0.08, -0.06, -0.04, 'Higher disturbance and lower connectivity'),
('restoration_reconnection', -0.10, 0.15, 0.08, 0.06, 'Connectivity and process restoration'),
('nutrient_disruption', 0.05, -0.03, -0.04, -0.12, 'Reduced nutrient retention');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('community_matrix.csv', 'synthetic_example', 'constructed_example', 'turnover condition and network screening', 'MIT-compatible example data', 'site-by-species abundance matrix and ecosystem indicators', 'Not real ecological monitoring data');
