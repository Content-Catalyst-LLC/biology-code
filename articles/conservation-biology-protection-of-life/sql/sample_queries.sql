-- Example SQL queries for conservation biology workflows.

.headers on
.mode column

SELECT
    unit_code,
    unit_type,
    biome,
    region
FROM conservation_units
ORDER BY unit_code;

SELECT
    dataset_name,
    source_name,
    collection_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
