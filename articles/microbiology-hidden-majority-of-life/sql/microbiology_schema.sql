-- Microbiology and the hidden majority of life reproducibility schema.
--
-- This schema tracks growth scenarios, Monod scenarios, community recovery,
-- condition sites, microbial processes, model outputs, and provenance.

DROP TABLE IF EXISTS growth_environments;
DROP TABLE IF EXISTS interventions;
DROP TABLE IF EXISTS monod_scenarios;
DROP TABLE IF EXISTS community_recovery_scenarios;
DROP TABLE IF EXISTS microbial_condition_sites;
DROP TABLE IF EXISTS microbial_processes;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE growth_environments (
    environment_id INTEGER PRIMARY KEY,
    environment_name TEXT NOT NULL UNIQUE,
    temperature REAL NOT NULL,
    ph REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    initial_abundance REAL NOT NULL,
    baseline_growth_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE interventions (
    intervention_id INTEGER PRIMARY KEY,
    treatment_name TEXT NOT NULL UNIQUE,
    temperature REAL NOT NULL,
    ph REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    initial_abundance REAL NOT NULL,
    baseline_growth_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE monod_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_abundance REAL NOT NULL,
    initial_substrate REAL NOT NULL,
    mu_max REAL NOT NULL,
    half_saturation_constant REAL NOT NULL,
    yield_coefficient REAL NOT NULL,
    notes TEXT
);

CREATE TABLE community_recovery_scenarios (
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

CREATE TABLE microbial_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    functional_richness REAL NOT NULL,
    nitrification_potential REAL NOT NULL,
    denitrification_balance REAL NOT NULL,
    pathogen_signal REAL NOT NULL,
    organic_overload REAL NOT NULL,
    notes TEXT
);

CREATE TABLE microbial_processes (
    process_id INTEGER PRIMARY KEY,
    process_name TEXT NOT NULL UNIQUE,
    description TEXT,
    example_context TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    final_abundance REAL,
    remaining_substrate REAL,
    final_biomass REAL,
    condition_index REAL,
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

INSERT INTO growth_environments
(environment_name, temperature, ph, carrying_capacity, initial_abundance, baseline_growth_rate, notes)
VALUES
('reference', 20, 7.0, 100000000, 10000, 0.35, 'Synthetic reference environment'),
('acid_stress', 20, 5.5, 70000000, 10000, 0.35, 'Synthetic acidic stress environment'),
('warm_enriched', 28, 7.2, 150000000, 10000, 0.35, 'Synthetic warm enriched environment'),
('cool_limited', 12, 7.0, 50000000, 10000, 0.35, 'Synthetic cool limited environment');

INSERT INTO interventions
(treatment_name, temperature, ph, carrying_capacity, initial_abundance, baseline_growth_rate, notes)
VALUES
('none', 18, 5.8, 60000000, 10000, 0.35, 'No intervention'),
('carbon_addition', 18, 5.8, 80000000, 10000, 0.35, 'Carbon addition raises capacity'),
('ph_buffer', 18, 6.8, 70000000, 10000, 0.35, 'pH buffer improves growth conditions'),
('combined', 18, 6.8, 100000000, 10000, 0.35, 'Combined carbon and pH treatment');

INSERT INTO monod_scenarios
(scenario_name, initial_abundance, initial_substrate, mu_max, half_saturation_constant, yield_coefficient, notes)
VALUES
('rich_media', 10000, 150, 0.9, 15, 1000000, 'Synthetic rich medium'),
('poor_media', 10000, 50, 0.6, 25, 1000000, 'Synthetic poor medium'),
('stress_condition', 10000, 50, 0.3, 30, 1000000, 'Synthetic stress condition');

INSERT INTO community_recovery_scenarios
(scenario_name, initial_biomass, recovery_rate, carrying_capacity, mortality_rate, pulse_day, pulse_size, notes)
VALUES
('disturbed_no_intervention', 8, 0.05, 60, 0.030, NULL, 0, 'Disturbed system without intervention'),
('carbon_amendment', 8, 0.06, 75, 0.025, NULL, 0, 'Carbon amendment scenario'),
('inoculated', 8, 0.06, 75, 0.025, 14, 5, 'Inoculation pulse scenario'),
('inoculated_plus_habitat_repair', 8, 0.075, 95, 0.018, 14, 8, 'Combined inoculation and habitat repair');

INSERT INTO microbial_condition_sites
(site_name, functional_richness, nitrification_potential, denitrification_balance, pathogen_signal, organic_overload, notes)
VALUES
('reference_wetland', 0.82, 0.74, 0.71, 0.10, 0.18, 'Synthetic reference wetland'),
('restored_marsh', 0.67, 0.58, 0.60, 0.16, 0.25, 'Synthetic restored marsh'),
('eutrophic_pond', 0.39, 0.33, 0.29, 0.31, 0.77, 'Synthetic eutrophic pond'),
('agricultural_drainage', 0.45, 0.49, 0.43, 0.27, 0.61, 'Synthetic agricultural drainage');

INSERT INTO microbial_processes
(process_name, description, example_context)
VALUES
('nitrification', 'oxidation of ammonia to nitrite or nitrate', 'soil water and wastewater systems'),
('denitrification', 'reduction of nitrate toward gaseous nitrogen species', 'wetlands sediments and low oxygen soils'),
('methanogenesis', 'anaerobic methane production', 'wetlands ruminants sediments and digesters'),
('methane_oxidation', 'microbial oxidation of methane', 'soils sediments water columns and interfaces'),
('fermentation', 'anaerobic energy metabolism producing reduced end products', 'guts foods sediments and industrial systems'),
('decomposition', 'microbial breakdown of organic matter', 'soils litter water columns and detrital systems');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('growth_environments.csv', 'synthetic_example', 'constructed_example', 'logistic growth with environmental modifiers', 'MIT-compatible example data', 'growth scenario setup', 'Not real microbial data'),
('monod_scenarios.csv', 'synthetic_example', 'constructed_example', 'Monod substrate-limited growth', 'MIT-compatible example data', 'Monod scenario setup', 'Not real microbial data'),
('community_recovery_scenarios.csv', 'synthetic_example', 'constructed_example', 'community recovery model', 'MIT-compatible example data', 'recovery scenario setup', 'Not real microbial data'),
('microbial_condition_sites.csv', 'synthetic_example', 'constructed_example', 'condition index screening', 'MIT-compatible example data', 'condition index setup', 'Not real microbial data');
