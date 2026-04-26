-- Enzyme regulation and biochemical pathway reproducibility schema.
--
-- This schema tracks enzyme assay observations, enzyme variants,
-- inhibition conditions, pathway steps, enzyme condition sites,
-- model outputs, and provenance.

DROP TABLE IF EXISTS enzyme_assay_observations;
DROP TABLE IF EXISTS enzyme_variants;
DROP TABLE IF EXISTS inhibition_conditions;
DROP TABLE IF EXISTS pathway_steps;
DROP TABLE IF EXISTS enzyme_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE enzyme_assay_observations (
    observation_id INTEGER PRIMARY KEY,
    substrate_mM REAL NOT NULL,
    velocity_units_min REAL NOT NULL,
    notes TEXT
);

CREATE TABLE enzyme_variants (
    enzyme_id TEXT PRIMARY KEY,
    kcat_per_s REAL NOT NULL,
    Km_mM REAL NOT NULL,
    notes TEXT
);

CREATE TABLE inhibition_conditions (
    condition_id TEXT PRIMARY KEY,
    Vmax REAL NOT NULL,
    Km REAL NOT NULL,
    inhibitor_uM REAL NOT NULL,
    Ki_uM REAL NOT NULL,
    inhibition_type TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE pathway_steps (
    step_id TEXT PRIMARY KEY,
    enzyme_name TEXT NOT NULL,
    capacity REAL NOT NULL,
    regulation_factor REAL NOT NULL,
    notes TEXT
);

CREATE TABLE enzyme_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    catalytic_capacity REAL NOT NULL,
    substrate_access REAL NOT NULL,
    regulatory_control REAL NOT NULL,
    cofactor_availability REAL NOT NULL,
    pathway_integration REAL NOT NULL,
    environmental_stability REAL NOT NULL,
    inhibition_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    substrate_mM REAL,
    velocity_units_min REAL,
    Vmax REAL,
    Km REAL,
    kcat_per_s REAL,
    catalytic_efficiency REAL,
    inhibitor_uM REAL,
    Ki_uM REAL,
    pathway_flux REAL,
    enzyme_pathway_score REAL,
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

INSERT INTO enzyme_assay_observations
(substrate_mM, velocity_units_min, notes)
VALUES
(0.5,10.4,'Synthetic enzyme assay observation'),
(1.0,19.7,'Synthetic enzyme assay observation'),
(2.0,33.5,'Synthetic enzyme assay observation'),
(4.0,54.8,'Synthetic enzyme assay observation'),
(8.0,73.6,'Synthetic enzyme assay observation'),
(12.0,85.9,'Synthetic enzyme assay observation'),
(20.0,96.2,'Synthetic enzyme assay observation'),
(30.0,103.4,'Synthetic enzyme assay observation');

INSERT INTO enzyme_variants
(enzyme_id, kcat_per_s, Km_mM, notes)
VALUES
('variant_A',75,5,'Synthetic enzyme variant'),
('variant_B',120,12,'Synthetic enzyme variant'),
('variant_C',45,2.5,'Synthetic enzyme variant'),
('variant_D',90,4,'Synthetic enzyme variant'),
('variant_E',150,20,'Synthetic enzyme variant');

INSERT INTO inhibition_conditions
(condition_id, Vmax, Km, inhibitor_uM, Ki_uM, inhibition_type, notes)
VALUES
('control',120,5,0,2,'none','Synthetic inhibition condition'),
('competitive_low',120,5,2,2,'competitive','Synthetic inhibition condition'),
('competitive_high',120,5,6,2,'competitive','Synthetic inhibition condition'),
('noncompetitive_low',120,5,2,2,'noncompetitive','Synthetic inhibition condition'),
('noncompetitive_high',120,5,6,2,'noncompetitive','Synthetic inhibition condition');

INSERT INTO pathway_steps
(step_id, enzyme_name, capacity, regulation_factor, notes)
VALUES
('uptake','transporter',88,0.95,'Synthetic pathway step'),
('activation','kinase',72,0.80,'Synthetic pathway step'),
('conversion','isomerase',95,0.90,'Synthetic pathway step'),
('branch_commitment','dehydrogenase',54,0.70,'Synthetic pathway step'),
('product_release','exporter',80,0.85,'Synthetic pathway step');

INSERT INTO enzyme_condition_sites
(site_name, catalytic_capacity, substrate_access, regulatory_control, cofactor_availability, pathway_integration, environmental_stability, inhibition_risk, notes)
VALUES
('reference_pathway',0.84,0.78,0.76,0.80,0.74,0.72,0.18,'Synthetic enzyme condition site'),
('inhibited_pathway',0.52,0.70,0.48,0.68,0.58,0.62,0.68,'Synthetic enzyme condition site'),
('cofactor_limited_state',0.62,0.74,0.66,0.32,0.54,0.58,0.42,'Synthetic enzyme condition site'),
('microbial_soil_pathway',0.78,0.82,0.70,0.76,0.84,0.64,0.26,'Synthetic enzyme condition site'),
('thermal_stress_state',0.50,0.68,0.58,0.60,0.52,0.34,0.46,'Synthetic enzyme condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('enzyme_assay.csv', 'synthetic_example', 'constructed_example', 'Michaelis-Menten parameter fitting', 'MIT-compatible example data', 'enzyme assay setup', 'Not real enzyme assay data'),
('inhibition_conditions.csv', 'synthetic_example', 'constructed_example', 'competitive and noncompetitive inhibition comparison', 'MIT-compatible example data', 'inhibition model setup', 'Not real inhibitor data'),
('enzyme_variants.csv', 'synthetic_example', 'constructed_example', 'catalytic efficiency comparison', 'MIT-compatible example data', 'variant comparison setup', 'Not real enzyme variant data'),
('pathway_steps.csv', 'synthetic_example', 'constructed_example', 'pathway bottleneck and flux scoring', 'MIT-compatible example data', 'pathway model setup', 'Not real pathway flux data'),
('enzyme_condition_sites.csv', 'synthetic_example', 'constructed_example', 'enzyme pathway condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
