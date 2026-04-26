.headers on
.mode column

SELECT
    t.taxon_id,
    t.scientific_name,
    s.marker_name,
    length(s.sequence) AS sequence_length
FROM taxa t
JOIN aligned_sequences s ON t.taxon_id = s.taxon_id
ORDER BY t.taxon_id;

SELECT
    site_id,
    SUM(abundance) AS total_abundance,
    COUNT(CASE WHEN abundance > 0 THEN 1 END) AS observed_taxa
FROM community_counts
GROUP BY site_id
ORDER BY total_abundance DESC;

SELECT
    taxon_id,
    COUNT(*) AS n_occurrences,
    AVG(identification_confidence) AS mean_identification_confidence,
    GROUP_CONCAT(DISTINCT country) AS countries
FROM occurrence_records
GROUP BY taxon_id
ORDER BY n_occurrences DESC;

SELECT
    record_id,
    candidate_taxon,
    0.30 * sequence_similarity +
    0.20 * morphological_support +
    0.15 * geographic_plausibility +
    0.25 * phylogenetic_support -
    0.10 * uncertainty_penalty AS taxonomic_confidence_score
FROM taxonomic_assignments
ORDER BY taxonomic_confidence_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
