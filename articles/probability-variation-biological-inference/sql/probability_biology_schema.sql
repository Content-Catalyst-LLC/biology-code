-- Probability, variation, and biological inference reproducibility schema.

DROP TABLE IF EXISTS binomial_trials;
DROP TABLE IF EXISTS biological_measurements;
DROP TABLE IF EXISTS bayesian_priors;
DROP TABLE IF EXISTS power_scenarios;
DROP TABLE IF EXISTS multiple_testing;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE binomial_trials (
    experiment_id TEXT PRIMARY KEY,
    successes INTEGER NOT NULL,
    trials INTEGER NOT NULL,
    context TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE biological_measurements (
    sample_id TEXT PRIMARY KEY,
    group_name TEXT NOT NULL,
    measurement_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE bayesian_priors (
    scenario_id TEXT PRIMARY KEY,
    alpha_prior REAL NOT NULL,
    beta_prior REAL NOT NULL,
    successes INTEGER NOT NULL,
    trials INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE power_scenarios (
    scenario_id TEXT PRIMARY KEY,
    sample_size_per_group INTEGER NOT NULL,
    effect_size REAL NOT NULL,
    sigma REAL NOT NULL,
    alpha REAL NOT NULL,
    n_sim INTEGER NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE multiple_testing (
    feature_id TEXT PRIMARY KEY,
    p_value REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    estimate REAL,
    standard_error REAL,
    ci_lower REAL,
    ci_upper REAL,
    posterior_mean REAL,
    posterior_sd REAL,
    p_value REAL,
    q_value REAL,
    estimated_power REAL,
    log_likelihood REAL,
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

INSERT INTO binomial_trials
(experiment_id, successes, trials, context, notes)
VALUES
('germination_assay',68,100,'seed response','Synthetic binomial biological outcome'),
('infection_challenge',37,80,'host infection','Synthetic binomial biological outcome'),
('diagnostic_assay',92,120,'positive detection','Synthetic binomial biological outcome'),
('restoration_survival',41,75,'seedling survival','Synthetic binomial biological outcome'),
('marine_detection',24,60,'environmental detection','Synthetic binomial biological outcome');

INSERT INTO biological_measurements
(sample_id, group_name, measurement_value, notes)
VALUES
('s001','control',10.2,'Synthetic measurement'),
('s002','control',11.1,'Synthetic measurement'),
('s003','control',9.8,'Synthetic measurement'),
('s004','control',10.5,'Synthetic measurement'),
('s005','control',10.9,'Synthetic measurement'),
('s006','control',11.0,'Synthetic measurement'),
('s007','control',9.9,'Synthetic measurement'),
('s008','control',10.4,'Synthetic measurement'),
('s009','treated',12.1,'Synthetic measurement'),
('s010','treated',11.7,'Synthetic measurement'),
('s011','treated',12.4,'Synthetic measurement'),
('s012','treated',11.9,'Synthetic measurement'),
('s013','treated',12.0,'Synthetic measurement'),
('s014','treated',12.6,'Synthetic measurement'),
('s015','treated',11.8,'Synthetic measurement'),
('s016','treated',12.3,'Synthetic measurement');

INSERT INTO bayesian_priors
(scenario_id, alpha_prior, beta_prior, successes, trials, notes)
VALUES
('uninformative_prior',1,1,68,100,'Synthetic prior scenario'),
('skeptical_prior',2,8,68,100,'Synthetic prior scenario'),
('optimistic_prior',8,2,68,100,'Synthetic prior scenario'),
('field_prior',12,18,41,75,'Synthetic prior scenario');

INSERT INTO power_scenarios
(scenario_id, sample_size_per_group, effect_size, sigma, alpha, n_sim, seed, notes)
VALUES
('small_n',5,1.0,1.5,0.05,3000,101,'Synthetic power scenario'),
('moderate_n',20,1.0,1.5,0.05,3000,102,'Synthetic power scenario'),
('large_n',80,1.0,1.5,0.05,3000,103,'Synthetic power scenario'),
('small_effect',40,0.4,1.5,0.05,3000,104,'Synthetic power scenario'),
('large_effect',40,1.4,1.5,0.05,3000,105,'Synthetic power scenario');

INSERT INTO multiple_testing
(feature_id, p_value, notes)
VALUES
('gene_001',0.0008,'Synthetic p-value'),
('gene_002',0.0015,'Synthetic p-value'),
('gene_003',0.0042,'Synthetic p-value'),
('gene_004',0.0099,'Synthetic p-value'),
('gene_005',0.0120,'Synthetic p-value'),
('gene_006',0.0210,'Synthetic p-value'),
('gene_007',0.0310,'Synthetic p-value'),
('gene_008',0.0490,'Synthetic p-value'),
('gene_009',0.0800,'Synthetic p-value'),
('gene_010',0.1200,'Synthetic p-value'),
('gene_011',0.2100,'Synthetic p-value'),
('gene_012',0.3300,'Synthetic p-value');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('binomial_trials.csv','synthetic_example','constructed_example','binomial inference and confidence intervals','MIT-compatible example data','binomial setup','Not real biological trial data'),
('biological_measurements.csv','synthetic_example','constructed_example','bootstrap and permutation testing','MIT-compatible example data','measurement setup','Not real experimental data'),
('bayesian_priors.csv','synthetic_example','constructed_example','beta-binomial Bayesian updating','MIT-compatible example data','prior setup','Priors are illustrative only'),
('power_scenarios.csv','synthetic_example','constructed_example','simulation-based power approximation','MIT-compatible example data','power setup','Simplified normal approximation'),
('multiple_testing.csv','synthetic_example','constructed_example','Benjamini-Hochberg false discovery scaffold','MIT-compatible example data','multiple testing setup','Synthetic p-values only');
