-- Biology and living order reproducibility schema.
--
-- This schema tracks homeostasis scenarios, growth observations,
-- logistic-growth scenarios, feedback scenarios, biological network edges,
-- living-order condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS homeostasis_scenarios;
DROP TABLE IF EXISTS growth_observations;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS feedback_scenarios;
DROP TABLE IF EXISTS network_edges;
DROP TABLE IF EXISTS living_order_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

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
    time REAL NOT NULL,
    abundance REAL NOT NULL,
    condition_name TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE logistic_scenarios (
    scenario_id TEXT PRIMARY KEY,
    initial_abundance REAL NOT NULL,
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE feedback_scenarios (
    scenario_id TEXT PRIMARY KEY,
    state REAL NOT NULL,
    setpoint REAL NOT NULL,
    feedback_gain REAL NOT NULL,
    notes TEXT
);

CREATE TABLE network_edges (
    edge_id INTEGER PRIMARY KEY,
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    interaction_weight REAL NOT NULL,
    interaction_type TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE living_order_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    homeostatic_regulation REAL NOT NULL,
    metabolic_throughput REAL NOT NULL,
    structural_integration REAL NOT NULL,
    developmental_coordination REAL NOT NULL,
    information_continuity REAL NOT NULL,
    ecological_relation REAL NOT NULL,
    stress_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    final_state REAL,
    final_deviation REAL,
    recovery_index REAL,
    growth_rate REAL,
    doubling_time REAL,
    final_abundance REAL,
    fraction_of_capacity REAL,
    corrective_response REAL,
    degree REAL,
    weighted_degree REAL,
    living_order_score REAL,
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

INSERT INTO homeostasis_scenarios
(scenario_id, initial_value, setpoint, correction_rate, time_end, dt, notes)
VALUES
('osmotic_recovery',10,2,0.40,20,0.01,'Synthetic homeostasis scenario'),
('slow_recovery',10,2,0.12,20,0.01,'Synthetic homeostasis scenario'),
('rapid_recovery',10,2,0.85,20,0.01,'Synthetic homeostasis scenario'),
('acid_base_recovery',7.0,7.4,0.30,20,0.01,'Synthetic homeostasis scenario'),
('thermal_recovery',42,37,0.25,20,0.01,'Synthetic homeostasis scenario');

INSERT INTO growth_observations
(time, abundance, condition_name, notes)
VALUES
(0,100,'control','Synthetic growth observation'),
(2,149,'control','Synthetic growth observation'),
(4,222,'control','Synthetic growth observation'),
(6,331,'control','Synthetic growth observation'),
(8,493,'control','Synthetic growth observation'),
(10,735,'control','Synthetic growth observation'),
(0,100,'stress_limited','Synthetic growth observation'),
(2,128,'stress_limited','Synthetic growth observation'),
(4,164,'stress_limited','Synthetic growth observation'),
(6,210,'stress_limited','Synthetic growth observation'),
(8,269,'stress_limited','Synthetic growth observation'),
(10,345,'stress_limited','Synthetic growth observation');

INSERT INTO logistic_scenarios
(scenario_id, initial_abundance, growth_rate, carrying_capacity, time_end, dt, notes)
VALUES
('high_capacity',100,0.35,10000,40,0.5,'Synthetic logistic scenario'),
('resource_limited',100,0.35,1200,40,0.5,'Synthetic logistic scenario'),
('stress_limited',100,0.20,800,40,0.5,'Synthetic logistic scenario'),
('recovery_growth',100,0.28,1500,40,0.5,'Synthetic logistic scenario');

INSERT INTO feedback_scenarios
(scenario_id, state, setpoint, feedback_gain, notes)
VALUES
('low_gain',10,2,0.20,'Synthetic feedback scenario'),
('moderate_gain',10,2,0.50,'Synthetic feedback scenario'),
('high_gain',10,2,0.90,'Synthetic feedback scenario'),
('acid_base',7.0,7.4,0.35,'Synthetic feedback scenario'),
('thermal',42,37,0.30,'Synthetic feedback scenario');

INSERT INTO network_edges
(source, target, interaction_weight, interaction_type, notes)
VALUES
('phytoplankton','zooplankton',0.92,'trophic','Synthetic biological network edge'),
('zooplankton','small_fish',0.80,'trophic','Synthetic biological network edge'),
('small_fish','predator_fish',0.65,'trophic','Synthetic biological network edge'),
('detritus','microbes',0.75,'decomposition','Synthetic biological network edge'),
('microbes','nutrients',0.88,'recycling','Synthetic biological network edge'),
('plants','herbivores',0.70,'trophic','Synthetic biological network edge'),
('soil_fungi','plants',0.77,'symbiosis','Synthetic biological network edge'),
('pollinators','plants',0.73,'mutualism','Synthetic biological network edge'),
('microbiome','host',0.69,'symbiosis','Synthetic biological network edge'),
('predator_fish','nutrients',0.40,'mortality_recycling','Synthetic biological network edge');

INSERT INTO living_order_condition_sites
(site_name, homeostatic_regulation, metabolic_throughput, structural_integration, developmental_coordination, information_continuity, ecological_relation, stress_penalty, notes)
VALUES
('reference_living_system',0.86,0.84,0.82,0.78,0.88,0.80,0.18,'Synthetic living-order condition site'),
('metabolic_stress_state',0.68,0.38,0.70,0.66,0.80,0.72,0.58,'Synthetic living-order condition site'),
('regulatory_failure_state',0.34,0.66,0.70,0.62,0.78,0.68,0.64,'Synthetic living-order condition site'),
('developmental_disruption_state',0.72,0.70,0.66,0.36,0.76,0.68,0.60,'Synthetic living-order condition site'),
('ecosystem_fragmentation_state',0.70,0.72,0.64,0.66,0.74,0.34,0.70,'Synthetic living-order condition site'),
('recovery_state',0.78,0.76,0.74,0.72,0.80,0.76,0.32,'Synthetic living-order condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('homeostasis_scenarios.csv', 'synthetic_example', 'constructed_example', 'homeostatic return and recovery index', 'MIT-compatible example data', 'homeostasis setup', 'Not real physiological data'),
('growth_observations.csv', 'synthetic_example', 'constructed_example', 'exponential growth fitting', 'MIT-compatible example data', 'growth setup', 'Not real growth data'),
('logistic_scenarios.csv', 'synthetic_example', 'constructed_example', 'logistic growth simulation', 'MIT-compatible example data', 'constraint setup', 'Not real population data'),
('feedback_scenarios.csv', 'synthetic_example', 'constructed_example', 'negative feedback response calculation', 'MIT-compatible example data', 'feedback setup', 'Simplified feedback model only'),
('network_edges.csv', 'synthetic_example', 'constructed_example', 'network degree and weighted degree summary', 'MIT-compatible example data', 'network setup', 'Not real ecological network data'),
('living_order_condition_sites.csv', 'synthetic_example', 'constructed_example', 'living-order condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
