DROP TABLE IF EXISTS resistance_scenarios;
DROP TABLE IF EXISTS mismatch_exposures;
DROP TABLE IF EXISTS life_history_allocation;
DROP TABLE IF EXISTS somatic_evolution_scenarios;
DROP TABLE IF EXISTS defense_thresholds;
DROP TABLE IF EXISTS disease_scenarios;
DROP TABLE IF EXISTS provenance_artifacts;

CREATE TABLE resistance_scenarios (
    scenario TEXT PRIMARY KEY,
    initial_frequency REAL NOT NULL,
    selection_advantage REAL NOT NULL,
    fitness_cost REAL NOT NULL,
    steps INTEGER NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE mismatch_exposures (
    trait_system TEXT PRIMARY KEY,
    current_exposure REAL NOT NULL,
    adapted_exposure_reference REAL NOT NULL,
    evidence_confidence REAL NOT NULL,
    biological_domain TEXT NOT NULL
);

CREATE TABLE life_history_allocation (
    scenario TEXT PRIMARY KEY,
    growth REAL NOT NULL,
    reproduction REAL NOT NULL,
    maintenance REAL NOT NULL,
    immune_defense REAL NOT NULL
);

CREATE TABLE somatic_evolution_scenarios (
    clone_id TEXT PRIMARY KEY,
    initial_clone_size REAL NOT NULL,
    growth_rate REAL NOT NULL,
    time_steps INTEGER NOT NULL,
    selection_context TEXT NOT NULL
);

CREATE TABLE defense_thresholds (
    defense_system TEXT PRIMARY KEY,
    threat_level REAL NOT NULL,
    activation_threshold REAL NOT NULL,
    false_alarm_cost REAL NOT NULL,
    missed_threat_cost REAL NOT NULL
);

CREATE TABLE disease_scenarios (
    scenario TEXT PRIMARY KEY,
    disease_area TEXT NOT NULL,
    evolutionary_mechanism TEXT NOT NULL,
    proximate_focus TEXT NOT NULL,
    public_health_relevance TEXT NOT NULL
);

CREATE TABLE provenance_artifacts (
    artifact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    artifact_name TEXT NOT NULL,
    artifact_type TEXT NOT NULL,
    relative_path TEXT NOT NULL,
    checksum_sha256 TEXT,
    notes TEXT
);

INSERT INTO resistance_scenarios VALUES
('low_selection',0.02,0.05,0.04,30,'Low antimicrobial selection with resistance cost'),
('moderate_selection',0.02,0.12,0.04,30,'Moderate antimicrobial selection'),
('high_selection',0.02,0.22,0.04,30,'High antimicrobial selection'),
('high_cost',0.02,0.12,0.10,30,'Moderate selection with higher resistance cost');

INSERT INTO mismatch_exposures VALUES
('energy_storage',0.90,0.45,0.70,'metabolism'),
('circadian_regulation',0.82,0.35,0.65,'neuroendocrine'),
('immune_calibration',0.25,0.70,0.55,'immunology'),
('visual_development',0.88,0.40,0.60,'development'),
('stress_response',0.78,0.42,0.50,'physiology'),
('physical_activity',0.20,0.75,0.65,'musculoskeletal_metabolic');

INSERT INTO life_history_allocation VALUES
('high_growth',0.45,0.20,0.20,0.15),
('high_reproduction',0.20,0.45,0.20,0.15),
('high_maintenance',0.20,0.15,0.45,0.20),
('high_defense',0.18,0.17,0.25,0.40),
('balanced',0.25,0.25,0.25,0.25);

INSERT INTO somatic_evolution_scenarios VALUES
('clone_A',100,0.05,30,'low_growth_advantage'),
('clone_B',100,0.12,30,'moderate_growth_advantage'),
('clone_C',100,0.20,30,'high_growth_advantage'),
('treatment_resistant_clone',10,0.18,30,'post_treatment_selection');

INSERT INTO defense_thresholds VALUES
('fever_response',0.70,0.55,0.25,0.80),
('inflammation',0.62,0.50,0.45,0.75),
('pain_response',0.48,0.40,0.30,0.70),
('cough_reflex',0.52,0.45,0.20,0.65),
('anxiety_like_response',0.35,0.30,0.55,0.60);

INSERT INTO disease_scenarios VALUES
('antimicrobial_resistance','infection','selection_under_drug_pressure','microbial_survival_and_transmission','high'),
('cancer_clonal_evolution','oncology','somatic_selection','mutation_and_cell_proliferation','high'),
('metabolic_mismatch','metabolic_health','environmental_mismatch','insulin_resistance_and_energy_balance','high'),
('autoimmunity','immunology','defense_tradeoff','immune_activation_and_tolerance','medium'),
('aging_senescence','aging','declining_selection_late_life','repair_limits_and_cellular_damage','high');

INSERT INTO provenance_artifacts (artifact_name, artifact_type, relative_path, checksum_sha256, notes) VALUES
('resistance_scenarios.csv','synthetic_data','data/resistance_scenarios.csv',NULL,'Synthetic antimicrobial resistance scenario data'),
('mismatch_exposures.csv','synthetic_data','data/mismatch_exposures.csv',NULL,'Synthetic mismatch exposure data'),
('life_history_allocation.csv','synthetic_data','data/life_history_allocation.csv',NULL,'Synthetic life-history allocation data'),
('somatic_evolution_scenarios.csv','synthetic_data','data/somatic_evolution_scenarios.csv',NULL,'Synthetic somatic evolution scenario data'),
('defense_thresholds.csv','synthetic_data','data/defense_thresholds.csv',NULL,'Synthetic defense-threshold data');
