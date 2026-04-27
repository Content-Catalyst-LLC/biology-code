.headers on
.mode column

SELECT
    image_id,
    sample_id,
    width,
    height,
    channels,
    pixel_size_um,
    objective
FROM microscopy_metadata;

SELECT
    object_id,
    area_pixels,
    ROUND(mean_intensity, 3) AS mean_intensity,
    ROUND(integrated_intensity, 3) AS integrated_intensity,
    ROUND(centroid_x, 3) AS centroid_x,
    ROUND(centroid_y, 3) AS centroid_y
FROM object_features
ORDER BY object_id;

SELECT
    metric,
    ROUND(value, 5) AS value
FROM segmentation_validation_metrics
ORDER BY metric;

SELECT
    metric,
    ROUND(value, 5) AS value
FROM colocalization_summary
ORDER BY metric;

SELECT
    track_id,
    frames,
    ROUND(total_distance, 3) AS total_distance,
    ROUND(net_displacement, 3) AS net_displacement,
    ROUND(mean_step_distance, 3) AS mean_step_distance
FROM tracking_summary
ORDER BY track_id;

SELECT
    step_id,
    operation,
    input_artifact,
    script,
    output_artifact
FROM workflow_steps
ORDER BY step_id;
