-- Metabolism, energy, and biological function reproducibility schema.
--
-- This schema tracks growth observations, substrate and biomass observations,
-- respirometry observations, energy budgets, toy flux definitions,
-- metabolic condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS growth_observations;
DROP TABLE IF EXISTS substrate_biomass_observations;
DROP TABLE IF EXISTS respirometry_observations;
DROP TABLE IF EXISTS energy_budget_scenarios;
DROP TABLE IF EXISTS flux_reactions;
DROP TABLE IF EXISTS metabolic_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE growth_observations (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    abundance REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE substrate_biomass_observations (
    experiment_id TEXT PRIMARY KEY,
    biomass_initial_g_L REAL NOT NULL,
    biomass_final_g_L REAL NOT NULL,
    substrate_consumed_g_L REAL NOT NULL,
    product_g_L REAL NOT NULL,
    maintenance_estimate_g_L REAL NOT NULL,
    notes TEXT
);

CREATE TABLE respirometry_observations (
    observation_id INTEGER PRIMARY KEY,
    sample_id TEXT NOT NULL,
    time_min REAL NOT NULL,
    oxygen_mg_L REAL NOT NULL,
    temperature_C REAL NOT NULL,
    notes TEXT
);

CREATE TABLE energy_budget_scenarios (
    scenario_id TEXT PRIMARY KEY,
    substrate_input REAL NOT NULL,
    substrate_to_growth REAL NOT NULL,
    substrate_to_maintenance REAL NOT NULL,
    substrate_to_product REAL NOT NULL,
    substrate_loss REAL NOT NULL,
    notes TEXT
);

CREATE TABLE flux_reactions (
    reaction_id TEXT PRIMARY KEY,
    lower_bound REAL NOT NULL,
    upper_bound REAL NOT NULL,
    objective_weight REAL NOT NULL,
    notes TEXT
);

CREATE TABLE metabolic_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    substrate_availability REAL NOT NULL,
    energy_conversion REAL NOT NULL,
    redox_balance REAL NOT NULL,
    growth_capacity REAL NOT NULL,
    maintenance_resilience REAL NOT NULL,
    pathway_integration REAL NOT NULL,
    stress_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    growth_rate_per_h REAL,
    doubling_time_h REAL,
    biomass_yield_g_g REAL,
    maintenance_fraction REAL,
    oxygen_consumption_mg_L_min REAL,
    pathway_flux REAL,
    objective_value REAL,
    metabolic_condition_score REAL,
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

INSERT INTO growth_observations
(time_h, abundance, condition_name, notes)
VALUES
(0,100000,'control','Synthetic growth observation'),
(12,140000,'control','Synthetic growth observation'),
(24,200000,'control','Synthetic growth observation'),
(36,280000,'control','Synthetic growth observation'),
(48,400000,'control','Synthetic growth observation'),
(0,100000,'stressed','Synthetic growth observation'),
(12,126000,'stressed','Synthetic growth observation'),
(24,158000,'stressed','Synthetic growth observation'),
(36,198000,'stressed','Synthetic growth observation'),
(48,250000,'stressed','Synthetic growth observation');

INSERT INTO substrate_biomass_observations
(experiment_id, biomass_initial_g_L, biomass_final_g_L, substrate_consumed_g_L, product_g_L, maintenance_estimate_g_L, notes)
VALUES
('culture_A',0.20,0.95,1.50,0.20,0.35,'Synthetic substrate-biomass observation'),
('culture_B',0.25,0.85,1.65,0.35,0.50,'Synthetic substrate-biomass observation'),
('culture_C',0.18,1.05,1.80,0.25,0.45,'Synthetic substrate-biomass observation'),
('stress_D',0.20,0.62,1.60,0.18,0.72,'Synthetic substrate-biomass observation');

INSERT INTO respirometry_observations
(sample_id, time_min, oxygen_mg_L, temperature_C, notes)
VALUES
('control_1',0,8.80,20,'Synthetic respirometry observation'),
('control_1',10,8.35,20,'Synthetic respirometry observation'),
('control_1',20,7.92,20,'Synthetic respirometry observation'),
('control_1',30,7.50,20,'Synthetic respirometry observation'),
('stress_1',0,8.80,20,'Synthetic respirometry observation'),
('stress_1',10,8.52,20,'Synthetic respirometry observation'),
('stress_1',20,8.25,20,'Synthetic respirometry observation'),
('stress_1',30,7.98,20,'Synthetic respirometry observation');

INSERT INTO energy_budget_scenarios
(scenario_id, substrate_input, substrate_to_growth, substrate_to_maintenance, substrate_to_product, substrate_loss, notes)
VALUES
('control',2.00,0.90,0.70,0.25,0.15,'Synthetic energy budget'),
('stress',2.00,0.55,1.05,0.15,0.25,'Synthetic energy budget'),
('high_product',2.00,0.65,0.55,0.65,0.15,'Synthetic energy budget');

INSERT INTO flux_reactions
(reaction_id, lower_bound, upper_bound, objective_weight, notes)
VALUES
('glucose_uptake',10,10,0,'Synthetic toy flux reaction'),
('biomass',0,10,1,'Synthetic toy flux reaction'),
('product',0,10,0.25,'Synthetic toy flux reaction'),
('respiration',0,10,0,'Synthetic toy flux reaction');

INSERT INTO metabolic_condition_sites
(site_name, substrate_availability, energy_conversion, redox_balance, growth_capacity, maintenance_resilience, pathway_integration, stress_penalty, notes)
VALUES
('reference_cell_state',0.84,0.82,0.78,0.80,0.74,0.76,0.18,'Synthetic metabolic condition site'),
('nutrient_limited_state',0.38,0.70,0.66,0.42,0.62,0.58,0.40,'Synthetic metabolic condition site'),
('hypoxic_state',0.72,0.40,0.36,0.46,0.58,0.52,0.62,'Synthetic metabolic condition site'),
('microbial_soil_system',0.78,0.74,0.70,0.72,0.80,0.84,0.26,'Synthetic metabolic condition site'),
('plant_stress_state',0.62,0.68,0.64,0.58,0.76,0.72,0.34,'Synthetic metabolic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('growth_observations.csv', 'synthetic_example', 'constructed_example', 'exponential growth fitting and logistic simulation', 'MIT-compatible example data', 'growth model setup', 'Not real growth data'),
('substrate_biomass.csv', 'synthetic_example', 'constructed_example', 'biomass yield and allocation analysis', 'MIT-compatible example data', 'yield setup', 'Not real substrate data'),
('respirometry.csv', 'synthetic_example', 'constructed_example', 'oxygen-consumption slope estimation', 'MIT-compatible example data', 'respirometry setup', 'Not real respirometry data'),
('energy_budget.csv', 'synthetic_example', 'constructed_example', 'substrate allocation balance', 'MIT-compatible example data', 'energy budget setup', 'Not real energy-budget data'),
('flux_reactions.csv', 'synthetic_example', 'constructed_example', 'toy flux-balance constraints', 'MIT-compatible example data', 'toy flux setup', 'Not genome-scale metabolic model data'),
('metabolic_condition_sites.csv', 'synthetic_example', 'constructed_example', 'metabolic condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
