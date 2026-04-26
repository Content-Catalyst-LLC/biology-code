-- Biomolecules and chemical basis of life reproducibility schema.
--
-- This schema tracks biomolecular composition measurements, elemental composition,
-- sequence records, enzyme assay conditions, ligand-binding conditions,
-- polymerization examples, biomolecular condition sites, model outputs, and provenance.

DROP TABLE IF EXISTS biomolecule_composition;
DROP TABLE IF EXISTS elemental_composition;
DROP TABLE IF EXISTS sequence_records;
DROP TABLE IF EXISTS enzyme_assays;
DROP TABLE IF EXISTS ligand_binding_assays;
DROP TABLE IF EXISTS polymerization_examples;
DROP TABLE IF EXISTS biomolecular_condition_sites;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE biomolecule_composition (
    sample_id TEXT PRIMARY KEY,
    carbohydrate_mg REAL NOT NULL,
    lipid_mg REAL NOT NULL,
    protein_mg REAL NOT NULL,
    nucleic_acid_mg REAL NOT NULL,
    metabolite_mg REAL NOT NULL,
    notes TEXT
);

CREATE TABLE elemental_composition (
    sample_id TEXT PRIMARY KEY,
    carbon_mmol REAL NOT NULL,
    nitrogen_mmol REAL NOT NULL,
    phosphorus_mmol REAL NOT NULL,
    notes TEXT
);

