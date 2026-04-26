-- Modern biological thought reproducibility schema.

DROP TABLE IF EXISTS historical_milestones;
DROP TABLE IF EXISTS growth_observations;
DROP TABLE IF EXISTS logistic_scenarios;
DROP TABLE IF EXISTS hardy_weinberg_cases;
DROP TABLE IF EXISTS selection_scenarios;
DROP TABLE IF EXISTS sequences;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE historical_milestones (
    milestone_id INTEGER PRIMARY KEY,
    year INTEGER NOT NULL,
    milestone TEXT NOT NULL,
    domain TEXT NOT NULL,
    notes TEXT
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

CREATE TABLE selection_scenarios (
    scenario TEXT PRIMARY KEY,
    p_initial REAL NOT NULL,
    w_AA REAL NOT NULL,
    w_Aa REAL NOT NULL,
    w_aa REAL NOT NULL,
    generations INTEGER NOT NULL,
    notes TEXT
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
    allele_frequency_p REAL,
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

INSERT INTO historical_milestones
(year, milestone, domain, notes)
VALUES
(1543,'Vesalian anatomy','anatomy','Modern anatomical observation and direct dissection'),
(1628,'Harvey circulation','physiology','Circulation as physiological mechanism'),
(1665,'Hooke micrographia','microscopy','Microscopic observation and cell terminology'),
(1670,'Leeuwenhoek microorganisms','microbiology','Observation of microscopic life'),
(1735,'Linnaean classification','taxonomy','Systematic biological naming and ordering'),
(1838,'Schleiden cell theory','cell biology','Cellular organization in plants'),
(1839,'Schwann cell theory','cell biology','Cellular organization across animals and plants'),
(1855,'Virchow cellular pathology','cell biology','Cells arise from cells and pathology becomes cellular'),
(1859,'Darwin origin','evolution','Common descent and natural selection'),
(1866,'Mendel inheritance','genetics','Formal inheritance patterns'),
(1900,'Rediscovery of Mendel','genetics','Modern genetics accelerates'),
(1930,'Population genetics','quantitative biology','Mathematical evolutionary synthesis'),
(1953,'DNA double helix','molecular biology','Molecular structure of heredity'),
(1977,'DNA sequencing','molecular biology','Sequence-based molecular biology'),
(1990,'Human Genome Project','genomics','Large-scale genomic infrastructure'),
(2000,'Systems biology expansion','systems biology','Networks data and multi-scale biological modeling');

INSERT INTO growth_observations
(time, population, scenario, notes)
VALUES
(0,100,'baseline','Synthetic growth observation'),
(2,148,'baseline','Synthetic growth observation'),
(4,219,'baseline','Synthetic growth observation'),
(6,324,'baseline','Synthetic growth observation'),
(8,479,'baseline','Synthetic growth observation'),
(10,708,'baseline','Synthetic growth observation'),
(0,100,'slower_growth','Synthetic growth observation'),
(2,132,'slower_growth','Synthetic growth observation'),
(4,174,'slower_growth','Synthetic growth observation'),
(6,230,'slower_growth','Synthetic growth observation'),
(8,303,'slower_growth','Synthetic growth observation'),
(10,400,'slower_growth','Synthetic growth observation');

INSERT INTO logistic_scenarios
(scenario, initial_population, growth_rate, carrying_capacity, time_end, dt, notes)
VALUES
('baseline',100,0.35,2000,20,0.1,'Synthetic logistic scenario'),
('resource_limited',100,0.25,900,20,0.1,'Synthetic logistic scenario'),
('high_growth',100,0.50,2500,20,0.1,'Synthetic logistic scenario'),
('low_capacity',100,0.35,600,20,0.1,'Synthetic logistic scenario');

INSERT INTO hardy_weinberg_cases
(case_id, allele_frequency_p, notes)
VALUES
('case_A',0.70,'Synthetic Hardy-Weinberg case'),
('case_B',0.50,'Synthetic Hardy-Weinberg case'),
('case_C',0.25,'Synthetic Hardy-Weinberg case'),
('case_D',0.90,'Synthetic Hardy-Weinberg case');

INSERT INTO selection_scenarios
(scenario, p_initial, w_AA, w_Aa, w_aa, generations, notes)
VALUES
('neutral',0.50,1.00,1.00,1.00,20,'Synthetic selection scenario'),
('directional_A',0.50,1.10,1.05,1.00,20,'Synthetic selection scenario'),
('heterozygote_advantage',0.50,0.90,1.10,0.90,20,'Synthetic selection scenario'),
('against_AA',0.70,0.80,1.00,1.00,20,'Synthetic selection scenario');

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
('historical_milestones.csv','synthetic_educational_timeline','constructed_example','timeline grouping and domain summaries','MIT-compatible example data','timeline setup','Milestones are simplified and selective'),
('growth_observations.csv','synthetic_example','constructed_example','exponential growth fitting','MIT-compatible example data','growth setup','Not real population data'),
('logistic_scenarios.csv','synthetic_example','constructed_example','logistic growth simulation','MIT-compatible example data','logistic setup','Not real ecological or microbial data'),
('hardy_weinberg_cases.csv','synthetic_example','constructed_example','Hardy-Weinberg genotype expectations','MIT-compatible example data','population genetics setup','No population structure or selection included'),
('selection_scenarios.csv','synthetic_example','constructed_example','viability selection recurrence','MIT-compatible example data','selection setup','Simplified deterministic model'),
('sequences.csv','synthetic_example','constructed_example','simple aligned sequence similarity','MIT-compatible example data','sequence setup','Not real sequence data');
