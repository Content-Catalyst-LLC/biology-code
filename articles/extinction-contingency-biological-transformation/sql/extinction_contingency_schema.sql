-- Extinction, contingency, and biological transformation reproducibility schema.
--
-- This schema tracks clade survivorship, extinction hazards, recovery
-- scenarios, trait-risk data, phylogenetic-loss data, condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS clade_survivorship;
DROP TABLE IF EXISTS hazard_scenarios;
DROP TABLE IF EXISTS recovery_scenarios;
DROP TABLE IF EXISTS trait_risk_taxa;
DROP TABLE IF EXISTS phylogenetic_loss;
DROP TABLE IF EXISTS extinction_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE clade_survivorship (
    clade_id INTEGER PRIMARY KEY,
    clade_name TEXT NOT NULL UNIQUE,
    initial_lineages REAL NOT NULL,
    surviving_lineages REAL NOT NULL,
    notes TEXT
);

CREATE TABLE hazard_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    extinction_hazard REAL NOT NULL,
    time_horizon REAL NOT NULL,
    notes TEXT
);

CREATE TABLE recovery_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_richness REAL NOT NULL,
    recovery_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    time_horizon REAL NOT NULL,
    notes TEXT
);

CREATE TABLE trait_risk_taxa (
    taxon_id INTEGER PRIMARY KEY,
    taxon_name TEXT NOT NULL UNIQUE,
    range_size REAL NOT NULL,
    trophic_flexibility REAL NOT NULL,
    habitat_dependence REAL NOT NULL,
    notes TEXT
);

CREATE TABLE phylogenetic_loss (
    lineage_id INTEGER PRIMARY KEY,
    lineage_name TEXT NOT NULL UNIQUE,
    branch_length REAL NOT NULL,
    status TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE extinction_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    lineage_irreplaceability REAL NOT NULL,
    range_contraction REAL NOT NULL,
    habitat_fragmentation REAL NOT NULL,
    functional_uniqueness REAL NOT NULL,
    recovery_potential REAL NOT NULL,
    monitoring_confidence REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    survivorship REAL,
    extinction REAL,
    loss_count REAL,
    final_richness REAL,
    risk_index REAL,
    phylogenetic_loss_fraction REAL,
    condition_score REAL,
    risk_or_condition_class TEXT,
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

INSERT INTO clade_survivorship
(clade_name, initial_lineages, surviving_lineages, notes)
VALUES
('clade_A', 120, 30, 'Synthetic crisis survivorship example'),
('clade_B', 80, 40, 'Synthetic crisis survivorship example'),
('clade_C', 50, 10, 'Synthetic crisis survivorship example'),
('clade_D', 200, 110, 'Synthetic crisis survivorship example'),
('clade_E', 65, 12, 'Synthetic crisis survivorship example');

INSERT INTO hazard_scenarios
(scenario_name, extinction_hazard, time_horizon, notes)
VALUES
('background', 0.05, 10, 'Synthetic background hazard'),
('elevated_crisis', 0.18, 10, 'Synthetic elevated crisis hazard'),
('severe_crisis', 0.35, 10, 'Synthetic severe crisis hazard'),
('prolonged_disturbance', 0.12, 20, 'Synthetic prolonged disturbance hazard');

INSERT INTO recovery_scenarios
(scenario_name, initial_richness, recovery_rate, carrying_capacity, time_horizon, notes)
VALUES
('slow_recovery', 5, 0.08, 40, 30, 'Synthetic slow recovery scenario'),
('moderate_recovery', 5, 0.14, 60, 30, 'Synthetic moderate recovery scenario'),
('rapid_recovery', 5, 0.22, 80, 30, 'Synthetic rapid recovery scenario'),
('low_ceiling_recovery', 5, 0.14, 35, 30, 'Synthetic low carrying-capacity recovery scenario');

INSERT INTO trait_risk_taxa
(taxon_name, range_size, trophic_flexibility, habitat_dependence, notes)
VALUES
('taxon_1', 0.9, 0.8, 0.2, 'Synthetic trait-risk example'),
('taxon_2', 0.3, 0.2, 0.8, 'Synthetic trait-risk example'),
('taxon_3', 0.2, 0.4, 0.9, 'Synthetic trait-risk example'),
('taxon_4', 0.7, 0.7, 0.3, 'Synthetic trait-risk example'),
('taxon_5', 0.4, 0.5, 0.6, 'Synthetic trait-risk example');

INSERT INTO phylogenetic_loss
(lineage_name, branch_length, status, notes)
VALUES
('A', 12.0, 'survived', 'Synthetic branch-length example'),
('B', 8.0, 'extinct', 'Synthetic branch-length example'),
('C', 15.0, 'extinct', 'Synthetic branch-length example'),
('D', 5.0, 'survived', 'Synthetic branch-length example'),
('E', 20.0, 'extinct', 'Synthetic branch-length example'),
('F', 9.0, 'survived', 'Synthetic branch-length example');

INSERT INTO extinction_condition_sites
(site_name, lineage_irreplaceability, range_contraction, habitat_fragmentation, functional_uniqueness, recovery_potential, monitoring_confidence, notes)
VALUES
('reference_refugium', 0.70, 0.22, 0.18, 0.64, 0.76, 0.82, 'Synthetic condition site'),
('fragmented_endemism_zone', 0.88, 0.71, 0.76, 0.81, 0.34, 0.61, 'Synthetic condition site'),
('degraded_freshwater_basin', 0.76, 0.63, 0.69, 0.72, 0.42, 0.58, 'Synthetic condition site'),
('recovering_landscape', 0.54, 0.36, 0.41, 0.50, 0.68, 0.74, 'Synthetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('clade_survivorship.csv', 'synthetic_example', 'constructed_example', 'survivorship and extinction proportions', 'MIT-compatible example data', 'clade loss setup', 'Not real fossil or clade data'),
('hazard_scenarios.csv', 'synthetic_example', 'constructed_example', 'exponential survivorship hazards', 'MIT-compatible example data', 'hazard scenario setup', 'Not real extinction-rate data'),
('recovery_scenarios.csv', 'synthetic_example', 'constructed_example', 'logistic post-crisis recovery', 'MIT-compatible example data', 'recovery scenario setup', 'Not real recovery data'),
('trait_risk_taxa.csv', 'synthetic_example', 'constructed_example', 'trait-dependent risk screening', 'MIT-compatible example data', 'risk scenario setup', 'Not real conservation data'),
('phylogenetic_loss.csv', 'synthetic_example', 'constructed_example', 'branch-length loss fraction', 'MIT-compatible example data', 'phylogenetic loss setup', 'Not real phylogenetic data');
