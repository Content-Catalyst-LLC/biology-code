-- Networks, systems, and biological complexity schema.

DROP TABLE IF EXISTS biological_nodes;
DROP TABLE IF EXISTS biological_edges;
DROP TABLE IF EXISTS food_web_edges;
DROP TABLE IF EXISTS microbiome_associations;
DROP TABLE IF EXISTS diffusion_initial_state;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE biological_nodes (
    node_id TEXT PRIMARY KEY,
    module_name TEXT NOT NULL,
    node_type TEXT NOT NULL,
    description TEXT
);

CREATE TABLE biological_edges (
    edge_id INTEGER PRIMARY KEY,
    source_node TEXT NOT NULL,
    target_node TEXT NOT NULL,
    weight REAL NOT NULL,
    interaction_type TEXT NOT NULL,
    module_hint TEXT,
    directed INTEGER DEFAULT 0,
    notes TEXT
);

CREATE TABLE food_web_edges (
    edge_id INTEGER PRIMARY KEY,
    source_node TEXT NOT NULL,
    target_node TEXT NOT NULL,
    weight REAL NOT NULL,
    interaction_type TEXT NOT NULL,
    module_hint TEXT,
    notes TEXT
);

CREATE TABLE microbiome_associations (
    association_id INTEGER PRIMARY KEY,
    taxon_a TEXT NOT NULL,
    taxon_b TEXT NOT NULL,
    association_strength REAL NOT NULL,
    association_type TEXT NOT NULL,
    module_hint TEXT,
    notes TEXT
);

CREATE TABLE diffusion_initial_state (
    node_id TEXT PRIMARY KEY,
    initial_state REAL NOT NULL,
    notes TEXT
);

CREATE TABLE model_outputs (
    output_id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    scenario_name TEXT NOT NULL,
    n_nodes INTEGER,
    n_edges INTEGER,
    density REAL,
    mean_degree REAL,
    max_degree REAL,
    mean_weighted_degree REAL,
    final_state_sum REAL,
    robustness_value REAL,
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

INSERT INTO biological_nodes
(node_id, module_name, node_type, description)
VALUES
('gene_A','regulation','gene','synthetic regulatory source'),
('gene_B','regulation','gene','synthetic regulatory target'),
('gene_C','regulation','gene','synthetic regulatory branch'),
('gene_D','regulation','gene','synthetic convergence node'),
('gene_E','metabolism','metabolite','synthetic metabolic intermediate'),
('gene_F','metabolism','enzyme','synthetic metabolic regulator'),
('gene_G','signaling','protein','synthetic signaling node'),
('gene_H','signaling','protein','synthetic signal relay'),
('gene_I','signaling','protein','synthetic signal relay'),
('gene_J','signaling','gene','synthetic response node');

INSERT INTO biological_edges
(source_node, target_node, weight, interaction_type, module_hint, directed, notes)
VALUES
('gene_A','gene_B',1.0,'activation','regulation',0,'Synthetic biological network edge'),
('gene_A','gene_C',0.8,'activation','regulation',0,'Synthetic biological network edge'),
('gene_B','gene_D',0.7,'repression','regulation',0,'Synthetic biological network edge'),
('gene_C','gene_D',1.2,'activation','regulation',0,'Synthetic biological network edge'),
('gene_D','gene_E',0.9,'signal','metabolism',0,'Synthetic biological network edge'),
('gene_E','gene_F',1.1,'conversion','metabolism',0,'Synthetic biological network edge'),
('gene_F','gene_G',0.6,'signal','signaling',0,'Synthetic biological network edge'),
('gene_G','gene_H',0.5,'activation','signaling',0,'Synthetic biological network edge'),
('gene_H','gene_I',0.7,'activation','signaling',0,'Synthetic biological network edge'),
('gene_I','gene_J',1.0,'activation','signaling',0,'Synthetic biological network edge'),
('gene_C','gene_G',0.4,'cross_module','bridge',0,'Synthetic biological network edge'),
('gene_F','gene_J',0.3,'cross_module','bridge',0,'Synthetic biological network edge');

INSERT INTO food_web_edges
(source_node, target_node, weight, interaction_type, module_hint, notes)
VALUES
('phytoplankton','zooplankton',0.9,'consumed_by','marine_food_web','Synthetic food web edge'),
('zooplankton','small_fish',0.8,'consumed_by','marine_food_web','Synthetic food web edge'),
('small_fish','large_fish',0.7,'consumed_by','marine_food_web','Synthetic food web edge'),
('large_fish','seal',0.5,'consumed_by','marine_food_web','Synthetic food web edge'),
('detritus','microbes',0.9,'consumed_by','decomposition','Synthetic food web edge'),
('microbes','zooplankton',0.4,'consumed_by','microbial_loop','Synthetic food web edge'),
('macroalgae','herbivore',0.6,'consumed_by','coastal_food_web','Synthetic food web edge'),
('herbivore','predator',0.5,'consumed_by','coastal_food_web','Synthetic food web edge');

INSERT INTO microbiome_associations
(taxon_a, taxon_b, association_strength, association_type, module_hint, notes)
VALUES
('taxon_01','taxon_02',0.72,'positive','fermentation','Synthetic association'),
('taxon_01','taxon_03',-0.31,'negative','fermentation','Synthetic association'),
('taxon_02','taxon_04',0.44,'positive','fermentation','Synthetic association'),
('taxon_03','taxon_05',0.60,'positive','stress_response','Synthetic association'),
('taxon_04','taxon_06',-0.40,'negative','stress_response','Synthetic association'),
('taxon_05','taxon_06',0.58,'positive','stress_response','Synthetic association'),
('taxon_06','taxon_07',0.35,'positive','nutrient_cycle','Synthetic association'),
('taxon_07','taxon_08',0.51,'positive','nutrient_cycle','Synthetic association');

INSERT INTO diffusion_initial_state
(node_id, initial_state, notes)
VALUES
('gene_A',1.0,'Synthetic perturbation source'),
('gene_B',0.0,'Synthetic initial state'),
('gene_C',0.0,'Synthetic initial state'),
('gene_D',0.0,'Synthetic initial state'),
('gene_E',0.0,'Synthetic initial state'),
('gene_F',0.0,'Synthetic initial state'),
('gene_G',0.0,'Synthetic initial state'),
('gene_H',0.0,'Synthetic initial state'),
('gene_I',0.0,'Synthetic initial state'),
('gene_J',0.0,'Synthetic initial state');

INSERT INTO provenance_records
(dataset_name, source_name, observation_method, analytical_method, license, processing_step, uncertainty_notes)
VALUES
('biological_network_edges.csv','synthetic_example','constructed_example','graph metric and diffusion scaffold','MIT-compatible example data','network setup','Not empirical biological network data'),
('biological_network_nodes.csv','synthetic_example','constructed_example','module mapping','MIT-compatible example data','node metadata setup','Synthetic module assignments'),
('food_web_edges.csv','synthetic_example','constructed_example','ecological food-web scaffold','MIT-compatible example data','food-web setup','Synthetic food-web relationships'),
('microbiome_associations.csv','synthetic_example','constructed_example','association network scaffold','MIT-compatible example data','microbiome setup','Associations are synthetic and not causal'),
('diffusion_initial_state.csv','synthetic_example','constructed_example','network diffusion initial conditions','MIT-compatible example data','diffusion setup','Synthetic perturbation state');
