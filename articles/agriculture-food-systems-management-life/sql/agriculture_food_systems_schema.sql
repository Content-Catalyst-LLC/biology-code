DROP TABLE IF EXISTS production_systems;
DROP TABLE IF EXISTS biodiversity_resilience;
DROP TABLE IF EXISTS soil_carbon;
DROP TABLE IF EXISTS diet_diversity;
DROP TABLE IF EXISTS food_loss_stages;
DROP TABLE IF EXISTS governance_notes;
DROP TABLE IF EXISTS provenance_artifacts;

CREATE TABLE production_systems (
    system TEXT PRIMARY KEY,
    production_tonnes REAL NOT NULL,
    area_hectares REAL NOT NULL,
    water_used_m3 REAL NOT NULL,
    nutrient_input_kg REAL NOT NULL,
    nutrient_harvested_kg REAL NOT NULL,
    food_lost_tonnes REAL NOT NULL,
    system_type TEXT NOT NULL
);

CREATE TABLE biodiversity_resilience (
    farm_system TEXT PRIMARY KEY,
    crop_diversity REAL NOT NULL,
    soil_biological_function REAL NOT NULL,
    landscape_heterogeneity REAL NOT NULL,
    pollinator_habitat REAL NOT NULL,
    natural_enemy_habitat REAL NOT NULL
);

CREATE TABLE soil_carbon (
    system TEXT PRIMARY KEY,
    soc_t0_t_ha REAL NOT NULL,
    soc_t1_t_ha REAL NOT NULL,
    years INTEGER NOT NULL
);

CREATE TABLE diet_diversity (
    household_id TEXT PRIMARY KEY,
    grains INTEGER NOT NULL,
    legumes INTEGER NOT NULL,
    fruits INTEGER NOT NULL,
    vegetables INTEGER NOT NULL,
    animal_source INTEGER NOT NULL,
    nuts_seeds INTEGER NOT NULL,
    dairy INTEGER NOT NULL,
    food_access_constraint TEXT NOT NULL
);

CREATE TABLE food_loss_stages (
    system TEXT PRIMARY KEY,
    production_tonnes REAL NOT NULL,
    harvest_loss_tonnes REAL NOT NULL,
    storage_loss_tonnes REAL NOT NULL,
    processing_loss_tonnes REAL NOT NULL,
    retail_loss_tonnes REAL NOT NULL,
    consumer_waste_tonnes REAL NOT NULL
);

CREATE TABLE governance_notes (
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

INSERT INTO production_systems VALUES
('monocrop_grain',850,100,420000,12000,4800,90,'annual_crop'),
('diversified_crop',620,80,260000,7600,4100,45,'diversified_crop'),
('agroforestry',480,75,210000,5200,3600,30,'tree_crop_mixed'),
('mixed_crop_livestock',700,95,350000,9000,4700,60,'mixed_farming'),
('vegetable_smallholder',260,28,95000,3100,2100,22,'horticulture'),
('rice_wetland',540,60,520000,7800,3500,75,'irrigated_crop');

INSERT INTO biodiversity_resilience VALUES
('monocrop_grain',0.20,0.35,0.25,0.18,0.22),
('diversified_crop',0.65,0.70,0.60,0.62,0.58),
('agroforestry',0.80,0.82,0.88,0.84,0.78),
('mixed_crop_livestock',0.55,0.62,0.58,0.50,0.60),
('vegetable_smallholder',0.72,0.68,0.52,0.60,0.55),
('rice_wetland',0.38,0.50,0.46,0.42,0.45);

INSERT INTO soil_carbon VALUES
('monocrop_grain',42.0,40.8,5),
('diversified_crop',45.0,47.3,5),
('agroforestry',50.0,54.2,5),
('mixed_crop_livestock',46.0,48.1,5),
('vegetable_smallholder',38.0,39.4,5),
('rice_wetland',44.0,43.5,5);

INSERT INTO diet_diversity VALUES
('H001',1,1,1,1,0,1,0,'low'),
('H002',1,0,0,1,0,0,0,'high'),
('H003',1,1,1,1,1,0,1,'low'),
('H004',1,0,0,0,0,0,0,'high'),
('H005',1,1,0,1,0,0,1,'medium'),
('H006',1,1,1,1,0,1,1,'low');

INSERT INTO food_loss_stages VALUES
('monocrop_grain',850,35,28,12,8,7),
('diversified_crop',620,20,12,6,4,3),
('agroforestry',480,12,8,5,3,2),
('mixed_crop_livestock',700,22,14,10,7,7),
('vegetable_smallholder',260,9,5,3,3,2),
('rice_wetland',540,30,22,10,7,6);

INSERT INTO governance_notes (topic, note) VALUES
('soil_health','Soil indicators require local measurement methods and context.'),
('nutrition','Diet diversity is a simplified proxy and not a clinical nutrition diagnosis.'),
('biodiversity','Resilience indicators should include field evidence and landscape-scale monitoring.'),
('justice','Food-system interpretation should include labor, access, land, and community context.');

INSERT INTO provenance_artifacts (artifact_name, artifact_type, relative_path, checksum_sha256, notes) VALUES
('production_systems.csv','synthetic_data','data/production_systems.csv',NULL,'Synthetic agriculture production-system data'),
('biodiversity_resilience.csv','synthetic_data','data/biodiversity_resilience.csv',NULL,'Synthetic biodiversity-resilience data'),
('soil_carbon.csv','synthetic_data','data/soil_carbon.csv',NULL,'Synthetic soil organic carbon data'),
('diet_diversity.csv','synthetic_data','data/diet_diversity.csv',NULL,'Synthetic diet diversity data'),
('food_loss_stages.csv','synthetic_data','data/food_loss_stages.csv',NULL,'Synthetic food-loss stage data');
