-- Image analysis, microscopy, and computational biology schema.

DROP TABLE IF EXISTS microscopy_metadata;
DROP TABLE IF EXISTS synthetic_objects;
DROP TABLE IF EXISTS segmentation_runs;
DROP TABLE IF EXISTS object_features;
DROP TABLE IF EXISTS segmentation_validation_metrics;
DROP TABLE IF EXISTS colocalization_summary;
DROP TABLE IF EXISTS tracking_summary;
DROP TABLE IF EXISTS workflow_steps;
DROP TABLE IF EXISTS artifacts;
DROP TABLE IF EXISTS provenance_records;
DROP TABLE IF EXISTS validation_checks;

CREATE TABLE microscopy_metadata (
    image_id TEXT PRIMARY KEY,
    sample_id TEXT NOT NULL,
    width INTEGER NOT NULL CHECK (width > 0),
    height INTEGER NOT NULL CHECK (height > 0),
    channels INTEGER NOT NULL CHECK (channels > 0),
    pixel_size_um REAL NOT NULL CHECK (pixel_size_um > 0),
    z_spacing_um REAL,
    time_interval_s REAL,
    objective TEXT,
    notes TEXT
);

CREATE TABLE synthetic_objects (
    object_id TEXT PRIMARY KEY,
    cx REAL NOT NULL,
    cy REAL NOT NULL,
    sigma REAL NOT NULL CHECK (sigma > 0),
    amplitude REAL NOT NULL CHECK (amplitude >= 0),
    channel TEXT NOT NULL
);

