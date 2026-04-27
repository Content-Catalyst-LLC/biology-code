-- Nonlinearity, feedback, and biological regulation schema.

DROP TABLE IF EXISTS model_catalog;
DROP TABLE IF EXISTS saturating_response_scenarios;
DROP TABLE IF EXISTS hill_scenarios;
DROP TABLE IF EXISTS negative_feedback_scenarios;
DROP TABLE IF EXISTS positive_feedback_scenarios;
DROP TABLE IF EXISTS delayed_feedback_scenarios;
DROP TABLE IF EXISTS logistic_regulation_scenarios;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE model_catalog (
    model_id TEXT PRIMARY KEY,
    model_name TEXT NOT NULL,
    biological_domain TEXT NOT NULL,
    model_type TEXT NOT NULL,
    primary_use TEXT NOT NULL,
    limitations TEXT
);

CREATE TABLE saturating_response_scenarios (
    scenario_id TEXT PRIMARY KEY,
    vmax REAL NOT NULL,
    k_half REAL NOT NULL,
    notes TEXT
);

CREATE TABLE hill_scenarios (
    scenario_id TEXT PRIMARY KEY,
    k_half REAL NOT NULL,
    hill_coefficient REAL NOT NULL,
    notes TEXT
);

CREATE TABLE negative_feedback_scenarios (
    scenario_id TEXT PRIMARY KEY,
    x0 REAL NOT NULL,
    set_point REAL NOT NULL,
    k REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE positive_feedback_scenarios (
    scenario_id TEXT PRIMARY KEY,
    x0 REAL NOT NULL,
    alpha REAL NOT NULL,
    beta REAL NOT NULL,
    k_half REAL NOT NULL,
    hill_coefficient REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE delayed_feedback_scenarios (
    scenario_id TEXT PRIMARY KEY,
    x0 REAL NOT NULL,
    production_rate REAL NOT NULL,
    feedback_strength REAL NOT NULL,
    delay REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE logistic_regulation_scenarios (
    scenario_id TEXT PRIMARY KEY,
    N0 REAL NOT NULL,
    r REAL NOT NULL,
    K REAL NOT NULL,
    dt REAL NOT NULL,
    t_end REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    response_at_20 REAL,
    response_at_40 REAL,
    response_at_60 REAL,
    final_state REAL,
    max_state REAL,
    state_range REAL,
    final_population REAL,
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
(model_id, model_name, biological_domain, model_type, primary_use, limitations)
VALUES
('saturating_response','Saturating response','biochemistry; physiology; microbial growth','nonlinear algebraic response','finite-capacity response modeling','does not capture full mechanism without empirical calibration'),
('hill_function','Hill function','gene regulation; receptor binding; signaling','cooperative nonlinear response','threshold and ultrasensitivity modeling','Hill coefficient can summarize rather than explain mechanism'),
('negative_feedback','Negative feedback return','physiology; homeostasis; control','ordinary differential equation','stabilizing regulation','simplified set point and no delay'),
('positive_feedback','Positive feedback switch','development; signaling; immunity','ordinary differential equation','amplification and switching','bistability requires formal analysis and data support'),
('delayed_feedback','Delayed negative feedback','physiology; gene regulation; oscillation','delay scaffold','delay-driven oscillation exploration','simple discrete delay approximation'),
('logistic_regulation','Logistic regulation','population biology; ecology','ordinary differential equation','density-dependent growth','simplified resource limitation');

INSERT INTO saturating_response_scenarios
(scenario_id, vmax, k_half, notes)
VALUES
('baseline',1.0,20,'Synthetic saturating response'),
('high_capacity',1.5,20,'Synthetic saturating response'),
('low_affinity',1.0,50,'Synthetic saturating response'),
('high_affinity',1.0,8,'Synthetic saturating response');

INSERT INTO hill_scenarios
(scenario_id, k_half, hill_coefficient, notes)
VALUES
('linear_like',40,1,'Synthetic Hill response'),
('moderate_cooperativity',40,2,'Synthetic Hill response'),
('sharp_threshold',40,4,'Synthetic Hill response'),
('ultrasensitive',40,8,'Synthetic Hill response');

INSERT INTO negative_feedback_scenarios
(scenario_id, x0, set_point, k, dt, t_end, notes)
VALUES
('baseline',180,100,0.18,0.05,30,'Synthetic negative feedback scenario'),
('slow_feedback',180,100,0.08,0.05,30,'Synthetic negative feedback scenario'),
('fast_feedback',180,100,0.35,0.05,30,'Synthetic negative feedback scenario'),
('low_perturbation',130,100,0.18,0.05,30,'Synthetic negative feedback scenario');

INSERT INTO positive_feedback_scenarios
(scenario_id, x0, alpha, beta, k_half, hill_coefficient, dt, t_end, notes)
VALUES
('below_threshold',0.1,3.0,0.8,1.5,4,0.01,80,'Synthetic positive feedback scenario'),
('near_threshold',0.8,3.0,0.8,1.5,4,0.01,80,'Synthetic positive feedback scenario'),
('above_threshold',2.0,3.0,0.8,1.5,4,0.01,80,'Synthetic positive feedback scenario'),
('high_initial',5.0,3.0,0.8,1.5,4,0.01,80,'Synthetic positive feedback scenario');

INSERT INTO delayed_feedback_scenarios
(scenario_id, x0, production_rate, feedback_strength, delay, dt, t_end, notes)
VALUES
('short_delay',1.0,1.0,0.8,0.1,0.01,80,'Synthetic delayed feedback scenario'),
('moderate_delay',1.0,1.0,0.8,1.0,0.01,80,'Synthetic delayed feedback scenario'),
('long_delay',1.0,1.0,0.8,4.0,0.01,80,'Synthetic delayed feedback scenario'),
('very_long_delay',1.0,1.0,0.8,8.0,0.01,80,'Synthetic delayed feedback scenario');

INSERT INTO logistic_regulation_scenarios
(scenario_id, N0, r, K, dt, t_end, notes)
VALUES
('baseline',100,0.30,2000,0.05,40,'Synthetic logistic regulation scenario'),
('low_capacity',100,0.30,600,0.05,40,'Synthetic logistic regulation scenario'),
('rapid_growth',100,0.50,2000,0.05,40,'Synthetic logistic regulation scenario'),
('slow_growth',100,0.12,2000,0.05,40,'Synthetic logistic regulation scenario');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('saturating_response_scenarios.csv','synthetic_example','constructed_example','saturating response modeling','MIT-compatible example data','saturation setup','Not empirical biochemical data'),
('hill_scenarios.csv','synthetic_example','constructed_example','Hill threshold modeling','MIT-compatible example data','Hill setup','Cooperativity values illustrative only'),
('negative_feedback_scenarios.csv','synthetic_example','constructed_example','negative feedback ODE','MIT-compatible example data','homeostasis setup','Simplified homeostatic dynamics'),
('positive_feedback_scenarios.csv','synthetic_example','constructed_example','positive feedback switch ODE','MIT-compatible example data','switch setup','Bistability requires formal analysis'),
('delayed_feedback_scenarios.csv','synthetic_example','constructed_example','delayed feedback scaffold','MIT-compatible example data','delay setup','Discrete delay approximation'),
('logistic_regulation_scenarios.csv','synthetic_example','constructed_example','density-dependent logistic ODE','MIT-compatible example data','logistic setup','Simplified density dependence');