CREATE TABLE sequence_records (
    sequence_id TEXT PRIMARY KEY,
    sequence_type TEXT NOT NULL,
    sequence TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE enzyme_assays (
    assay_id TEXT PRIMARY KEY,
    substrate_mM REAL NOT NULL,
    Vmax REAL NOT NULL,
    Km REAL NOT NULL,
    notes TEXT
);

CREATE TABLE ligand_binding_assays (
    condition_id TEXT PRIMARY KEY,
    ligand_uM REAL NOT NULL,
    Kd_uM REAL NOT NULL,
    notes TEXT
);

CREATE TABLE polymerization_examples (
    polymer_id TEXT PRIMARY KEY,
    monomer_count INTEGER NOT NULL,
    mean_monomer_mass_Da REAL NOT NULL,
    water_loss_per_bond_Da REAL NOT NULL,
    notes TEXT
);

CREATE TABLE biomolecular_condition_sites (
    site_id INTEGER PRIMARY KEY,
    site_name TEXT NOT NULL UNIQUE,
    carbohydrate_support REAL NOT NULL,
    lipid_boundary_function REAL NOT NULL,
    protein_function REAL NOT NULL,
    nucleic_acid_integrity REAL NOT NULL,
    metabolite_balance REAL NOT NULL,
    cofactor_availability REAL NOT NULL,
    stress_penalty REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    total_biomolecule_mg REAL,
    protein_fraction REAL,
    lipid_fraction REAL,
    carbohydrate_fraction REAL,
    C_to_N REAL,
    C_to_P REAL,
    velocity REAL,
    fraction_bound REAL,
    estimated_polymer_mass_Da REAL,
    gc_content REAL,
    biomolecular_condition_score REAL,
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

INSERT INTO biomolecule_composition
(sample_id, carbohydrate_mg, lipid_mg, protein_mg, nucleic_acid_mg, metabolite_mg, notes)
VALUES
('cell_extract_A',18.2,7.6,31.4,4.8,3.2,'Synthetic biomolecular composition'),
('cell_extract_B',14.5,10.2,28.6,5.1,3.8,'Synthetic biomolecular composition'),
('marine_microbe',9.1,5.7,22.3,3.9,2.9,'Synthetic biomolecular composition'),
('plant_leaf',24.8,8.4,27.5,4.2,5.6,'Synthetic biomolecular composition'),
('fungal_mycelium',16.7,6.8,25.1,4.4,4.9,'Synthetic biomolecular composition');

INSERT INTO elemental_composition
(sample_id, carbon_mmol, nitrogen_mmol, phosphorus_mmol, notes)
VALUES
('cell_extract_A',120.0,18.0,2.1,'Synthetic elemental composition'),
('cell_extract_B',115.0,17.2,2.0,'Synthetic elemental composition'),
('marine_microbe',92.0,14.8,1.7,'Synthetic elemental composition'),
('plant_leaf',150.0,12.5,1.4,'Synthetic elemental composition'),
('fungal_mycelium',108.0,15.6,1.8,'Synthetic elemental composition');

INSERT INTO sequence_records
(sequence_id, sequence_type, sequence, notes)
VALUES
('dna_example_1','DNA','ATGCGCGTATTAACCGGTTAGCGCGATATCGCGTA','Synthetic DNA sequence'),
('dna_example_2','DNA','ATATATGCGCGCGCCCGTATATTAACGCGC','Synthetic DNA sequence'),
('protein_example_1','protein','MKWVTFISLLFLFSSAYSRGVFRRDTHKSEIAHRFKDLGE','Synthetic protein sequence'),
('protein_example_2','protein','MADQLTEEQIAEFKEAFSLFDKDGDGTITTKELGTVMRSL','Synthetic protein sequence');

INSERT INTO enzyme_assays
(assay_id, substrate_mM, Vmax, Km, notes)
VALUES
('baseline_1',0.5,100,3,'Synthetic enzyme assay'),
('baseline_2',1.0,100,3,'Synthetic enzyme assay'),
('baseline_3',2.0,100,3,'Synthetic enzyme assay'),
('baseline_4',5.0,100,3,'Synthetic enzyme assay'),
('baseline_5',10.0,100,3,'Synthetic enzyme assay'),
('baseline_6',20.0,100,3,'Synthetic enzyme assay'),
('high_capacity_1',5.0,140,4,'Synthetic enzyme assay'),
('low_affinity_1',5.0,100,9,'Synthetic enzyme assay');

INSERT INTO ligand_binding_assays
(condition_id, ligand_uM, Kd_uM, notes)
VALUES
('low_ligand',0.5,8,'Synthetic binding condition'),
('moderate_ligand',4,8,'Synthetic binding condition'),
('near_kd',8,8,'Synthetic binding condition'),
('high_ligand',25,8,'Synthetic binding condition'),
('strong_binding',4,2,'Synthetic binding condition'),
('weak_binding',4,20,'Synthetic binding condition');

INSERT INTO polymerization_examples
(polymer_id, monomer_count, mean_monomer_mass_Da, water_loss_per_bond_Da, notes)
VALUES
('short_peptide',12,110,18.015,'Synthetic polymerization example'),
('medium_peptide',75,110,18.015,'Synthetic polymerization example'),
('oligosaccharide',18,180,18.015,'Synthetic polymerization example'),
('dna_fragment',120,330,18.015,'Synthetic polymerization example');

INSERT INTO biomolecular_condition_sites
(site_name, carbohydrate_support, lipid_boundary_function, protein_function, nucleic_acid_integrity, metabolite_balance, cofactor_availability, stress_penalty, notes)
VALUES
('reference_cell_state',0.84,0.82,0.86,0.88,0.80,0.78,0.18,'Synthetic biomolecular condition site'),
('energy_storage_deficit',0.42,0.76,0.74,0.82,0.58,0.70,0.48,'Synthetic biomolecular condition site'),
('membrane_disruption_state',0.72,0.38,0.68,0.80,0.62,0.66,0.60,'Synthetic biomolecular condition site'),
('protein_misfolding_state',0.76,0.72,0.34,0.82,0.60,0.58,0.66,'Synthetic biomolecular condition site'),
('genomic_damage_state',0.78,0.74,0.70,0.36,0.64,0.62,0.70,'Synthetic biomolecular condition site'),
('metabolic_cofactor_limited_state',0.70,0.72,0.62,0.78,0.42,0.30,0.58,'Synthetic biomolecular condition site');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('biomolecule_composition.csv', 'synthetic_example', 'constructed_example', 'biomolecular composition accounting', 'MIT-compatible example data', 'composition setup', 'Not real omics or assay data'),
('elemental_composition.csv', 'synthetic_example', 'constructed_example', 'C:N:P ratio summary', 'MIT-compatible example data', 'elemental ratio setup', 'Not real elemental analysis data'),
('sequences.csv', 'synthetic_example', 'constructed_example', 'sequence composition and feature extraction', 'MIT-compatible example data', 'sequence setup', 'Not real genomic or proteomic data'),
('enzyme_assays.csv', 'synthetic_example', 'constructed_example', 'Michaelis-Menten velocity calculation', 'MIT-compatible example data', 'enzyme assay setup', 'Not real enzyme assay data'),
('ligand_binding.csv', 'synthetic_example', 'constructed_example', 'one-site binding occupancy calculation', 'MIT-compatible example data', 'binding setup', 'Not real binding assay data'),
('polymerization_examples.csv', 'synthetic_example', 'constructed_example', 'polymerization mass-balance estimate', 'MIT-compatible example data', 'polymer setup', 'Approximate educational calculation only'),
('biomolecular_condition_sites.csv', 'synthetic_example', 'constructed_example', 'biomolecular condition scoring', 'MIT-compatible example data', 'condition scoring setup', 'Not a validated biological score');
