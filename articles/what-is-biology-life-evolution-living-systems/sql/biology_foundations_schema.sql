-- Biology foundations reproducibility schema.

DROP TABLE IF EXISTS biological_levels;
DROP TABLE IF EXISTS growth_observations;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS hardy_weinberg_cases;
DROP TABLE IF EXISTS biodiversity_counts;
DROP TABLE IF EXISTS sequences;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE biological_levels (
    level_id INTEGER PRIMARY KEY,
    level_name TEXT NOT NULL,
    example TEXT NOT NULL,
    core_question TEXT NOT NULL,
    related_fields TEXT NOT NULL
);

CREATE TABLE growth_observations (
    observation_id INTEGER PRIMARY KEY,
    time REAL NOT NULL,
    population REAL NOT NULL,
    scenario TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE logistic_scenarios (
    scenario TEXT PRIMARY KEY,
    initial_population REAL NOT NULL,
    growth_rate REAL NOT NULL,
    carrying_capacity REAL NOT NULL,
    time_end REAL NOT NULL,
    dt REAL NOT NULL,
    notes TEXT
);

CREATE TABLE hardy_weinberg_cases (
    case_id TEXT PRIMARY KEY,
    allele_frequency_p REAL NOT NULL,
    notes TEXT
);

CREATE TABLE biodiversity_counts (
    site_id TEXT NOT NULL,
    taxon_id TEXT NOT NULL,
    abundance INTEGER NOT NULL,
    PRIMARY KEY (site_id, taxon_id)
);

CREATE TABLE sequences (
    sequence_id TEXT PRIMARY KEY,
    sequence TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    growth_rate REAL,
    doubling_time REAL,
    genotype_AA REAL,
    genotype_Aa REAL,
    genotype_aa REAL,
    shannon_diversity REAL,
    sequence_similarity REAL,
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

INSERT INTO biological_levels
(level_name, example, core_question, related_fields)
VALUES
('molecular','DNA and proteins','How do molecules store information and perform biological work?','molecular biology; biochemistry; genomics'),
('cellular','membranes and organelles','How do cells maintain living organization?','cell biology; microbiology; immunology'),
('tissue','muscle and epithelium','How do specialized cells cooperate?','histology; physiology; pathology'),
('organismal','plant or animal body','How does an individual live develop reproduce and respond?','physiology; development; behavior'),
('population','breeding population','How do groups change across generations?','population biology; genetics; evolution'),
('community','interacting species','How do species coexist compete and cooperate?','ecology; conservation biology'),
('ecosystem','forest wetland or reef','How do energy matter and organisms interact?','ecosystem ecology; restoration ecology'),
('biosphere','planetary life system','How does life persist within Earth systems?','earth system science; biogeochemistry');

INSERT INTO growth_observations
(time, population, scenario, notes)
VALUES
(0,100,'baseline','Synthetic growth observation'),
(2,149,'baseline','Synthetic growth observation'),
(4,222,'baseline','Synthetic growth observation'),
(6,331,'baseline','Synthetic growth observation'),
(8,493,'baseline','Synthetic growth observation'),
(10,735,'baseline','Synthetic growth observation'),
(0,100,'resource_limited','Synthetic growth observation'),
(2,134,'resource_limited','Synthetic growth observation'),
(4,179,'resource_limited','Synthetic growth observation'),
(6,240,'resource_limited','Synthetic growth observation'),
(8,321,'resource_limited','Synthetic growth observation'),
(10,430,'resource_limited','Synthetic growth observation');

INSERT INTO logistic_scenarios
(scenario, initial_population, growth_rate, carrying_capacity, time_end, dt, notes)
VALUES
('baseline',100,0.35,2000,20,0.1,'Synthetic logistic scenario'),
('resource_limited',100,0.22,900,20,0.1,'Synthetic logistic scenario'),
('rapid_growth',100,0.50,2500,20,0.1,'Synthetic logistic scenario'),
('low_capacity',100,0.35,600,20,0.1,'Synthetic logistic scenario');

INSERT INTO hardy_weinberg_cases
(case_id, allele_frequency_p, notes)
VALUES
('case_A',0.70,'Synthetic Hardy-Weinberg case'),
('case_B',0.50,'Synthetic Hardy-Weinberg case'),
('case_C',0.25,'Synthetic Hardy-Weinberg case'),
('case_D',0.90,'Synthetic Hardy-Weinberg case');

INSERT INTO biodiversity_counts
(site_id, taxon_id, abundance)
VALUES
('forest_site','taxon_A',25),('forest_site','taxon_B',18),('forest_site','taxon_C',11),('forest_site','taxon_D',6),('forest_site','taxon_E',4),
('wetland_site','taxon_A',10),('wetland_site','taxon_B',24),('wetland_site','taxon_C',15),('wetland_site','taxon_D',12),('wetland_site','taxon_E',7),
('marine_site','taxon_A',4),('marine_site','taxon_B',8),('marine_site','taxon_C',22),('marine_site','taxon_D',30),('marine_site','taxon_E',18),
('prairie_site','taxon_A',19),('prairie_site','taxon_B',16),('prairie_site','taxon_C',9),('prairie_site','taxon_D',7),('prairie_site','taxon_E',5);

INSERT INTO sequences
(sequence_id, sequence, notes)
VALUES
('reference_A','ATGCTAGCTAAC','Synthetic sequence'),
('reference_B','ATGCTAGCTATC','Synthetic sequence'),
('reference_C','ATGCCAGCTATC','Synthetic sequence'),
('query_001','ATGCTAGCTATC','Synthetic sequence');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('biological_levels.csv','synthetic_educational_table','constructed_example','scale and field summary','MIT-compatible example data','levels setup','Descriptive scaffold only'),
('growth_observations.csv','synthetic_example','constructed_example','exponential growth fitting','MIT-compatible example data','growth setup','Not real population data'),
('logistic_scenarios.csv','synthetic_example','constructed_example','logistic growth simulation','MIT-compatible example data','logistic setup','Not real ecological or microbial data'),
('hardy_weinberg_cases.csv','synthetic_example','constructed_example','Hardy-Weinberg genotype expectations','MIT-compatible example data','population genetics setup','No population structure or selection included'),
('biodiversity_counts.csv','synthetic_example','constructed_example','Shannon diversity and richness summary','MIT-compatible example data','biodiversity setup','Not real biodiversity monitoring data'),
('sequences.csv','synthetic_example','constructed_example','simple aligned sequence similarity','MIT-compatible example data','sequence setup','Not real sequence data');
