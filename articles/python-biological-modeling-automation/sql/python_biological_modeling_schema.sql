-- Python for biological modeling and automation schema.

DROP TABLE IF EXISTS logistic_parameters;
DROP TABLE IF EXISTS compartment_parameters;
DROP TABLE IF EXISTS parameter_rules;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS validation_checks;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE logistic_parameters (
    scenario TEXT PRIMARY KEY,
    initial_population REAL NOT NULL CHECK (initial_population >= 0),
    growth_rate REAL NOT NULL CHECK (growth_rate >= 0),
    carrying_capacity REAL NOT NULL CHECK (carrying_capacity > 0),
    dt REAL NOT NULL CHECK (dt > 0),
    steps INTEGER NOT NULL CHECK (steps > 0),
    unit_time TEXT NOT NULL,
    unit_population TEXT NOT NULL
);

CREATE TABLE compartment_parameters (
    scenario TEXT PRIMARY KEY,
    initial_a REAL NOT NULL CHECK (initial_a >= 0),
    initial_b REAL NOT NULL CHECK (initial_b >= 0),
    k_ab REAL NOT NULL CHECK (k_ab >= 0),
    k_ba REAL NOT NULL CHECK (k_ba >= 0),
    k_clear REAL NOT NULL CHECK (k_clear >= 0),
    dt REAL NOT NULL CHECK (dt > 0),
    steps INTEGER NOT NULL CHECK (steps > 0),
    unit_time TEXT NOT NULL,
    unit_amount TEXT NOT NULL
);

CREATE TABLE parameter_rules (
    parameter TEXT PRIMARY KEY,
    lower_bound REAL NOT NULL,
    upper_bound REAL NOT NULL,
    unit TEXT,
    description TEXT
);

CREATE TABLE workflow_steps (
    step_id INTEGER PRIMARY KEY,
    operation TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    script TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario TEXT NOT NULL,
    output_metric TEXT NOT NULL,
    output_value REAL NOT NULL,
    unit TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE validation_checks (
    check_id INTEGER PRIMARY KEY,
    table_name TEXT NOT NULL,
    parameter TEXT NOT NULL,
    value REAL,
    passed INTEGER NOT NULL,
    message TEXT,
    checked_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE artifacts (
    artifact_id INTEGER PRIMARY KEY,
    artifact_name TEXT NOT NULL,
    artifact_role TEXT NOT NULL,
    status TEXT NOT NULL,
    sha256 TEXT,
    notes TEXT
);

CREATE TABLE provenance_records (
    provenance_id INTEGER PRIMARY KEY,
    operation TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    script TEXT NOT NULL,
    notes TEXT,
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO logistic_parameters
(scenario, initial_population, growth_rate, carrying_capacity, dt, steps, unit_time, unit_population)
VALUES
('low_growth',25,0.15,1000,0.1,200,'days','individuals'),
('baseline',25,0.35,1000,0.1,200,'days','individuals'),
('high_growth',25,0.55,1000,0.1,200,'days','individuals'),
('high_capacity',25,0.35,1500,0.1,200,'days','individuals');

INSERT INTO compartment_parameters
(scenario, initial_a, initial_b, k_ab, k_ba, k_clear, dt, steps, unit_time, unit_amount)
VALUES
('baseline_exchange',100,0,0.18,0.07,0.03,0.1,150,'hours','relative_amount'),
('rapid_exchange',100,0,0.32,0.12,0.03,0.1,150,'hours','relative_amount'),
('slow_clearance',100,0,0.18,0.07,0.01,0.1,150,'hours','relative_amount'),
('high_clearance',100,0,0.18,0.07,0.08,0.1,150,'hours','relative_amount');

INSERT INTO parameter_rules
(parameter, lower_bound, upper_bound, unit, description)
VALUES
('initial_population',0,1000000,'individuals','Initial population size'),
('growth_rate',0,5,'per_day','Intrinsic growth rate'),
('carrying_capacity',1,10000000,'individuals','Environmental carrying capacity'),
('dt',0.0001,10,'time_step','Simulation time step'),
('steps',1,100000,'count','Number of simulation steps'),
('initial_a',0,1000000,'relative_amount','Initial amount in compartment A'),
('initial_b',0,1000000,'relative_amount','Initial amount in compartment B'),
('k_ab',0,10,'per_hour','Transfer rate from compartment A to B'),
('k_ba',0,10,'per_hour','Transfer rate from compartment B to A'),
('k_clear',0,10,'per_hour','Clearance rate from compartment A');

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'validate_parameters','logistic_parameters.csv;compartment_parameters.csv;parameter_rules.csv','python/01_validate_parameters.py','outputs/tables/parameter_validation_report.csv','Validate model parameter ranges and required fields'),
(2,'run_logistic_model','logistic_parameters.csv','python/02_logistic_growth_model.py','outputs/simulations/logistic_growth_outputs.csv','Run deterministic logistic growth scenarios'),
(3,'run_two_compartment_model','compartment_parameters.csv','python/03_two_compartment_model.py','outputs/simulations/two_compartment_outputs.csv','Run two-compartment biological model scenarios'),
(4,'run_parameter_sweep','logistic_parameters.csv;compartment_parameters.csv','python/04_parameter_sweep.py','outputs/tables/parameter_sweep_summary.csv','Summarize final outputs across scenarios'),
(5,'sensitivity_summary','parameter_sweep_summary.csv','python/05_sensitivity_summary.py','outputs/tables/sensitivity_summary.csv','Estimate simple scenario-level sensitivity'),
(6,'workflow_manifest','workflow_steps.csv','python/06_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record workflow artifacts and checksums'),
(7,'generate_report','parameter_sweep_summary.csv;sensitivity_summary.csv','python/07_generate_report.py','outputs/reports/modeling_report.md','Generate reproducible text report');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('logistic_parameters.csv','input','archived',NULL,'Synthetic logistic model parameters'),
('compartment_parameters.csv','input','archived',NULL,'Synthetic compartment model parameters'),
('parameter_rules.csv','input','archived',NULL,'Synthetic validation rules'),
('logistic_growth_outputs.csv','output','generated',NULL,'Logistic-growth simulation outputs'),
('two_compartment_outputs.csv','output','generated',NULL,'Two-compartment simulation outputs'),
('parameter_sweep_summary.csv','output','generated',NULL,'Parameter sweep summary'),
('sensitivity_summary.csv','output','generated',NULL,'Scenario sensitivity summary'),
('modeling_report.md','report','generated',NULL,'Generated reproducible report');

INSERT INTO provenance_records
(operation, input_artifact, output_artifact, script, notes)
SELECT operation, input_artifact, output_artifact, script, notes
FROM workflow_steps;
