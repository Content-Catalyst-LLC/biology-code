-- Cell theory reproducibility schema.
--
-- This schema tracks cell-count observations, logistic growth scenarios,
-- viability observations, membrane gradients, cell-cycle scenarios,
-- imaging features, cell-condition scores, model outputs, and provenance.

DROP TABLE IF EXISTS cell_counts;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS viability_observations;
DROP TABLE IF EXISTS membrane_gradients;
DROP TABLE IF EXISTS cell_cycle_scenarios;
DROP TABLE IF EXISTS imaging_features;
DROP TABLE IF EXISTS cell_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE cell_counts (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    cells REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE logistic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    initial_count REAL NOT NULL,
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE viability_observations (
    observation_id INTEGER PRIMARY KEY,
    time_h REAL NOT NULL,
    viable_cells REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE membrane_gradients (
    scenario_id TEXT PRIMARY KEY,
    diffusion_coefficient_cm2_s REAL NOT NULL,
    concentration_inside REAL NOT NULL,
    concentration_outside REAL NOT NULL,
    distance_cm REAL NOT NULL,
    notes TEXT
);

CREATE TABLE cell_cycle_scenarios (
    scenario_id TEXT PRIMARY KEY,
    g1_initial REAL NOT NULL,
    s_initial REAL NOT NULL,
    g2m_initial REAL NOT NULL,
    k1 REAL NOT NULL,
    k2 REAL NOT NULL,
    km REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE imaging_features (
    cell_id TEXT PRIMARY KEY,
    condition_name TEXT NOT NULL,
    area_um2 REAL NOT NULL,
    perimeter_um REAL NOT NULL,
    nuclear_area_um2 REAL NOT NULL,
    mean_intensity REAL NOT NULL,
    roundness REAL NOT NULL,
    notes TEXT
);

CREATE TABLE cell_condition_sites (
    condition_id TEXT PRIMARY KEY,
    membrane_integrity REAL NOT NULL,
    metabolic_activity REAL NOT NULL,
    proliferation_capacity REAL NOT NULL,
    genomic_stability REAL NOT NULL,
    organelle_function REAL NOT NULL,
    stress_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    growth_rate_per_h REAL,
    doubling_time_h REAL,
    final_cell_count REAL,
    fraction_of_capacity REAL,
    loss_rate_per_h REAL,
    half_life_h REAL,
    membrane_flux REAL,
    final_g1_fraction REAL,
    final_s_fraction REAL,
    final_g2m_fraction REAL,
    cell_condition_score REAL,
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

INSERT INTO cell_counts
(time_h, cells, condition_name, notes)
VALUES
(0,100000,'control','Synthetic cell-count observation'),
(12,140000,'control','Synthetic cell-count observation'),
(24,200000,'control','Synthetic cell-count observation'),
(36,280000,'control','Synthetic cell-count observation'),
(48,400000,'control','Synthetic cell-count observation'),
(0,100000,'treated','Synthetic cell-count observation'),
(12,126000,'treated','Synthetic cell-count observation'),
(24,158000,'treated','Synthetic cell-count observation'),
(36,198000,'treated','Synthetic cell-count observation'),
(48,249000,'treated','Synthetic cell-count observation'),
(0,100000,'nutrient_limited','Synthetic cell-count observation'),
(12,116000,'nutrient_limited','Synthetic cell-count observation'),
(24,134000,'nutrient_limited','Synthetic cell-count observation'),
(36,156000,'nutrient_limited','Synthetic cell-count observation'),
(48,181000,'nutrient_limited','Synthetic cell-count observation');

INSERT INTO logistic_scenarios
(scenario_id, initial_count, growth_rate, carrying_capacity, time_end, dt, notes)
VALUES
('control',100000,0.035,1000000,96,0.25,'Synthetic logistic growth scenario'),
('treated',100000,0.020,1000000,96,0.25,'Synthetic logistic growth scenario'),
('nutrient_limited',100000,0.015,650000,96,0.25,'Synthetic logistic growth scenario'),
('contact_inhibited',100000,0.030,450000,96,0.25,'Synthetic logistic growth scenario');

INSERT INTO viability_observations
(time_h, viable_cells, condition_name, notes)
VALUES
(0,1000000,'drug_treated','Synthetic viability observation'),
(12,820000,'drug_treated','Synthetic viability observation'),
(24,630000,'drug_treated','Synthetic viability observation'),
(36,460000,'drug_treated','Synthetic viability observation'),
(48,320000,'drug_treated','Synthetic viability observation'),
(0,1000000,'hypoxic','Synthetic viability observation'),
(12,880000,'hypoxic','Synthetic viability observation'),
(24,760000,'hypoxic','Synthetic viability observation'),
(36,610000,'hypoxic','Synthetic viability observation'),
(48,500000,'hypoxic','Synthetic viability observation'),
(0,1000000,'control','Synthetic viability observation'),
(12,970000,'control','Synthetic viability observation'),
(24,940000,'control','Synthetic viability observation'),
(36,910000,'control','Synthetic viability observation'),
(48,890000,'control','Synthetic viability observation');

INSERT INTO membrane_gradients
(scenario_id, diffusion_coefficient_cm2_s, concentration_inside, concentration_outside, distance_cm, notes)
VALUES
('small_gradient',0.000002,1.00,0.80,0.010,'Synthetic membrane-gradient scenario'),
('large_gradient',0.000002,1.00,0.20,0.010,'Synthetic membrane-gradient scenario'),
('thick_boundary',0.000002,1.00,0.20,0.020,'Synthetic membrane-gradient scenario'),
('high_diffusivity',0.000006,1.00,0.20,0.010,'Synthetic membrane-gradient scenario'),
('low_diffusivity',0.0000005,1.00,0.20,0.010,'Synthetic membrane-gradient scenario');

INSERT INTO cell_cycle_scenarios
(scenario_id, g1_initial, s_initial, g2m_initial, k1, k2, km, time_end, dt, notes)
VALUES
('baseline',0.70,0.20,0.10,0.10,0.08,0.06,48,0.01,'Synthetic cell-cycle scenario'),
('slow_s_entry',0.70,0.20,0.10,0.04,0.08,0.06,48,0.01,'Synthetic cell-cycle scenario'),
('g2m_delay',0.70,0.20,0.10,0.10,0.08,0.02,48,0.01,'Synthetic cell-cycle scenario'),
('rapid_cycle',0.70,0.20,0.10,0.18,0.14,0.10,48,0.01,'Synthetic cell-cycle scenario');

INSERT INTO imaging_features
(cell_id, condition_name, area_um2, perimeter_um, nuclear_area_um2, mean_intensity, roundness, notes)
VALUES
('cell_001','control',820,118,210,1450,0.74,'Synthetic imaging feature'),
('cell_002','control',790,114,205,1390,0.76,'Synthetic imaging feature'),
('cell_003','treated',640,106,195,1180,0.68,'Synthetic imaging feature'),
('cell_004','treated',610,104,188,1110,0.66,'Synthetic imaging feature'),
('cell_005','hypoxic',700,112,202,1225,0.70,'Synthetic imaging feature'),
('cell_006','hypoxic',685,110,199,1205,0.69,'Synthetic imaging feature');

INSERT INTO cell_condition_sites
(condition_id, membrane_integrity, metabolic_activity, proliferation_capacity, genomic_stability, organelle_function, stress_penalty, notes)
VALUES
('control',0.92,0.88,0.84,0.90,0.86,0.12,'Synthetic cell-condition site'),
('nutrient_limited',0.78,0.55,0.48,0.82,0.70,0.42,'Synthetic cell-condition site'),
('hypoxic',0.70,0.46,0.42,0.76,0.52,0.55,'Synthetic cell-condition site'),
('drug_treated',0.62,0.40,0.30,0.68,0.48,0.68,'Synthetic cell-condition site'),
('membrane_stress',0.38,0.54,0.44,0.74,0.60,0.64,'Synthetic cell-condition site'),
('mitochondrial_stress',0.74,0.36,0.40,0.72,0.32,0.70,'Synthetic cell-condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('cell_counts.csv', 'synthetic_example', 'constructed_example', 'log-linear exponential growth fitting', 'MIT-compatible example data', 'growth setup', 'Not real cell-culture data'),
('logistic_scenarios.csv', 'synthetic_example', 'constructed_example', 'logistic cell-growth simulation', 'MIT-compatible example data', 'logistic setup', 'Not real carrying-capacity data'),
('viability_observations.csv', 'synthetic_example', 'constructed_example', 'viability-decay fitting', 'MIT-compatible example data', 'viability setup', 'Not real viability assay data'),
('membrane_gradients.csv', 'synthetic_example', 'constructed_example', 'Fick-style membrane flux calculation', 'MIT-compatible example data', 'membrane-gradient setup', 'Not real membrane-transport data'),
('cell_cycle_scenarios.csv', 'synthetic_example', 'constructed_example', 'simplified cell-cycle compartment simulation', 'MIT-compatible example data', 'cell-cycle setup', 'Not a calibrated cell-cycle model'),
('imaging_features.csv', 'synthetic_example', 'constructed_example', 'imaging feature summary', 'MIT-compatible example data', 'imaging setup', 'Not real microscopy data'),
('cell_condition_sites.csv', 'synthetic_example', 'constructed_example', 'cell-condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated diagnostic score');
