-- Biodiversity and living-systems structure reproducibility schema.
--
-- This schema tracks sites, species, observations, traits, biodiversity metrics,
-- priority scenarios, and provenance metadata.

DROP TABLE IF EXISTS sites;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS observation_records;
DROP TABLE IF EXISTS species_traits;
DROP TABLE IF EXISTS biodiversity_metrics;
DROP TABLE IF EXISTS priority_scenarios;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE sites (
    site_id INTEGER PRIMARY KEY,
    site_code TEXT NOT NULL UNIQUE,
    habitat_type TEXT,
    region TEXT,
    fragmentation_pressure REAL,
    restoration_potential REAL,
    protection_status TEXT,
    notes TEXT
);

CREATE TABLE species (
    species_id INTEGER PRIMARY KEY,
    species_code TEXT NOT NULL UNIQUE,
    taxonomic_group TEXT,
    functional_role TEXT,
    phylogenetic_group TEXT,
    notes TEXT
);

CREATE TABLE observation_records (
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

CREATE TABLE species_traits (
    trait_id INTEGER PRIMARY KEY,
    species_code TEXT NOT NULL,
    body_size REAL,
    trophic_level REAL,
    dispersal REAL,
    trait_source TEXT,
    FOREIGN KEY (species_code) REFERENCES species(species_code)
);

CREATE TABLE biodiversity_metrics (
    metric_id INTEGER PRIMARY KEY,
    site_code TEXT NOT NULL,
    model_name TEXT NOT NULL,
    richness REAL NOT NULL,
    shannon REAL NOT NULL,
    simpson REAL NOT NULL,
    hill_q1 REAL NOT NULL,
    hill_q2 REAL NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (site_code) REFERENCES sites(site_code)
);

CREATE TABLE priority_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    fragmentation_pressure_change REAL NOT NULL,
    restoration_potential_change REAL NOT NULL,
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
(site_code, habitat_type, region, fragmentation_pressure, restoration_potential, protection_status, notes)
VALUES
('site_A', 'forest_patch', 'example_region', 0.30, 0.62, 'partial', 'Synthetic site A'),
('site_B', 'wetland_complex', 'example_region', 0.55, 0.74, 'none', 'Synthetic site B'),
('site_C', 'grassland_remnant', 'example_region', 0.70, 0.68, 'none', 'Synthetic site C'),
('site_D', 'riparian_corridor', 'example_region', 0.40, 0.80, 'partial', 'Synthetic site D');

INSERT INTO species
(species_code, taxonomic_group, functional_role, phylogenetic_group, notes)
VALUES
('sp1', 'synthetic_taxon', 'herbivore', 'lineage_A', 'Synthetic species 1'),
('sp2', 'synthetic_taxon', 'pollinator', 'lineage_A', 'Synthetic species 2'),
('sp3', 'synthetic_taxon', 'omnivore', 'lineage_B', 'Synthetic species 3'),
('sp4', 'synthetic_taxon', 'predator', 'lineage_C', 'Synthetic species 4'),
('sp5', 'synthetic_taxon', 'decomposer', 'lineage_B', 'Synthetic species 5');

INSERT INTO species_traits
(species_code, body_size, trophic_level, dispersal, trait_source)
VALUES
('sp1', 1.2, 2, 0.5, 'synthetic_example'),
('sp2', 0.8, 2, 0.7, 'synthetic_example'),
('sp3', 2.1, 3, 0.4, 'synthetic_example'),
('sp4', 3.4, 4, 0.3, 'synthetic_example'),
('sp5', 1.7, 3, 0.6, 'synthetic_example');

INSERT INTO priority_scenarios
(scenario_name, fragmentation_pressure_change, restoration_potential_change, notes)
VALUES
('baseline', 0.00, 0.00, 'Current synthetic condition'),
('fragmentation_increase', 0.15, -0.05, 'Higher fragmentation and lower restoration feasibility'),
('connectivity_restoration', -0.10, 0.15, 'Lower fragmentation and higher restoration potential'),
('protection_gain', -0.05, 0.10, 'Improved landscape protection');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('community_matrix.csv', 'synthetic_example', 'constructed_example', 'diversity metrics and turnover', 'MIT-compatible example data', 'site-by-species abundance matrix', 'Not real biodiversity-monitoring data');
