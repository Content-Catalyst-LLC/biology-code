-- Fungi and networks of decomposition and exchange reproducibility schema.
--
-- This schema tracks fungal guilds, decomposition scenarios, restoration
-- condition indicators, mycelial network edges, model outputs, and provenance.

DROP TABLE IF EXISTS fungal_guilds;
DROP TABLE IF EXISTS decomposition_sites;
DROP TABLE IF EXISTS fungal_condition_sites;
DROP TABLE IF EXISTS recovery_scenarios;
DROP TABLE IF EXISTS network_edges;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE fungal_guilds (
    guild_id INTEGER PRIMARY KEY,
    guild_name TEXT NOT NULL UNIQUE,
    functional_description TEXT,
    decomposition_multiplier REAL,
    notes TEXT
);

CREATE TABLE decomposition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    initial_mass REAL NOT NULL,
    baseline_k REAL NOT NULL,
    temperature REAL NOT NULL,
    moisture REAL NOT NULL,
    lignin_n_ratio REAL NOT NULL,
    guild_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE fungal_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    mycorrhizal_richness REAL NOT NULL,
    saprotroph_richness REAL NOT NULL,
    pathogen_relative_abundance REAL NOT NULL,
    soil_organic_carbon REAL NOT NULL,
    aggregate_stability REAL NOT NULL,
    notes TEXT
);

CREATE TABLE recovery_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_biomass REAL NOT NULL,
    recovery_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    mortality_rate REAL NOT NULL,
    pulse_day REAL,
    pulse_size REAL NOT NULL,
    notes TEXT
);

CREATE TABLE network_edges (
    edge_id INTEGER PRIMARY KEY,
    source_node TEXT NOT NULL,
    target_node TEXT NOT NULL,
    edge_weight REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    effective_k REAL,
    remaining_mass REAL,
    carbon_released REAL,
    final_biomass REAL,
    network_efficiency REAL,
    condition_score REAL,
    risk_or_priority_class TEXT,
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

INSERT INTO fungal_guilds
(guild_name, functional_description, decomposition_multiplier, notes)
VALUES
('white_rot', 'lignin-degrading saprotrophic guild proxy', 1.20, 'Synthetic example multiplier'),
('brown_rot', 'cellulose-focused wood-decay guild proxy', 0.95, 'Synthetic example multiplier'),
('mixed_saprotroph', 'mixed decomposer assemblage proxy', 1.00, 'Synthetic example multiplier'),
('disturbance_simplified', 'functionally simplified disturbed fungal assemblage proxy', 0.72, 'Synthetic example multiplier');

INSERT INTO decomposition_sites
(site_name, initial_mass, baseline_k, temperature, moisture, lignin_n_ratio, guild_name, notes)
VALUES
('cool_conifer_forest', 100, 0.07, 9, 0.65, 18, 'white_rot', 'Synthetic cool forest scenario'),
('warm_restoration_site', 100, 0.07, 18, 0.58, 14, 'mixed_saprotroph', 'Synthetic restoration scenario'),
('drought_stressed_woodland', 100, 0.07, 22, 0.25, 20, 'disturbance_simplified', 'Synthetic drought scenario'),
('nutrient_enriched_riparian', 100, 0.07, 16, 0.72, 12, 'white_rot', 'Synthetic riparian scenario');

INSERT INTO fungal_condition_sites
(site_name, mycorrhizal_richness, saprotroph_richness, pathogen_relative_abundance, soil_organic_carbon, aggregate_stability, notes)
VALUES
('reference_forest', 38, 29, 0.08, 5.9, 0.81, 'Synthetic fungal condition site'),
('restored_woodland', 24, 26, 0.14, 4.2, 0.67, 'Synthetic fungal condition site'),
('degraded_field', 8, 14, 0.31, 2.1, 0.39, 'Synthetic fungal condition site'),
('riparian_buffer', 19, 22, 0.18, 3.8, 0.58, 'Synthetic fungal condition site');

INSERT INTO recovery_scenarios
(scenario_name, initial_biomass, recovery_rate, carrying_capacity, mortality_rate, pulse_day, pulse_size, notes)
VALUES
('degraded_soil', 3, 0.035, 45, 0.020, NULL, 0, 'Degraded soil without intervention'),
('mulch_added', 3, 0.045, 60, 0.018, NULL, 0, 'Mulch added scenario'),
('inoculated', 3, 0.045, 60, 0.018, 20, 6, 'Inoculation pulse scenario'),
('inoculated_plus_habitat_repair', 3, 0.055, 78, 0.014, 20, 8, 'Combined inoculation and habitat repair');

INSERT INTO network_edges
(source_node, target_node, edge_weight, notes)
VALUES
('patch_1', 'patch_2', 1, 'Synthetic mycelial transport edge'),
('patch_1', 'patch_3', 2, 'Synthetic mycelial transport edge'),
('patch_2', 'patch_3', 1, 'Synthetic mycelial transport edge'),
('patch_2', 'patch_4', 2, 'Synthetic mycelial transport edge'),
('patch_3', 'patch_4', 1, 'Synthetic mycelial transport edge'),
('patch_3', 'patch_5', 2, 'Synthetic mycelial transport edge'),
('patch_4', 'patch_5', 1, 'Synthetic mycelial transport edge'),
('patch_4', 'patch_6', 2, 'Synthetic mycelial transport edge'),
('patch_5', 'patch_6', 1, 'Synthetic mycelial transport edge');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('decomposition_sites.csv', 'synthetic_example', 'constructed_example', 'environmentally modified decomposition model', 'MIT-compatible example data', 'decomposition scenario setup', 'Not real field data'),
('fungal_condition_sites.csv', 'synthetic_example', 'constructed_example', 'fungal condition scoring', 'MIT-compatible example data', 'condition index setup', 'Not real field data'),
('network_edges.csv', 'synthetic_example', 'constructed_example', 'network efficiency analysis', 'MIT-compatible example data', 'mycelial network edge setup', 'Not real network data');
