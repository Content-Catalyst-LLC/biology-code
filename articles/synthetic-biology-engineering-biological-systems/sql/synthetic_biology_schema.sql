DROP TABLE IF EXISTS designs;
DROP TABLE IF EXISTS construct_parts;
DROP TABLE IF EXISTS biosensor_measurements;
DROP TABLE IF EXISTS host_burden;
DROP TABLE IF EXISTS metabolic_runs;
DROP TABLE IF EXISTS dbtl_cycles;
DROP TABLE IF EXISTS biosafety_notes;
DROP TABLE IF EXISTS provenance_artifacts;

CREATE TABLE designs (
    design_id TEXT PRIMARY KEY,
    construct_type TEXT NOT NULL,
    chassis TEXT NOT NULL,
    output_signal REAL NOT NULL,
    host_burden REAL NOT NULL,
    genetic_stability REAL NOT NULL,
    measurement_uncertainty REAL NOT NULL,
    dbtl_cycle INTEGER NOT NULL
);

CREATE TABLE construct_parts (
    part_record_id INTEGER PRIMARY KEY AUTOINCREMENT,
    design_id TEXT NOT NULL,
    part_id TEXT NOT NULL,
    part_type TEXT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (design_id) REFERENCES designs(design_id)
);

CREATE TABLE biosensor_measurements (
    design_id TEXT PRIMARY KEY,
    mean_signal REAL NOT NULL,
    mean_background REAL NOT NULL,
    background_sd REAL NOT NULL,
    input_condition TEXT NOT NULL,
    measurement_unit TEXT NOT NULL,
    FOREIGN KEY (design_id) REFERENCES designs(design_id)
);

CREATE TABLE host_burden (
    design_id TEXT PRIMARY KEY,
    chassis TEXT NOT NULL,
    growth_rate_engineered REAL NOT NULL,
    growth_rate_control REAL NOT NULL,
    medium TEXT NOT NULL,
    temperature_c REAL NOT NULL,
    FOREIGN KEY (design_id) REFERENCES designs(design_id)
);

CREATE TABLE metabolic_runs (
    run_id TEXT PRIMARY KEY,
    design_id TEXT NOT NULL,
    substrate_consumed_g_l REAL NOT NULL,
    product_formed_g_l REAL NOT NULL,
    product_name TEXT NOT NULL,
    fermentation_hours REAL NOT NULL,
    FOREIGN KEY (design_id) REFERENCES designs(design_id)
);

CREATE TABLE dbtl_cycles (
    cycle_id INTEGER PRIMARY KEY,
    design_goal TEXT NOT NULL,
    build_method TEXT NOT NULL,
    test_method TEXT NOT NULL,
    learn_output TEXT NOT NULL
);

CREATE TABLE biosafety_notes (
    note_id INTEGER PRIMARY KEY AUTOINCREMENT,
    topic TEXT NOT NULL,
    note TEXT NOT NULL
);

CREATE TABLE provenance_artifacts (
    artifact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    artifact_name TEXT NOT NULL,
    artifact_type TEXT NOT NULL,
    relative_path TEXT NOT NULL,
    checksum_sha256 TEXT,
    notes TEXT
);

INSERT INTO designs VALUES
('D001','biosensor','E_coli',0.82,0.18,0.72,0.12,1),
('D002','biosensor','E_coli',0.68,0.10,0.84,0.10,1),
('D003','metabolic_pathway','S_cerevisiae',0.74,0.35,0.55,0.18,1),
('D004','metabolic_pathway','S_cerevisiae',0.61,0.22,0.70,0.14,2),
('D005','genetic_circuit','B_subtilis',0.77,0.28,0.66,0.16,2),
('D006','cell_free_sensor','cell_free_extract',0.88,0.00,0.80,0.09,2);

INSERT INTO construct_parts (design_id, part_id, part_type, description) VALUES
('D001','P001','promoter','Inducible promoter placeholder'),
('D001','R001','ribosome_binding_site','Translation initiation placeholder'),
('D001','C001','coding_sequence','Reporter coding sequence placeholder'),
('D001','T001','terminator','Transcription terminator placeholder'),
('D003','P002','promoter','Pathway promoter placeholder'),
('D003','C002','coding_sequence','Enzyme module placeholder'),
('D003','C003','coding_sequence','Transport module placeholder'),
('D005','P003','promoter','Circuit promoter placeholder'),
('D005','C004','coding_sequence','Regulatory protein placeholder'),
('D006','C005','cell_free_template','Cell-free expression template placeholder');

INSERT INTO biosensor_measurements VALUES
('D001',1250.0,220.0,65.0,'induced','relative_fluorescence'),
('D002',980.0,210.0,80.0,'induced','relative_fluorescence'),
('D003',1430.0,410.0,120.0,'induced','relative_fluorescence'),
('D005',1100.0,260.0,90.0,'induced','relative_fluorescence'),
('D006',1560.0,300.0,75.0,'induced','relative_fluorescence');

INSERT INTO host_burden VALUES
('D001','E_coli',0.82,1.00,'LB',37),
('D002','E_coli',0.91,1.00,'LB',37),
('D003','S_cerevisiae',0.63,0.95,'YPD',30),
('D004','S_cerevisiae',0.77,0.95,'YPD',30),
('D005','B_subtilis',0.70,0.92,'LB',37),
('D006','cell_free_extract',0.00,0.00,'cell_free',25);

INSERT INTO metabolic_runs VALUES
('R001','D003',10.0,2.4,'synthetic_product_A',24),
('R002','D003',10.0,3.1,'synthetic_product_A',36),
('R003','D004',12.0,3.0,'synthetic_product_A',24),
('R004','D004',12.0,3.8,'synthetic_product_A',36);

INSERT INTO dbtl_cycles VALUES
(1,'Initial biosensor and pathway comparison','Synthetic construct assembly placeholder','Plate-reader and growth measurement placeholder','Identify burden and signal limitations'),
(2,'Improved stability and output','Promoter tuning and chassis/context revision placeholder','Repeat performance and burden testing placeholder','Prioritize stable high-signal designs');

INSERT INTO biosafety_notes (topic, note) VALUES
('containment','Educational synthetic biology workflows should not be interpreted as instructions for organism construction.'),
('measurement','Performance scores require calibrated measurement and biological replication.'),
('biosecurity','Sequence design and synthesis workflows require appropriate screening and institutional oversight.'),
('ecology','Environmental applications require ecological assessment and public accountability.');

INSERT INTO provenance_artifacts (artifact_name, artifact_type, relative_path, checksum_sha256, notes) VALUES
('synthetic_biology_designs.csv','synthetic_data','data/synthetic_biology_designs.csv',NULL,'Synthetic DBTL design dataset'),
('biosensor_measurements.csv','synthetic_data','data/biosensor_measurements.csv',NULL,'Synthetic biosensor measurement dataset'),
('host_burden.csv','synthetic_data','data/host_burden.csv',NULL,'Synthetic host-burden dataset'),
('metabolic_runs.csv','synthetic_data','data/metabolic_runs.csv',NULL,'Synthetic metabolic-yield dataset');
