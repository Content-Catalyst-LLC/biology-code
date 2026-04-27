-- Modeling disease, epidemiology, and biological spread schema.

DROP TABLE IF EXISTS model_scenarios;
DROP TABLE IF EXISTS incidence;
DROP TABLE IF EXISTS forecast_validation;
DROP TABLE IF EXISTS branching_parameters;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_records;
DROP TABLE IF EXISTS validation_checks;

CREATE TABLE model_scenarios (
    scenario TEXT PRIMARY KEY,
    population REAL NOT NULL CHECK (population > 0),
    initial_susceptible REAL NOT NULL CHECK (initial_susceptible >= 0),
    initial_exposed REAL NOT NULL CHECK (initial_exposed >= 0),
    initial_infected REAL NOT NULL CHECK (initial_infected >= 0),
    initial_recovered REAL NOT NULL CHECK (initial_recovered >= 0),
    beta REAL NOT NULL CHECK (beta >= 0),
    sigma REAL NOT NULL CHECK (sigma >= 0),
    gamma REAL NOT NULL CHECK (gamma >= 0),
    dt REAL NOT NULL CHECK (dt > 0),
    steps INTEGER NOT NULL CHECK (steps > 0)
);

CREATE TABLE incidence (
    day INTEGER PRIMARY KEY,
    reported_cases INTEGER NOT NULL CHECK (reported_cases >= 0),
    estimated_reporting_completeness REAL NOT NULL CHECK (estimated_reporting_completeness > 0 AND estimated_reporting_completeness <= 1)
);

CREATE TABLE forecast_validation (
    week INTEGER PRIMARY KEY,
    observed_cases INTEGER NOT NULL CHECK (observed_cases >= 0),
    predicted_cases REAL NOT NULL CHECK (predicted_cases >= 0)
);

CREATE TABLE branching_parameters (
    scenario TEXT PRIMARY KEY,
    initial_cases INTEGER NOT NULL CHECK (initial_cases >= 0),
    reproduction_mean REAL NOT NULL CHECK (reproduction_mean >= 0),
    generations INTEGER NOT NULL CHECK (generations >= 0),
    random_seed INTEGER NOT NULL
);

CREATE TABLE workflow_steps (
    step_id INTEGER PRIMARY KEY,
    operation TEXT NOT NULL,
    input_artifact TEXT NOT NULL,
    script TEXT NOT NULL,
    output_artifact TEXT NOT NULL,
    notes TEXT
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

CREATE TABLE validation_checks (
    check_id INTEGER PRIMARY KEY,
    check_name TEXT NOT NULL,
    passed INTEGER NOT NULL,
    details TEXT,
    checked_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO model_scenarios
(scenario, population, initial_susceptible, initial_exposed, initial_infected, initial_recovered, beta, sigma, gamma, dt, steps)
VALUES
('baseline',10000,9970,20,10,0,0.32,0.20,0.10,0.25,240),
('reduced_transmission',10000,9970,20,10,0,0.22,0.20,0.10,0.25,240),
('faster_recovery',10000,9970,20,10,0,0.32,0.20,0.16,0.25,240),
('high_transmission',10000,9970,20,10,0,0.45,0.20,0.10,0.25,240);

INSERT INTO incidence
(day, reported_cases, estimated_reporting_completeness)
VALUES
(1,12,1.00),
(2,15,1.00),
(3,18,0.98),
(4,21,0.95),
(5,25,0.90),
(6,31,0.82),
(7,38,0.72),
(8,46,0.60),
(9,51,0.45),
(10,60,0.32);

INSERT INTO forecast_validation
(week, observed_cases, predicted_cases)
VALUES
(1,120,110),
(2,145,152),
(3,162,158),
(4,150,171),
(5,138,132),
(6,126,119);

INSERT INTO branching_parameters
(scenario, initial_cases, reproduction_mean, generations, random_seed)
VALUES
('baseline_branching',5,1.30,10,7),
('subcritical_branching',5,0.80,10,11),
('supercritical_branching',5,1.80,10,19);

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'sir_model','model_scenarios.csv','python/01_sir_model.py','outputs/simulations/sir_outputs.csv','Run SIR simulations across scenarios'),
(2,'seir_model','model_scenarios.csv','python/02_seir_model.py','outputs/simulations/seir_outputs.csv','Run SEIR simulations across scenarios'),
(3,'rt_proxy','incidence.csv','python/03_rt_proxy.py','outputs/tables/rt_proxy.csv','Estimate simple growth-rate Rt proxy'),
(4,'branching_process','branching_parameters.csv','python/04_branching_process.py','outputs/simulations/branching_process.csv','Simulate stochastic generational spread'),
(5,'reporting_delay_adjustment','incidence.csv','python/05_reporting_delay_adjustment.py','outputs/tables/reporting_delay_adjustment.csv','Adjust reported cases by completeness'),
(6,'validation_metrics','forecast_validation.csv','python/06_validation_metrics.py','outputs/tables/validation_metrics.csv','Calculate forecast validation metrics'),
(7,'workflow_manifest','workflow_steps.csv','python/07_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record workflow artifacts and checksums'),
(8,'generate_report','sir_summary.csv;seir_summary.csv;validation_metrics.csv','python/08_generate_report.py','outputs/reports/epidemiology_modeling_report.md','Generate reproducible modeling report');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('model_scenarios.csv','input','archived',NULL,'Synthetic model scenarios'),
('incidence.csv','input','archived',NULL,'Synthetic reported incidence table'),
('forecast_validation.csv','input','archived',NULL,'Synthetic forecast validation data'),
('branching_parameters.csv','input','archived',NULL,'Synthetic branching process parameters'),
('sir_outputs.csv','output','generated',NULL,'SIR simulation output'),
('seir_outputs.csv','output','generated',NULL,'SEIR simulation output'),
('rt_proxy.csv','output','generated',NULL,'Rt proxy scaffold output'),
('branching_process.csv','output','generated',NULL,'Branching process output'),
('reporting_delay_adjustment.csv','output','generated',NULL,'Reporting delay adjustment output'),
('validation_metrics.csv','output','generated',NULL,'Forecast validation metrics'),
('epidemiology_modeling_report.md','report','generated',NULL,'Generated modeling report');

INSERT INTO provenance_records
(operation, input_artifact, output_artifact, script, notes)
SELECT operation, input_artifact, output_artifact, script, notes
FROM workflow_steps;

INSERT INTO validation_checks
(check_name, passed, details)
VALUES
('scenario_ids_unique',1,'Synthetic scenario identifiers are unique'),
('rates_nonnegative',1,'Transmission, progression, and recovery rates are nonnegative'),
('reporting_completeness_bounded',1,'Reporting completeness values are between zero and one'),
('forecast_counts_nonnegative',1,'Observed and predicted counts are nonnegative');
