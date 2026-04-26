-- Water, energy, and material conditions reproducibility schema.
--
-- This schema tracks solute conditions, water-potential scenarios,
-- homeostasis scenarios, growth observations, oxygen scenarios,
-- energy budgets, material-condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS solute_conditions;
DROP TABLE IF EXISTS water_potential_scenarios;
DROP TABLE IF EXISTS homeostasis_scenarios;
DROP TABLE IF EXISTS growth_observations;
DROP TABLE IF EXISTS oxygen_scenarios;
DROP TABLE IF EXISTS energy_budget_scenarios;
DROP TABLE IF EXISTS material_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE solute_conditions (
    scenario_id TEXT PRIMARY KEY,
    van_t_hoff_factor REAL NOT NULL,
    concentration_mol_L REAL NOT NULL,
    temperature_K REAL NOT NULL,
    notes TEXT
);

CREATE TABLE water_potential_scenarios (
    scenario_id TEXT PRIMARY KEY,
    solute_potential_MPa REAL NOT NULL,
    pressure_potential_MPa REAL NOT NULL,
    gravitational_potential_MPa REAL NOT NULL,
    matric_potential_MPa REAL NOT NULL,
    notes TEXT
);

CREATE TABLE homeostasis_scenarios (
    scenario_id TEXT PRIMARY KEY,
    initial_value REAL NOT NULL,
    setpoint REAL NOT NULL,
    correction_rate REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE growth_observations (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    abundance REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE oxygen_scenarios (
    scenario_id TEXT PRIMARY KEY,
    oxygen_mg_L REAL NOT NULL,
    half_saturation_mg_L REAL NOT NULL,
    max_relative_energy_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE energy_budget_scenarios (
    scenario_id TEXT PRIMARY KEY,
    energy_input REAL NOT NULL,
    energy_growth REAL NOT NULL,
    energy_maintenance REAL NOT NULL,
    energy_repair REAL NOT NULL,
    energy_loss REAL NOT NULL,
    notes TEXT
);

CREATE TABLE material_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    water_availability REAL NOT NULL,
    osmotic_stability REAL NOT NULL,
    energy_availability REAL NOT NULL,
    oxygen_support REAL NOT NULL,
    thermal_suitability REAL NOT NULL,
    ph_stability REAL NOT NULL,
    stress_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    osmotic_pressure_atm REAL,
    total_water_potential_MPa REAL,
    final_state REAL,
    final_deviation REAL,
    growth_rate_per_h REAL,
    doubling_time_h REAL,
    relative_energy_rate REAL,
    oxygen_limitation REAL,
    material_condition_score REAL,
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

INSERT INTO solute_conditions
(scenario_id, van_t_hoff_factor, concentration_mol_L, temperature_K, notes)
VALUES
('baseline',1,0.15,298,'Synthetic solute condition'),
('moderate_saline',2,0.30,298,'Synthetic solute condition'),
('high_saline',2,0.60,298,'Synthetic solute condition'),
('dilute',1,0.05,298,'Synthetic solute condition'),
('warm_saline',2,0.30,308,'Synthetic solute condition'),
('cold_saline',2,0.30,278,'Synthetic solute condition');

INSERT INTO water_potential_scenarios
(scenario_id, solute_potential_MPa, pressure_potential_MPa, gravitational_potential_MPa, matric_potential_MPa, notes)
VALUES
('well_watered_leaf',-0.60,0.45,0.01,-0.02,'Synthetic water potential scenario'),
('drought_leaf',-1.40,0.10,0.01,-0.08,'Synthetic water potential scenario'),
('wet_soil',-0.05,0.00,-0.01,-0.03,'Synthetic water potential scenario'),
('dry_soil',-0.35,0.00,-0.01,-0.65,'Synthetic water potential scenario'),
('saline_root_zone',-0.90,0.05,-0.01,-0.12,'Synthetic water potential scenario');

INSERT INTO homeostasis_scenarios
(scenario_id, initial_value, setpoint, correction_rate, time_end, dt, notes)
VALUES
('osmotic_recovery',10,2,0.40,20,0.01,'Synthetic homeostasis scenario'),
('slow_recovery',10,2,0.12,20,0.01,'Synthetic homeostasis scenario'),
('rapid_recovery',10,2,0.85,20,0.01,'Synthetic homeostasis scenario'),
('acid_base_recovery',7.0,7.4,0.30,20,0.01,'Synthetic homeostasis scenario'),
('thermal_recovery',42,37,0.25,20,0.01,'Synthetic homeostasis scenario');

INSERT INTO growth_observations
(time_h, abundance, condition_name, notes)
VALUES
(0,100000,'control','Synthetic growth observation'),
(12,140000,'control','Synthetic growth observation'),
(24,200000,'control','Synthetic growth observation'),
(36,280000,'control','Synthetic growth observation'),
(48,400000,'control','Synthetic growth observation'),
(0,100000,'water_stress','Synthetic growth observation'),
(12,123000,'water_stress','Synthetic growth observation'),
(24,152000,'water_stress','Synthetic growth observation'),
(36,188000,'water_stress','Synthetic growth observation'),
(48,235000,'water_stress','Synthetic growth observation');

INSERT INTO oxygen_scenarios
(scenario_id, oxygen_mg_L, half_saturation_mg_L, max_relative_energy_rate, notes)
VALUES
('anoxic',0.0,2.0,1.0,'Synthetic oxygen scenario'),
('hypoxic',1.0,2.0,1.0,'Synthetic oxygen scenario'),
('moderate',4.0,2.0,1.0,'Synthetic oxygen scenario'),
('oxygenated',8.0,2.0,1.0,'Synthetic oxygen scenario'),
('supersaturated',11.0,2.0,1.0,'Synthetic oxygen scenario');

INSERT INTO energy_budget_scenarios
(scenario_id, energy_input, energy_growth, energy_maintenance, energy_repair, energy_loss, notes)
VALUES
('control',100,42,33,15,10,'Synthetic energy budget'),
('water_stress',100,25,42,23,10,'Synthetic energy budget'),
('hypoxia',100,20,45,25,10,'Synthetic energy budget'),
('recovery',100,32,35,25,8,'Synthetic energy budget');

INSERT INTO material_condition_sites
(site_name, water_availability, osmotic_stability, energy_availability, oxygen_support, thermal_suitability, ph_stability, stress_penalty, notes)
VALUES
('reference_cell_state',0.86,0.82,0.84,0.80,0.78,0.82,0.18,'Synthetic material condition site'),
('dehydration_state',0.34,0.46,0.68,0.78,0.72,0.70,0.58,'Synthetic material condition site'),
('hypoxic_state',0.78,0.74,0.40,0.32,0.70,0.68,0.62,'Synthetic material condition site'),
('marine_acidification_state',0.82,0.70,0.66,0.72,0.68,0.38,0.55,'Synthetic material condition site'),
('thermal_stress_state',0.74,0.70,0.62,0.68,0.30,0.66,0.64,'Synthetic material condition site'),
('plant_drought_state',0.38,0.48,0.58,0.74,0.66,0.70,0.60,'Synthetic material condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('solute_conditions.csv', 'synthetic_example', 'constructed_example', 'osmotic pressure calculation', 'MIT-compatible example data', 'solute setup', 'Not real physiological or marine chemistry data'),
('water_potential_scenarios.csv', 'synthetic_example', 'constructed_example', 'water potential component summation', 'MIT-compatible example data', 'water potential setup', 'Not real soil or plant water data'),
('homeostasis_scenarios.csv', 'synthetic_example', 'constructed_example', 'homeostatic setpoint dynamics', 'MIT-compatible example data', 'homeostasis setup', 'Not real physiological time series'),
('growth_observations.csv', 'synthetic_example', 'constructed_example', 'exponential growth fitting', 'MIT-compatible example data', 'growth setup', 'Not real growth data'),
('oxygen_scenarios.csv', 'synthetic_example', 'constructed_example', 'oxygen-limited energy-rate model', 'MIT-compatible example data', 'oxygen limitation setup', 'Not real oxygen physiology data'),
('energy_budget.csv', 'synthetic_example', 'constructed_example', 'energy allocation balance', 'MIT-compatible example data', 'energy budget setup', 'Not real calorimetry or bioenergetics data'),
('material_condition_sites.csv', 'synthetic_example', 'constructed_example', 'material-condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
