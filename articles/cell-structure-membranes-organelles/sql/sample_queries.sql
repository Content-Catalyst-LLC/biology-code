-- Example SQL queries for cell architecture workflows.

.headers on
.mode column

SELECT
    compartment_id,
    estimated_volume_um3,
    estimated_surface_area_um2,
    primary_function
FROM compartment_inventory
ORDER BY estimated_surface_area_um2 DESC;

SELECT
    scenario_name,
    permeability_um_s,
    external_concentration,
    internal_concentration,
    permeability_um_s * (external_concentration - internal_concentration) AS membrane_flux,
    membrane_area_um2,
    permeability_um_s * (external_concentration - internal_concentration) * membrane_area_um2 AS area_scaled_flux
FROM membrane_transport_observations
ORDER BY area_scaled_flux DESC;

SELECT
    condition_name,
    AVG(mitochondrial_area_um2 / cell_area_um2) AS mean_mitochondrial_fraction,
    AVG(er_area_um2 / cell_area_um2) AS mean_er_fraction,
    AVG(golgi_area_um2 / cell_area_um2) AS mean_golgi_fraction,
    AVG(nucleus_area_um2 / cell_area_um2) AS mean_nucleus_fraction,
    AVG(1.0 * lysosome_count / cell_area_um2) AS mean_lysosome_density,
    COUNT(*) AS n_cells
FROM organelle_morphometry
GROUP BY condition_name
ORDER BY condition_name;

SELECT
    source AS organelle,
    COUNT(*) AS outgoing_edges,
    SUM(interaction_weight) AS outgoing_weight
FROM organelle_network_edges
GROUP BY source
ORDER BY outgoing_weight DESC;

SELECT
    interaction_type,
    COUNT(*) AS n_edges,
    AVG(interaction_weight) AS mean_weight
FROM organelle_network_edges
GROUP BY interaction_type
ORDER BY mean_weight DESC;

SELECT
    scenario_id,
    cytosol_initial,
    organelle_initial,
    k_import,
    k_export,
    organelle_consumption
FROM compartment_flux_scenarios
ORDER BY scenario_id;

SELECT
    site_name,
    membrane_integrity,
    transport_capacity,
    organelle_specialization,
    trafficking_coordination,
    energy_compartment_function,
    turnover_capacity,
    stress_penalty,
    0.17 * membrane_integrity +
    0.15 * transport_capacity +
    0.14 * organelle_specialization +
    0.15 * trafficking_coordination +
    0.15 * energy_compartment_function +
    0.14 * turnover_capacity +
    0.10 * (1 - stress_penalty) AS cellular_architecture_score
FROM cellular_architecture_condition_sites
ORDER BY cellular_architecture_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
