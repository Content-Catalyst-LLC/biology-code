-- Differential equations in population and physiological modeling schema.

DROP TABLE IF EXISTS model_catalog;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS predator_prey_scenarios;
DROP TABLE IF EXISTS sir_scenarios;
DROP TABLE IF EXISTS homeostasis_scenarios;
DROP TABLE IF EXISTS pharmacokinetic_scenarios;
DROP TABLE IF EXISTS chemostat_scenarios;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE model_catalog (
    model_id TEXT PRIMARY KEY,
    model_name TEXT NOT NULL,
    biological_domain TEXT NOT NULL,
    equation_type TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    limitations TEXT
);

CREATE TABLE logistic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    N0 REAL NOT NULL,
    r REAL NOT NULL,
    K REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE predator_prey_scenarios (
    scenario_id TEXT PRIMARY KEY,
    prey0 REAL NOT NULL,
    predator0 REAL NOT NULL,
    alpha REAL NOT NULL,
    beta REAL NOT NULL,
    delta REAL NOT NULL,
    gamma REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE sir_scenarios (
    scenario_id TEXT PRIMARY KEY,
    beta REAL NOT NULL,
    gamma REAL NOT NULL,
    S0 REAL NOT NULL,
    I0 REAL NOT NULL,
    R0 REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE homeostasis_scenarios (
    scenario_id TEXT PRIMARY KEY,
    x0 REAL NOT NULL,
    set_point REAL NOT NULL,
    k REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE pharmacokinetic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    C0 REAL NOT NULL,
    elimination_rate REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE chemostat_scenarios (
    scenario_id TEXT PRIMARY KEY,
    X0 REAL NOT NULL,
    S0 REAL NOT NULL,
    S_in REAL NOT NULL,
    D REAL NOT NULL,
    Y REAL NOT NULL,
    mu_max REAL NOT NULL,
    K_s REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    final_population REAL,
    final_prey REAL,
    final_predator REAL,
    peak_infected REAL,
    time_to_peak REAL,
    final_recovered REAL,
    final_state REAL,
    final_concentration REAL,
    final_biomass REAL,
    final_substrate REAL,
    sensitivity_value REAL,
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

INSERT INTO model_catalog
(model_id, model_name, biological_domain, equation_type, primary_use, limitations)
VALUES
('logistic','Logistic growth','population biology; ecology; microbiology','ordinary differential equation','density-dependent growth','simplifies age structure spatial structure and stochasticity'),
('lotka_volterra','Lotka-Volterra predator-prey','ecology; marine biology','coupled ordinary differential equations','interaction-driven population dynamics','simplified functional response and no carrying capacity'),
('sir','SIR epidemic model','epidemiology; host-pathogen biology','compartmental ordinary differential equations','disease transmission dynamics','homogeneous mixing and simplified immunity'),
('homeostasis','Homeostatic return to set point','physiology; biomedical engineering','ordinary differential equation','regulatory recovery from perturbation','simplified feedback without delay or nonlinear response'),
('pharmacokinetics','One-compartment pharmacokinetics','pharmacology; medicine','ordinary differential equation','drug elimination','single compartment and first-order clearance'),
('chemostat','Chemostat dynamics','microbiology; biotechnology','coupled ordinary differential equations','biomass-substrate process control','simplified Monod growth and no community interactions'),
('reaction_diffusion','Reaction-diffusion scaffold','spatial biology; development; ecology','partial differential equation','spatial pattern and diffusion-reaction dynamics','requires boundary conditions and stability checks');

INSERT INTO logistic_scenarios
(scenario_id, N0, r, K, dt, t_end, notes)
VALUES
('baseline',100,0.30,2000,0.05,40,'Synthetic logistic scenario'),
('resource_limited',100,0.18,900,0.05,40,'Synthetic logistic scenario'),
('rapid_growth',100,0.45,2600,0.05,40,'Synthetic logistic scenario'),
('low_capacity',100,0.30,600,0.05,40,'Synthetic logistic scenario');

INSERT INTO predator_prey_scenarios
(scenario_id, prey0, predator0, alpha, beta, delta, gamma, dt, t_end, notes)
VALUES
('baseline',40,9,0.60,0.025,0.018,0.35,0.01,80,'Synthetic predator-prey scenario'),
('high_predation',40,9,0.60,0.040,0.018,0.35,0.01,80,'Synthetic predator-prey scenario'),
('low_predator_mortality',40,9,0.60,0.025,0.018,0.20,0.01,80,'Synthetic predator-prey scenario'),
('low_prey_growth',40,9,0.35,0.025,0.018,0.35,0.01,80,'Synthetic predator-prey scenario');

INSERT INTO sir_scenarios
(scenario_id, beta, gamma, S0, I0, R0, dt, t_end, notes)
VALUES
('baseline',0.35,0.10,0.99,0.01,0.00,0.05,120,'Synthetic SIR scenario'),
('lower_transmission',0.18,0.10,0.99,0.01,0.00,0.05,120,'Synthetic SIR scenario'),
('faster_recovery',0.35,0.20,0.99,0.01,0.00,0.05,120,'Synthetic SIR scenario'),
('high_transmission',0.55,0.10,0.99,0.01,0.00,0.05,120,'Synthetic SIR scenario');

INSERT INTO homeostasis_scenarios
(scenario_id, x0, set_point, k, dt, t_end, notes)
VALUES
('baseline',180,100,0.18,0.05,30,'Synthetic homeostasis scenario'),
('slow_return',180,100,0.08,0.05,30,'Synthetic homeostasis scenario'),
('fast_return',180,100,0.35,0.05,30,'Synthetic homeostasis scenario'),
('low_perturbation',130,100,0.18,0.05,30,'Synthetic homeostasis scenario');

INSERT INTO pharmacokinetic_scenarios
(scenario_id, C0, elimination_rate, dt, t_end, notes)
VALUES
('baseline',20.0,0.12,0.05,48,'Synthetic pharmacokinetic scenario'),
('slow_clearance',20.0,0.06,0.05,48,'Synthetic pharmacokinetic scenario'),
('fast_clearance',20.0,0.22,0.05,48,'Synthetic pharmacokinetic scenario'),
('low_initial',8.0,0.12,0.05,48,'Synthetic pharmacokinetic scenario');

INSERT INTO chemostat_scenarios
(scenario_id, X0, S0, S_in, D, Y, mu_max, K_s, dt, t_end, notes)
VALUES
('baseline',0.1,10,20,0.20,0.50,0.80,2.0,0.01,80,'Synthetic chemostat scenario'),
('high_dilution',0.1,10,20,0.60,0.50,0.80,2.0,0.01,80,'Synthetic chemostat scenario'),
('low_substrate_feed',0.1,10,8,0.20,0.50,0.80,2.0,0.01,80,'Synthetic chemostat scenario'),
('high_growth',0.1,10,20,0.20,0.50,1.20,2.0,0.01,80,'Synthetic chemostat scenario');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('logistic_scenarios.csv','synthetic_example','constructed_example','Euler integration of logistic ODE','MIT-compatible example data','population setup','Not real population data'),
('predator_prey_scenarios.csv','synthetic_example','constructed_example','Euler integration of Lotka-Volterra system','MIT-compatible example data','interaction setup','Simplified predator-prey assumptions'),
('sir_scenarios.csv','synthetic_example','constructed_example','Euler integration of SIR model','MIT-compatible example data','epidemic setup','Not public health data'),
('homeostasis_scenarios.csv','synthetic_example','constructed_example','homeostatic return ODE','MIT-compatible example data','physiology setup','Simplified regulatory dynamics'),
('pharmacokinetic_scenarios.csv','synthetic_example','constructed_example','one-compartment elimination ODE','MIT-compatible example data','pharmacokinetic setup','Not clinical dosing data'),
('chemostat_scenarios.csv','synthetic_example','constructed_example','biomass-substrate chemostat ODEs','MIT-compatible example data','chemostat setup','Simplified process model');
