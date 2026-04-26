-- Animal biology reproducibility schema.
--
-- This schema tracks species traits, population recovery scenarios, survival
-- scenarios, condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS species_traits;
DROP TABLE IF EXISTS population_recovery_scenarios;
DROP TABLE IF EXISTS survival_scenarios;
DROP TABLE IF EXISTS stage_matrix;
DROP TABLE IF EXISTS animal_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE species_traits (
    species_id INTEGER PRIMARY KEY,
    species_name TEXT NOT NULL UNIQUE,
    body_mass_kg REAL NOT NULL,
    habitat TEXT NOT NULL,
    exposure_risk REAL NOT NULL,
    notes TEXT
);

CREATE TABLE population_recovery_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    initial_population REAL NOT NULL,
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE survival_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    hazard_rate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE stage_matrix (
    matrix_id INTEGER PRIMARY KEY,
    from_stage TEXT NOT NULL,
    to_stage TEXT NOT NULL,
    value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE animal_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    habitat_quality REAL NOT NULL,
    food_availability REAL NOT NULL,
    disease_pressure REAL NOT NULL,
    heat_stress REAL NOT NULL,
    reproductive_support REAL NOT NULL,
    movement_connectivity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    metabolic_rate REAL,
    mass_specific_rate REAL,
    final_population REAL,
    survival_day_100 REAL,
    total_population REAL,
    condition_score REAL,
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

INSERT INTO species_traits
(species_name, body_mass_kg, habitat, exposure_risk, notes)
VALUES
('shrew', 0.01, 'terrestrial', 0.40, 'Synthetic trait example'),
('sparrow', 0.03, 'terrestrial', 0.42, 'Synthetic trait example'),
('rabbit', 1.5, 'terrestrial', 0.38, 'Synthetic trait example'),
('fox', 6.0, 'terrestrial', 0.44, 'Synthetic trait example'),
('deer', 80.0, 'terrestrial', 0.48, 'Synthetic trait example'),
('seal', 150.0, 'marine', 0.55, 'Synthetic trait example');

INSERT INTO population_recovery_scenarios
(scenario_name, initial_population, growth_rate, carrying_capacity, notes)
VALUES
('degraded_habitat', 20, 0.05, 80, 'Synthetic degraded habitat scenario'),
('partial_restoration', 20, 0.08, 120, 'Synthetic partial restoration scenario'),
('full_restoration', 20, 0.11, 180, 'Synthetic full restoration scenario'),
('restoration_plus_predator_control', 20, 0.13, 220, 'Synthetic restoration and mortality reduction scenario');

INSERT INTO survival_scenarios
(scenario_name, hazard_rate, notes)
VALUES
('reference', 0.005, 'Synthetic reference hazard'),
('heat_stress', 0.012, 'Synthetic heat stress hazard'),
('disease_burden', 0.018, 'Synthetic disease hazard'),
('restoration_after_stress', 0.008, 'Synthetic post-restoration hazard');

INSERT INTO stage_matrix
(from_stage, to_stage, value, notes)
VALUES
('adult', 'juvenile', 1.4, 'Adult fertility producing juveniles'),
('juvenile', 'adult', 0.35, 'Juvenile transition to adult'),
('adult', 'adult', 0.72, 'Adult survival'),
('juvenile', 'juvenile', 0.0, 'No juvenile stasis in synthetic model');

INSERT INTO animal_condition_sites
(site_name, habitat_quality, food_availability, disease_pressure, heat_stress, reproductive_support, movement_connectivity, notes)
VALUES
('reference_reserve', 0.86, 0.82, 0.08, 0.16, 0.80, 0.78, 'Synthetic condition site'),
('fragmented_woodland', 0.52, 0.58, 0.18, 0.34, 0.50, 0.35, 'Synthetic condition site'),
('heat_stressed_wetland', 0.61, 0.55, 0.21, 0.62, 0.47, 0.51, 'Synthetic condition site'),
('restored_corridor', 0.72, 0.69, 0.13, 0.28, 0.67, 0.76, 'Synthetic condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('species_traits.csv', 'synthetic_example', 'constructed_example', 'allometric metabolic scaling', 'MIT-compatible example data', 'trait screening setup', 'Not real animal data'),
('population_recovery_scenarios.csv', 'synthetic_example', 'constructed_example', 'logistic population recovery', 'MIT-compatible example data', 'recovery scenario setup', 'Not real animal data'),
('survival_scenarios.csv', 'synthetic_example', 'constructed_example', 'hazard-based survival screening', 'MIT-compatible example data', 'survival scenario setup', 'Not real animal data'),
('animal_condition_sites.csv', 'synthetic_example', 'constructed_example', 'condition scoring', 'MIT-compatible example data', 'condition index setup', 'Not real animal data');
