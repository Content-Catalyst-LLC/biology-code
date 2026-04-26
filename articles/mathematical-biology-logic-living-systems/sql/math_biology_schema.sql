-- Mathematical biology reproducibility schema.

DROP TABLE IF EXISTS model_catalog;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS predator_prey_parameters;
DROP TABLE IF EXISTS sir_scenarios;
DROP TABLE IF EXISTS enzyme_kinetics;
DROP TABLE IF EXISTS network_edges;
DROP TABLE IF EXISTS stochastic_scenarios;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE model_catalog (
    model_id TEXT PRIMARY KEY,
    model_name TEXT NOT NULL,
    biological_domain TEXT NOT NULL,
    mathematical_structure TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    limitations TEXT
);

CREATE TABLE logistic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    initial_population REAL NOT NULL,
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE predator_prey_parameters (
    scenario_id TEXT PRIMARY KEY,
    prey0 REAL NOT NULL,
    predator0 REAL NOT NULL,
    alpha REAL NOT NULL,
    beta REAL NOT NULL,
    delta REAL NOT NULL,
    gamma REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE sir_scenarios (
    scenario_id TEXT PRIMARY KEY,
    beta REAL NOT NULL,
    gamma REAL NOT NULL,
    susceptible0 REAL NOT NULL,
    infected0 REAL NOT NULL,
    recovered0 REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE enzyme_kinetics (
    observation_id INTEGER PRIMARY KEY,
    scenario_id TEXT NOT NULL,
    vmax REAL NOT NULL,
    km REAL NOT NULL,
    substrate REAL NOT NULL,
    notes TEXT
);

CREATE TABLE network_edges (
    edge_id INTEGER PRIMARY KEY,
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    interaction TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT
);

CREATE TABLE stochastic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    initial_population INTEGER NOT NULL,
    birth_rate REAL NOT NULL,
    death_rate REAL NOT NULL,
    time_end REAL NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    final_population REAL,
    fraction_of_capacity REAL,
    peak_infected REAL,
    time_to_peak REAL,
    final_recovered REAL,
    final_prey REAL,
    final_predator REAL,
    enzyme_velocity REAL,
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
(model_id, model_name, biological_domain, mathematical_structure, primary_use, limitations)
VALUES
('logistic','Logistic growth','population biology; microbiology; biotechnology','ordinary differential equation','density-dependent growth','omits age structure spatial structure stochasticity and interactions'),
('lotka_volterra','Lotka-Volterra predator-prey','ecology; marine biology','coupled ordinary differential equations','interaction-driven oscillation','simplified functional response and no carrying capacity'),
('sir','SIR epidemic model','epidemiology; immunology; public health','compartmental ordinary differential equations','disease transmission dynamics','homogeneous mixing and simplified immunity'),
('michaelis_menten','Michaelis-Menten kinetics','biochemistry; systems biology','saturating algebraic rate law','enzyme velocity and substrate response','requires assumptions about quasi-steady-state behavior'),
('reaction_diffusion','Reaction-diffusion scaffold','development; ecology; spatial biology','partial differential equation','spatial pattern formation','requires careful boundary conditions and stability analysis'),
('birth_death','Stochastic birth-death process','population biology; cell biology; ecology','continuous-time Markov process','demographic stochasticity','requires many replicates for inference');

INSERT INTO logistic_scenarios
(scenario_id, initial_population, growth_rate, carrying_capacity, time_end, dt, notes)
VALUES
('baseline',100,0.30,2000,40,0.05,'Synthetic logistic scenario'),
('resource_limited',100,0.18,900,40,0.05,'Synthetic logistic scenario'),
('rapid_growth',100,0.45,2600,40,0.05,'Synthetic logistic scenario'),
('low_capacity',100,0.30,600,40,0.05,'Synthetic logistic scenario');

INSERT INTO predator_prey_parameters
(scenario_id, prey0, predator0, alpha, beta, delta, gamma, time_end, dt, notes)
VALUES
('baseline',40,9,0.60,0.025,0.018,0.35,80,0.01,'Synthetic predator-prey scenario'),
('high_predation',40,9,0.60,0.040,0.018,0.35,80,0.01,'Synthetic predator-prey scenario'),
('low_predator_mortality',40,9,0.60,0.025,0.018,0.20,80,0.01,'Synthetic predator-prey scenario'),
('low_prey_growth',40,9,0.35,0.025,0.018,0.35,80,0.01,'Synthetic predator-prey scenario');

INSERT INTO sir_scenarios
(scenario_id, beta, gamma, susceptible0, infected0, recovered0, time_end, dt, notes)
VALUES
('baseline',0.35,0.10,0.99,0.01,0.00,120,0.05,'Synthetic SIR scenario'),
('lower_transmission',0.18,0.10,0.99,0.01,0.00,120,0.05,'Synthetic SIR scenario'),
('faster_recovery',0.35,0.20,0.99,0.01,0.00,120,0.05,'Synthetic SIR scenario'),
('high_transmission',0.55,0.10,0.99,0.01,0.00,120,0.05,'Synthetic SIR scenario');

INSERT INTO enzyme_kinetics
(scenario_id, vmax, km, substrate, notes)
VALUES
('baseline',10.0,2.0,0.1,'Synthetic enzyme scenario'),
('baseline',10.0,2.0,0.5,'Synthetic enzyme scenario'),
('baseline',10.0,2.0,1.0,'Synthetic enzyme scenario'),
('baseline',10.0,2.0,2.0,'Synthetic enzyme scenario'),
('baseline',10.0,2.0,5.0,'Synthetic enzyme scenario'),
('baseline',10.0,2.0,10.0,'Synthetic enzyme scenario'),
('high_affinity',10.0,0.8,0.1,'Synthetic enzyme scenario'),
('high_affinity',10.0,0.8,0.5,'Synthetic enzyme scenario'),
('high_affinity',10.0,0.8,1.0,'Synthetic enzyme scenario'),
('high_affinity',10.0,0.8,2.0,'Synthetic enzyme scenario'),
('high_affinity',10.0,0.8,5.0,'Synthetic enzyme scenario'),
('high_affinity',10.0,0.8,10.0,'Synthetic enzyme scenario');

INSERT INTO network_edges
(source, target, interaction, weight, notes)
VALUES
('gene_A','gene_B','activates',0.8,'Synthetic biological network edge'),
('gene_A','gene_C','represses',0.6,'Synthetic biological network edge'),
('gene_B','gene_D','activates',0.7,'Synthetic biological network edge'),
('gene_C','gene_D','activates',0.5,'Synthetic biological network edge'),
('gene_D','gene_E','represses',0.9,'Synthetic biological network edge'),
('gene_E','gene_A','activates',0.4,'Synthetic biological network edge'),
('gene_B','gene_E','activates',0.3,'Synthetic biological network edge');

INSERT INTO stochastic_scenarios
(scenario_id, initial_population, birth_rate, death_rate, time_end, seed, notes)
VALUES
('supercritical',50,0.30,0.24,50,42,'Synthetic stochastic scenario'),
('critical',50,0.25,0.25,50,43,'Synthetic stochastic scenario'),
('subcritical',50,0.22,0.28,50,44,'Synthetic stochastic scenario'),
('small_population',10,0.30,0.24,50,45,'Synthetic stochastic scenario');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('logistic_scenarios.csv','synthetic_example','constructed_example','logistic growth simulation','MIT-compatible example data','population dynamics setup','Not real population data'),
('predator_prey_parameters.csv','synthetic_example','constructed_example','Lotka-Volterra simulation','MIT-compatible example data','interaction dynamics setup','Simplified predator-prey assumptions'),
('sir_scenarios.csv','synthetic_example','constructed_example','SIR simulation','MIT-compatible example data','epidemic setup','Not public health data'),
('enzyme_kinetics.csv','synthetic_example','constructed_example','Michaelis-Menten velocity calculation','MIT-compatible example data','enzyme kinetics setup','Not empirical assay data'),
('network_edges.csv','synthetic_example','constructed_example','network degree analysis','MIT-compatible example data','network setup','Synthetic network only'),
('stochastic_scenarios.csv','synthetic_example','constructed_example','stochastic birth-death simulation','MIT-compatible example data','stochastic setup','Single-run examples not inferential');
