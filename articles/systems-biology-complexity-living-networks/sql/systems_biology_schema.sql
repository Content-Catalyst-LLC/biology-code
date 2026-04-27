-- Systems biology and complexity in living networks schema.

DROP TABLE IF EXISTS nodes;
DROP TABLE IF EXISTS interactions;
DROP TABLE IF EXISTS expression_measurements;
DROP TABLE IF EXISTS pathway_gene_sets;
DROP TABLE IF EXISTS feedback_parameters;
DROP TABLE IF EXISTS flux_reactions;
DROP TABLE IF EXISTS stoichiometry;
DROP TABLE IF EXISTS validation_observations;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_records;
DROP TABLE IF EXISTS validation_checks;

CREATE TABLE nodes (
    node_id TEXT PRIMARY KEY,
    node_type TEXT NOT NULL,
    pathway TEXT,
    description TEXT
);

CREATE TABLE interactions (
    interaction_id INTEGER PRIMARY KEY,
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    interaction TEXT NOT NULL,
    sign INTEGER NOT NULL CHECK (sign IN (-1, 1)),
    weight REAL NOT NULL CHECK (weight >= 0),
    evidence_score REAL NOT NULL CHECK (evidence_score >= 0 AND evidence_score <= 1)
);

CREATE TABLE expression_measurements (
    gene TEXT PRIMARY KEY,
    z_score REAL NOT NULL,
    condition TEXT NOT NULL,
    measurement_type TEXT NOT NULL
);

CREATE TABLE pathway_gene_sets (
    pathway TEXT NOT NULL,
    gene TEXT NOT NULL,
    PRIMARY KEY (pathway, gene)
);

CREATE TABLE feedback_parameters (
    scenario TEXT PRIMARY KEY,
    x0 REAL NOT NULL,
    y0 REAL NOT NULL,
    production_x REAL NOT NULL,
    production_y REAL NOT NULL,
    degradation_x REAL NOT NULL,
    degradation_y REAL NOT NULL,
    hill_n REAL NOT NULL,
    dt REAL NOT NULL,
    steps INTEGER NOT NULL
);

CREATE TABLE flux_reactions (
    reaction TEXT PRIMARY KEY,
    lower_bound REAL NOT NULL,
    upper_bound REAL NOT NULL,
    chosen_flux REAL NOT NULL,
    description TEXT
);

CREATE TABLE stoichiometry (
    metabolite TEXT PRIMARY KEY,
    glucose_import REAL NOT NULL,
    glycolysis REAL NOT NULL,
    biomass REAL NOT NULL
);

