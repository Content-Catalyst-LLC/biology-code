-- Cell structure, membranes, and organelles reproducibility schema.
--
-- This schema tracks compartment inventory, membrane transport observations,
-- organelle morphometry, organelle networks, compartment-flux scenarios,
-- cellular architecture condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS compartment_inventory;
DROP TABLE IF EXISTS membrane_transport_observations;
DROP TABLE IF EXISTS organelle_morphometry;
DROP TABLE IF EXISTS organelle_network_edges;
DROP TABLE IF EXISTS compartment_flux_scenarios;
DROP TABLE IF EXISTS cellular_architecture_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE compartment_inventory (
    compartment_id TEXT PRIMARY KEY,
    estimated_volume_um3 REAL NOT NULL,
    estimated_surface_area_um2 REAL NOT NULL,
    primary_function TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE membrane_transport_observations (
    observation_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL,
    permeability_um_s REAL NOT NULL,
    external_concentration REAL NOT NULL,
    internal_concentration REAL NOT NULL,
    membrane_area_um2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE organelle_morphometry (
    cell_id TEXT PRIMARY KEY,
    condition_name TEXT NOT NULL,
    cell_area_um2 REAL NOT NULL,
    mitochondrial_area_um2 REAL NOT NULL,
    er_area_um2 REAL NOT NULL,
    golgi_area_um2 REAL NOT NULL,
    lysosome_count INTEGER NOT NULL,
    nucleus_area_um2 REAL NOT NULL,
    notes TEXT
);

CREATE TABLE organelle_network_edges (
    edge_id INTEGER PRIMARY KEY,
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    interaction_weight REAL NOT NULL,
    interaction_type TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE compartment_flux_scenarios (
    scenario_id TEXT PRIMARY KEY,
    cytosol_initial REAL NOT NULL,
    organelle_initial REAL NOT NULL,
    k_import REAL NOT NULL,
    k_export REAL NOT NULL,
    organelle_consumption REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE cellular_architecture_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    membrane_integrity REAL NOT NULL,
    transport_capacity REAL NOT NULL,
    organelle_specialization REAL NOT NULL,
    trafficking_coordination REAL NOT NULL,
    energy_compartment_function REAL NOT NULL,
    turnover_capacity REAL NOT NULL,
    stress_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    surface_area_um2 REAL,
    volume_um3 REAL,
    sa_to_volume REAL,
    membrane_flux REAL,
    area_scaled_flux REAL,
    mitochondrial_fraction REAL,
    er_fraction REAL,
    lysosome_density REAL,
    weighted_degree REAL,
    cellular_architecture_score REAL,
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

INSERT INTO compartment_inventory
(compartment_id, estimated_volume_um3, estimated_surface_area_um2, primary_function, notes)
VALUES
('plasma_membrane',0,1450,'boundary_transport_signaling','Synthetic compartment inventory'),
('nucleus',520,410,'information_control','Synthetic compartment inventory'),
('mitochondria',210,760,'energy_redox_signaling','Synthetic compartment inventory'),
('endoplasmic_reticulum',340,1280,'protein_lipid_calcium_logistics','Synthetic compartment inventory'),
('golgi',85,260,'sorting_processing_trafficking','Synthetic compartment inventory'),
('lysosome',42,190,'degradation_recycling','Synthetic compartment inventory'),
('peroxisome',28,120,'oxidation_detoxification','Synthetic compartment inventory'),
('cytosol',1800,0,'reaction_medium_transport','Synthetic compartment inventory');

INSERT INTO membrane_transport_observations
(scenario_name, permeability_um_s, external_concentration, internal_concentration, membrane_area_um2, notes)
VALUES
('baseline',0.050,10.0,3.0,420,'Synthetic transport observation'),
('low_permeability',0.018,10.0,3.0,420,'Synthetic transport observation'),
('high_gradient',0.050,18.0,2.0,420,'Synthetic transport observation'),
('reversed_gradient',0.050,2.0,8.0,420,'Synthetic transport observation'),
('stress_leakage',0.090,12.0,4.0,420,'Synthetic transport observation');

INSERT INTO organelle_morphometry
(cell_id, condition_name, cell_area_um2, mitochondrial_area_um2, er_area_um2, golgi_area_um2, lysosome_count, nucleus_area_um2, notes)
VALUES
('cell_1','control',420,62,105,28,18,96,'Synthetic morphometry observation'),
('cell_2','control',390,55,98,25,15,90,'Synthetic morphometry observation'),
('cell_3','control',455,75,114,31,22,102,'Synthetic morphometry observation'),
('cell_4','control',500,82,132,34,25,110,'Synthetic morphometry observation'),
('cell_5','stress',370,48,92,20,14,85,'Synthetic morphometry observation'),
('cell_6','stress',610,96,155,42,33,136,'Synthetic morphometry observation'),
('cell_7','stress',580,88,149,39,29,128,'Synthetic morphometry observation'),
('cell_8','stress',450,70,118,30,20,98,'Synthetic morphometry observation');

INSERT INTO organelle_network_edges
(source, target, interaction_weight, interaction_type, notes)
VALUES
('ER','Golgi',0.92,'vesicular_traffic','Synthetic organelle interaction'),
('ER','Mitochondria',0.74,'membrane_contact','Synthetic organelle interaction'),
('Golgi','Plasma_membrane',0.88,'secretory_traffic','Synthetic organelle interaction'),
('Golgi','Lysosome',0.81,'endolysosomal_traffic','Synthetic organelle interaction'),
('Mitochondria','Nucleus',0.62,'retrograde_signaling','Synthetic organelle interaction'),
('Lysosome','Autophagosome',0.69,'degradation_traffic','Synthetic organelle interaction'),
('Peroxisome','Mitochondria',0.57,'metabolic_crosstalk','Synthetic organelle interaction'),
('ER','Peroxisome',0.51,'lipid_exchange','Synthetic organelle interaction'),
('Plasma_membrane','Endosome',0.83,'endocytosis','Synthetic organelle interaction'),
('Endosome','Lysosome',0.86,'maturation','Synthetic organelle interaction');

INSERT INTO compartment_flux_scenarios
(scenario_id, cytosol_initial, organelle_initial, k_import, k_export, organelle_consumption, time_end, dt, notes)
VALUES
('baseline',10,2,0.040,0.015,0.010,120,0.5,'Synthetic compartment flux scenario'),
('high_import',10,2,0.075,0.015,0.010,120,0.5,'Synthetic compartment flux scenario'),
('blocked_export',10,2,0.040,0.004,0.010,120,0.5,'Synthetic compartment flux scenario'),
('high_consumption',10,2,0.040,0.015,0.030,120,0.5,'Synthetic compartment flux scenario');

INSERT INTO cellular_architecture_condition_sites
(site_name, membrane_integrity, transport_capacity, organelle_specialization, trafficking_coordination, energy_compartment_function, turnover_capacity, stress_penalty, notes)
VALUES
('reference_cell_state',0.86,0.82,0.80,0.78,0.82,0.76,0.18,'Synthetic cellular architecture condition site'),
('membrane_stress_state',0.46,0.52,0.72,0.60,0.66,0.64,0.58,'Synthetic cellular architecture condition site'),
('mitochondrial_dysfunction_state',0.76,0.70,0.68,0.62,0.34,0.58,0.64,'Synthetic cellular architecture condition site'),
('trafficking_defect_state',0.74,0.66,0.70,0.32,0.62,0.50,0.52,'Synthetic cellular architecture condition site'),
('plant_vacuolar_stress_state',0.70,0.76,0.78,0.68,0.72,0.82,0.34,'Synthetic cellular architecture condition site'),
('marine_osmotic_stress_state',0.58,0.48,0.70,0.62,0.64,0.60,0.66,'Synthetic cellular architecture condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('compartment_inventory.csv', 'synthetic_example', 'constructed_example', 'compartment inventory and architecture summary', 'MIT-compatible example data', 'inventory setup', 'Not real cell measurements'),
('membrane_transport_observations.csv', 'synthetic_example', 'constructed_example', 'permeability-limited flux calculation', 'MIT-compatible example data', 'transport setup', 'Not real membrane assay data'),
('organelle_morphometry.csv', 'synthetic_example', 'constructed_example', 'organelle fraction and density analysis', 'MIT-compatible example data', 'morphometry setup', 'Not real microscopy segmentation data'),
('organelle_network_edges.csv', 'synthetic_example', 'constructed_example', 'organelle network degree and weighted degree', 'MIT-compatible example data', 'network setup', 'Not real organelle contact data'),
('compartment_flux_scenarios.csv', 'synthetic_example', 'constructed_example', 'compartment import-export-consumption simulation', 'MIT-compatible example data', 'flux simulation setup', 'Not calibrated compartment model data'),
('cellular_architecture_condition_sites.csv', 'synthetic_example', 'constructed_example', 'cellular architecture condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
