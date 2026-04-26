-- Evolution and history of life reproducibility schema.
--
-- This schema tracks evolutionary scenarios, aligned sequences,
-- birth-death diversification scenarios, major transition records,
-- evolutionary condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS evolutionary_scenarios;
DROP TABLE IF EXISTS aligned_sequences;
DROP TABLE IF EXISTS birth_death_scenarios;
DROP TABLE IF EXISTS major_transitions;
DROP TABLE IF EXISTS evolutionary_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE evolutionary_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    generations INTEGER NOT NULL,
    initial_allele_frequency REAL NOT NULL,
    population_size INTEGER NOT NULL,
    fitness_AA REAL NOT NULL,
    fitness_Aa REAL NOT NULL,
    fitness_aa REAL NOT NULL,
    mutation_forward REAL NOT NULL,
    mutation_reverse REAL NOT NULL,
    migration_fraction REAL NOT NULL,
    migrant_allele_frequency REAL NOT NULL,
    drift_enabled TEXT NOT NULL,
    seed INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE aligned_sequences (
    sequence_id INTEGER PRIMARY KEY,
    taxon_name TEXT NOT NULL UNIQUE,
    sequence_text TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE birth_death_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL UNIQUE,
    time_steps INTEGER NOT NULL,
    initial_richness INTEGER NOT NULL,
    lambda_rate REAL NOT NULL,
    mu_rate REAL NOT NULL,
    n_iter INTEGER NOT NULL,
    notes TEXT
);

CREATE TABLE major_transitions (
    transition_id INTEGER PRIMARY KEY,
    transition_name TEXT NOT NULL UNIQUE,
    approximate_context TEXT,
    biological_significance TEXT,
    notes TEXT
);

CREATE TABLE evolutionary_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    standing_variation REAL NOT NULL,
    phylogenetic_signal REAL NOT NULL,
    fossil_record_strength REAL NOT NULL,
    environmental_change REAL NOT NULL,
    extinction_pressure REAL NOT NULL,
    adaptive_capacity REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    allele_frequency REAL,
    expected_heterozygosity REAL,
    mean_fitness REAL,
    p_distance REAL,
    jukes_cantor_distance REAL,
    final_richness REAL,
    peak_richness REAL,
    extinction_probability REAL,
    evolutionary_condition_score REAL,
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

INSERT INTO evolutionary_scenarios
(scenario_name, generations, initial_allele_frequency, population_size, fitness_AA, fitness_Aa, fitness_aa, mutation_forward, mutation_reverse, migration_fraction, migrant_allele_frequency, drift_enabled, seed, notes)
VALUES
('neutral_large_pop', 220, 0.50, 5000, 1.00, 1.00, 1.00, 0.0000, 0.0000, 0.000, 0.50, 'true', 123, 'Synthetic neutral evolutionary scenario'),
('positive_selection', 220, 0.20, 1000, 1.12, 1.05, 1.00, 0.0000, 0.0000, 0.000, 0.50, 'true', 124, 'Synthetic positive selection scenario'),
('migration_selection', 220, 0.80, 1000, 1.08, 1.02, 1.00, 0.0000, 0.0000, 0.030, 0.20, 'true', 125, 'Synthetic migration-selection scenario'),
('mutation_selection_balance', 220, 0.98, 3000, 1.00, 0.97, 0.90, 0.0010, 0.0001, 0.000, 0.50, 'false', 126, 'Synthetic mutation-selection balance scenario');

INSERT INTO aligned_sequences
(taxon_name, sequence_text, notes)
VALUES
('lineage_A', 'ATGCTAGCTAACGGTACCTA', 'Synthetic aligned sequence'),
('lineage_B', 'ATGCTGGCTATCGGTACCTA', 'Synthetic aligned sequence'),
('lineage_C', 'ATGATGGCTATCGGTTCCTA', 'Synthetic aligned sequence'),
('lineage_D', 'ATGCTAGTTAACGGAACCTG', 'Synthetic aligned sequence'),
('lineage_E', 'ATGCTAGCTAACGGAACCTA', 'Synthetic aligned sequence');

INSERT INTO birth_death_scenarios
(scenario_name, time_steps, initial_richness, lambda_rate, mu_rate, n_iter, notes)
VALUES
('net_positive', 150, 8, 0.10, 0.03, 1000, 'Synthetic positive diversification'),
('near_equilibrium', 150, 8, 0.07, 0.06, 1000, 'Synthetic near equilibrium'),
('high_turnover', 150, 8, 0.14, 0.12, 1000, 'Synthetic high turnover'),
('high_extinction', 150, 8, 0.06, 0.11, 1000, 'Synthetic high extinction');

INSERT INTO major_transitions
(transition_name, approximate_context, biological_significance, notes)
VALUES
('origin_of_cellular_life', 'early_earth', 'heritable bounded systems and metabolism', 'Synthetic transition record'),
('prokaryotic_metabolic_diversification', 'early_biosphere', 'microbial transformation of earth systems', 'Synthetic transition record'),
('eukaryotic_cell_origin', 'symbiogenesis_and_intracellular_complexity', 'organelles and expanded regulatory architecture', 'Synthetic transition record'),
('sexual_reproduction', 'genetic_recombination', 'reshuffling of inherited variation', 'Synthetic transition record'),
('multicellularity', 'cellular_cooperation', 'differentiation tissues and organismal complexity', 'Synthetic transition record'),
('land_colonization', 'terrestrial_ecosystems', 'plants fungi animals soils and land food webs', 'Synthetic transition record'),
('flowering_plant_diversification', 'cretaceous_and_after', 'angiosperm pollination fruit and terrestrial ecological restructuring', 'Synthetic transition record'),
('mammalian_radiation', 'cenozoic', 'post-extinction diversification and ecological expansion', 'Synthetic transition record');

INSERT INTO evolutionary_condition_sites
(site_name, standing_variation, phylogenetic_signal, fossil_record_strength, environmental_change, extinction_pressure, adaptive_capacity, notes)
VALUES
('reference_lineage', 0.72, 0.78, 0.70, 0.34, 0.22, 0.68, 'Synthetic evolutionary condition site'),
('fragmented_relict_group', 0.38, 0.74, 0.82, 0.71, 0.76, 0.31, 'Synthetic evolutionary condition site'),
('rapidly_evolving_pathogen', 0.88, 0.52, 0.20, 0.63, 0.35, 0.86, 'Synthetic evolutionary condition site'),
('well_sampled_fossil_clade', 0.55, 0.66, 0.94, 0.42, 0.30, 0.52, 'Synthetic evolutionary condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('evolutionary_scenarios.csv', 'synthetic_example', 'constructed_example', 'selection-mutation-migration-drift simulation', 'MIT-compatible example data', 'allele-frequency evolution setup', 'Not real population-genetic data'),
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence divergence and Jukes-Cantor correction', 'MIT-compatible example data', 'distance-matrix setup', 'Not real sequence data'),
('birth_death_scenarios.csv', 'synthetic_example', 'constructed_example', 'birth-death diversification simulation', 'MIT-compatible example data', 'diversification setup', 'Not real fossil or clade data'),
('major_transitions.csv', 'synthetic_example', 'constructed_example', 'major-transition documentation', 'MIT-compatible example data', 'transition table setup', 'Not a formal historical chronology');