CREATE TABLE validation_observations (
    node_id TEXT PRIMARY KEY,
    observed_response REAL NOT NULL,
    predicted_response REAL NOT NULL
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

INSERT INTO nodes
(node_id, node_type, pathway, description)
VALUES
('GATA1','gene','differentiation','Transcriptional differentiation regulator'),
('SPI1','gene','differentiation','Transcriptional lineage regulator'),
('MYC','gene','growth','Proliferation-associated transcriptional regulator'),
('MAPK1','protein','signaling','Mitogen-activated kinase scaffold node'),
('AKT1','protein','signaling','Cell survival and growth signaling node'),
('TP53','protein','stress_response','Stress-response and cell-cycle control node'),
('GLUCOSE','metabolite','metabolism','Carbon source metabolite'),
('PYRUVATE','metabolite','metabolism','Central carbon metabolite'),
('BIOMASS','metabolite','metabolism','Abstract biomass precursor');

INSERT INTO interactions
(source, target, interaction, sign, weight, evidence_score)
VALUES
('GATA1','SPI1','inhibits',-1,0.82,0.82),
('SPI1','GATA1','inhibits',-1,0.78,0.78),
('MYC','AKT1','activates',1,0.74,0.74),
('MAPK1','MYC','activates',1,0.69,0.69),
('AKT1','MAPK1','activates',1,0.66,0.66),
('TP53','MYC','inhibits',-1,0.88,0.88),
('TP53','AKT1','inhibits',-1,0.72,0.72),
('MAPK1','TP53','activates',1,0.55,0.55);

INSERT INTO expression_measurements
(gene, z_score, condition, measurement_type)
VALUES
('GATA1',1.20,'perturbed','transcript'),
('SPI1',-0.80,'perturbed','transcript'),
('MYC',1.50,'perturbed','transcript'),
('MAPK1',0.90,'perturbed','protein_activity'),
('AKT1',0.70,'perturbed','protein_activity'),
('TP53',-1.10,'perturbed','protein_activity');

INSERT INTO pathway_gene_sets
(pathway, gene)
VALUES
('differentiation','GATA1'),
('differentiation','SPI1'),
('growth_signaling','MYC'),
('growth_signaling','MAPK1'),
('growth_signaling','AKT1'),
('stress_response','TP53'),
('stress_response','MYC');

INSERT INTO feedback_parameters
(scenario, x0, y0, production_x, production_y, degradation_x, degradation_y, hill_n, dt, steps)
VALUES
('baseline_feedback',0.20,0.10,1.20,0.80,0.40,0.30,2.0,0.10,80),
('strong_feedback',0.20,0.10,1.20,1.10,0.40,0.30,3.0,0.10,80),
('weak_feedback',0.20,0.10,1.20,0.50,0.40,0.30,1.0,0.10,80);

INSERT INTO flux_reactions
(reaction, lower_bound, upper_bound, chosen_flux, description)
VALUES
('glucose_import',0,10,8,'Import of glucose into system'),
('glycolysis',0,10,8,'Conversion of glucose into pyruvate'),
('biomass',0,6,4,'Conversion of pyruvate into biomass precursor');

INSERT INTO stoichiometry
(metabolite, glucose_import, glycolysis, biomass)
VALUES
('GLUCOSE',1,-1,0),
('PYRUVATE',0,2,-2),
('BIOMASS',0,0,1);

INSERT INTO validation_observations
(node_id, observed_response, predicted_response)
VALUES
('GATA1',1.10,1.00),
('SPI1',-0.75,-0.60),
('MYC',1.42,1.55),
('MAPK1',0.82,0.90),
('AKT1',0.68,0.71),
('TP53',-1.05,-0.92);

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'network_summary','nodes.csv;interactions.csv','python/01_network_summary.py','outputs/tables/network_summary.csv','Summarize biological network topology'),
(2,'signal_propagation','interactions.csv','python/02_signal_propagation.py','outputs/simulations/signal_propagation.csv','Simulate directed signal propagation'),
(3,'feedback_dynamics','feedback_parameters.csv','python/03_feedback_dynamics.py','outputs/simulations/feedback_dynamics.csv','Simulate negative-feedback dynamics'),
(4,'pathway_activity','expression.csv;pathway_gene_sets.csv','python/04_pathway_activity.py','outputs/tables/pathway_activity.csv','Calculate pathway activity scores'),
(5,'flux_balance_scaffold','flux_reactions.csv;stoichiometry.csv','python/05_flux_balance_scaffold.py','outputs/tables/flux_balance_residuals.csv','Calculate stoichiometric mass-balance residuals'),
(6,'omics_integration','nodes.csv;interactions.csv;expression.csv;pathway_gene_sets.csv','python/06_omics_integration.py','outputs/tables/omics_network_integration.csv','Integrate omics state with network topology'),
(7,'validation_metrics','validation_observations.csv','python/07_validation_metrics.py','outputs/tables/validation_metrics.csv','Calculate prediction validation metrics'),
(8,'workflow_manifest','workflow_steps.csv','python/08_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record workflow artifacts and checksums'),
(9,'generate_report','network_summary.csv;pathway_activity.csv;validation_metrics.csv','python/09_generate_report.py','outputs/reports/systems_biology_report.md','Generate reproducible systems-biology report');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('nodes.csv','input','archived',NULL,'Synthetic biological nodes'),
('interactions.csv','input','archived',NULL,'Synthetic biological interactions'),
('expression.csv','input','archived',NULL,'Synthetic omics measurements'),
('pathway_gene_sets.csv','input','archived',NULL,'Synthetic pathway gene sets'),
('feedback_parameters.csv','input','archived',NULL,'Synthetic feedback parameters'),
('flux_reactions.csv','input','archived',NULL,'Synthetic flux reaction table'),
('stoichiometry.csv','input','archived',NULL,'Synthetic stoichiometry matrix'),
('network_summary.csv','output','generated',NULL,'Network topology summary'),
('pathway_activity.csv','output','generated',NULL,'Pathway activity table'),
('validation_metrics.csv','output','generated',NULL,'Validation metrics table'),
('systems_biology_report.md','report','generated',NULL,'Generated systems-biology report');

INSERT INTO provenance_records
(operation, input_artifact, output_artifact, script, notes)
SELECT operation, input_artifact, output_artifact, script, notes
FROM workflow_steps;

INSERT INTO validation_checks
(check_name, passed, details)
VALUES
('node_ids_unique',1,'Synthetic node identifiers are unique'),
('interaction_scores_bounded',1,'Evidence scores are between zero and one'),
('feedback_parameters_positive',1,'Feedback rates and time step are positive'),
('flux_bounds_recorded',1,'Flux reaction bounds are recorded'),
('validation_observations_present',1,'Observed and predicted responses are available');