CREATE TABLE segmentation_runs (
    run_id TEXT PRIMARY KEY,
    image_id TEXT NOT NULL,
    channel TEXT NOT NULL,
    method TEXT NOT NULL,
    threshold REAL NOT NULL,
    output_artifact TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE object_features (
    object_id TEXT PRIMARY KEY,
    area_pixels INTEGER NOT NULL,
    mean_intensity REAL NOT NULL,
    integrated_intensity REAL NOT NULL,
    centroid_x REAL NOT NULL,
    centroid_y REAL NOT NULL,
    min_x INTEGER,
    max_x INTEGER,
    min_y INTEGER,
    max_y INTEGER
);

CREATE TABLE segmentation_validation_metrics (
    metric TEXT PRIMARY KEY,
    value REAL NOT NULL
);

CREATE TABLE colocalization_summary (
    metric TEXT PRIMARY KEY,
    value REAL NOT NULL
);

CREATE TABLE tracking_summary (
    track_id TEXT PRIMARY KEY,
    frames INTEGER NOT NULL,
    total_distance REAL NOT NULL,
    net_displacement REAL NOT NULL,
    mean_step_distance REAL NOT NULL
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

INSERT INTO microscopy_metadata
(image_id, sample_id, width, height, channels, pixel_size_um, z_spacing_um, time_interval_s, objective, notes)
VALUES
('synthetic_image_001','sample_A',64,64,2,0.65,1.50,30.0,'synthetic_40x','Educational synthetic microscopy image');

INSERT INTO synthetic_objects
(object_id, cx, cy, sigma, amplitude, channel)
VALUES
('cell_01',18,20,4.0,140,'A'),
('cell_02',42,25,5.0,170,'A'),
('cell_03',30,45,4.5,155,'A'),
('signal_01',19,21,4.2,120,'B'),
('signal_02',41,26,5.2,150,'B'),
('signal_03',33,44,4.8,92,'B');

INSERT INTO segmentation_runs
(run_id, image_id, channel, method, threshold, output_artifact, notes)
VALUES
('segmentation_run_001','synthetic_image_001','A','threshold',65.0,'outputs/tables/segmentation_mask.csv','Educational threshold segmentation');

INSERT INTO object_features
(object_id, area_pixels, mean_intensity, integrated_intensity, centroid_x, centroid_y, min_x, max_x, min_y, max_y)
VALUES
('cell_01',198,101.2,20037.6,18.1,20.2,10,26,12,28),
('cell_02',312,118.4,36940.8,42.1,25.0,31,53,14,36),
('cell_03',248,109.7,27205.6,30.2,44.9,20,40,35,55);

INSERT INTO segmentation_validation_metrics
(metric, value)
VALUES
('Dice',0.8),
('IoU',0.6666667),
('true_positive',5),
('false_positive',1),
('false_negative',2),
('true_negative',4);

INSERT INTO colocalization_summary
(metric, value)
VALUES
('pearson_colocalization',0.982),
('overlap_fraction_a_positive',0.857),
('overlap_fraction_b_positive',0.857);

INSERT INTO tracking_summary
(track_id, frames, total_distance, net_displacement, mean_step_distance)
VALUES
('track_01',4,8.135,8.139,2.711),
('track_02',4,7.213,6.640,2.404);

INSERT INTO workflow_steps
(step_id, operation, input_artifact, script, output_artifact, notes)
VALUES
(1,'generate_synthetic_microscopy','synthetic_objects.csv','python/01_generate_synthetic_microscopy.py','outputs/tables/synthetic_image_pixels.csv','Generate synthetic microscopy-like image pixels'),
(2,'threshold_segmentation','synthetic_image_pixels.csv','python/02_threshold_segmentation.py','outputs/tables/segmentation_mask.csv','Apply threshold segmentation'),
(3,'object_feature_extraction','segmentation_mask.csv','python/03_object_feature_extraction.py','outputs/tables/object_features.csv','Extract object-level image features'),
(4,'segmentation_validation','segmentation_validation_pixels.csv','python/04_segmentation_validation.py','outputs/tables/segmentation_validation_metrics.csv','Calculate Dice and IoU validation metrics'),
(5,'colocalization_summary','colocalization_pixels.csv','python/05_colocalization_summary.py','outputs/tables/colocalization_summary.csv','Calculate colocalization scaffolds'),
(6,'tracking_summary','tracks.csv','python/06_tracking_summary.py','outputs/tables/tracking_summary.csv','Summarize time-lapse tracking trajectories'),
(7,'workflow_manifest','workflow_steps.csv','python/07_workflow_manifest.py','outputs/tables/workflow_manifest.csv','Record workflow artifacts and checksums'),
(8,'generate_report','object_features.csv;segmentation_validation_metrics.csv;colocalization_summary.csv;tracking_summary.csv','python/08_generate_report.py','outputs/reports/microscopy_image_analysis_report.md','Generate reproducible image-analysis report');

INSERT INTO artifacts
(artifact_name, artifact_role, status, sha256, notes)
VALUES
('synthetic_objects.csv','input','archived',NULL,'Synthetic image object definitions'),
('microscopy_metadata.csv','metadata','archived',NULL,'Synthetic microscopy metadata'),
('segmentation_validation_pixels.csv','input','archived',NULL,'Synthetic validation mask comparison'),
('colocalization_pixels.csv','input','archived',NULL,'Synthetic two-channel pixel table'),
('tracks.csv','input','archived',NULL,'Synthetic time-lapse tracking table'),
('synthetic_image_pixels.csv','output','generated',NULL,'Generated synthetic pixel table'),
('segmentation_mask.csv','output','generated',NULL,'Threshold segmentation output'),
('object_features.csv','output','generated',NULL,'Object feature table'),
('microscopy_image_analysis_report.md','report','generated',NULL,'Generated image-analysis report');

INSERT INTO provenance_records
(operation, input_artifact, output_artifact, script, notes)
SELECT operation, input_artifact, output_artifact, script, notes
FROM workflow_steps;

INSERT INTO validation_checks
(check_name, passed, details)
VALUES
('metadata_pixel_size_present',1,'Synthetic metadata includes pixel size'),
('threshold_recorded',1,'Segmentation threshold is recorded'),
('validation_metrics_present',1,'Dice and IoU metrics are included'),
('tracking_ids_unique',1,'Synthetic track identifiers are unique');
