-- Restoration Ecology Data Model
--
-- SQLite-compatible schema for restoration scenarios, indicators,
-- interventions, monitoring, and provenance.

DROP TABLE IF EXISTS restoration_projects;
DROP TABLE IF EXISTS restoration_scenarios;
DROP TABLE IF EXISTS monitoring_indicators;
DROP TABLE IF EXISTS intervention_records;
DROP TABLE IF EXISTS monitoring_records;
DROP TABLE IF EXISTS source_metadata;
DROP TABLE IF EXISTS model_parameters;

CREATE TABLE restoration_projects (
    project_id INTEGER PRIMARY KEY,
    project_name TEXT NOT NULL,
    ecosystem_type TEXT NOT NULL,
    restoration_goal TEXT NOT NULL,
    reference_condition_notes TEXT,
    governance_notes TEXT
);

CREATE TABLE restoration_scenarios (
    scenario_id INTEGER PRIMARY KEY,
    scenario_name TEXT NOT NULL,
    restoration_effort REAL NOT NULL,
    belowground_support REAL NOT NULL,
    disturbance_pressure REAL NOT NULL,
    description TEXT
);

CREATE TABLE monitoring_indicators (
    indicator_id INTEGER PRIMARY KEY,
    indicator_name TEXT NOT NULL,
    domain TEXT NOT NULL,
    unit_or_scale TEXT NOT NULL,
    interpretation TEXT NOT NULL
);

CREATE TABLE intervention_records (
    intervention_id INTEGER PRIMARY KEY,
    project_id INTEGER NOT NULL,
    intervention_type TEXT NOT NULL,
    intervention_date TEXT,
    intensity REAL,
    notes TEXT,
    FOREIGN KEY(project_id) REFERENCES restoration_projects(project_id)
);

CREATE TABLE monitoring_records (
    record_id INTEGER PRIMARY KEY,
    project_id INTEGER NOT NULL,
    indicator_id INTEGER NOT NULL,
    observation_date TEXT NOT NULL,
    observed_value REAL NOT NULL,
    method_notes TEXT,
    FOREIGN KEY(project_id) REFERENCES restoration_projects(project_id),
    FOREIGN KEY(indicator_id) REFERENCES monitoring_indicators(indicator_id)
);

CREATE TABLE source_metadata (
    source_id INTEGER PRIMARY KEY,
    source_title TEXT NOT NULL,
    organization_or_publication TEXT,
    role TEXT,
    url TEXT
);

CREATE TABLE model_parameters (
    parameter_id INTEGER PRIMARY KEY,
    parameter_name TEXT NOT NULL,
    parameter_value REAL NOT NULL,
    description TEXT
);

INSERT INTO restoration_projects VALUES
(1, 'Demonstration Wetland Recovery', 'freshwater wetland', 'recover hydrology vegetation soil microbial function and habitat complexity', 'reference wetland with seasonal saturation and native sedge meadow structure', 'example teaching project');

INSERT INTO restoration_scenarios VALUES
(1, 'low_effort_high_disturbance', 0.7, 0.8, 0.8, 'low effort with continuing high disturbance'),
(2, 'moderate_effort_moderate_disturbance', 1.0, 0.8, 0.5, 'moderate intervention and disturbance'),
(3, 'high_effort_low_disturbance', 1.4, 0.8, 0.2, 'high intervention and reduced disturbance'),
(4, 'soil_limited_recovery', 1.1, 0.3, 0.4, 'aboveground restoration with weak belowground support');

INSERT INTO monitoring_indicators VALUES
(1, 'native_vegetation_cover', 'vegetation', 'percent', 'visible recovery of native plant dominance'),
(2, 'seedling_recruitment', 'vegetation', 'count_per_square_meter', 'evidence of regenerative capacity'),
(3, 'soil_organic_matter', 'soil', 'percent', 'rebuilding of soil carbon and structure'),
(4, 'microbial_biomass', 'soil_microbiology', 'index', 'belowground biological recovery'),
(5, 'hydrological_connectivity', 'hydrology', 'index', 'reconnection of flows floodplains or wetlands'),
(6, 'functional_integrity', 'ecosystem_function', 'index', 'combined measure of ecological process recovery'),
(7, 'disturbance_pressure', 'stressor', 'index', 'continuing degradation pressure');

INSERT INTO model_parameters VALUES
(1, 'a', 0.8, 'seeding or planting support for vegetation recovery'),
(2, 'b', 0.15, 'vegetation loss rate'),
(3, 'c', 0.20, 'disturbance effect on vegetation'),
(4, 'p', 0.10, 'vegetation contribution to soil or microbial recovery'),
(5, 'q', 0.25, 'belowground support input effect'),
(6, 'r', 0.12, 'soil or microbial loss rate'),
(7, 'u', 0.08, 'vegetation contribution to functional integrity'),
(8, 'v', 0.10, 'soil or microbial contribution to functional integrity'),
(9, 'w', 0.18, 'disturbance effect on functional integrity');

INSERT INTO source_metadata VALUES
(1, 'International Principles and Standards for the Practice of Ecological Restoration', 'Society for Ecological Restoration', 'restoration principles and standards', 'https://www.ser.org/page/serstandards/international-standards-for-the-practice-of-ecological-restoration.htm'),
(2, 'UN Decade on Ecosystem Restoration', 'United Nations', 'global restoration initiative', 'https://www.decadeonrestoration.org/'),
(3, 'Ecosystem Restoration', 'IUCN', 'global restoration context', 'https://www.iucn.org/our-work/topic/ecosystem-restoration'),
(4, 'Foundations of Restoration Ecology', 'Island Press', 'major restoration ecology reference', 'https://islandpress.org/books/foundations-restoration-ecology');

SELECT scenario_name, restoration_effort, belowground_support, disturbance_pressure
FROM restoration_scenarios
ORDER BY scenario_id;
