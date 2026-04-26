-- Example SQL queries for enzyme and biochemical pathway workflows.

.headers on
.mode column

SELECT
    substrate_mM,
    velocity_units_min
FROM enzyme_assay_observations
ORDER BY substrate_mM;

SELECT
    enzyme_id,
    kcat_per_s,
    Km_mM,
    kcat_per_s / Km_mM AS catalytic_efficiency
FROM enzyme_variants
ORDER BY catalytic_efficiency DESC;

SELECT
    condition_id,
    inhibition_type,
    Vmax,
    Km,
    inhibitor_uM,
    Ki_uM
FROM inhibition_conditions
ORDER BY inhibition_type, inhibitor_uM;

SELECT
    step_id,
    enzyme_name,
    capacity,
    regulation_factor,
    capacity * regulation_factor AS effective_capacity
FROM pathway_steps
ORDER BY effective_capacity ASC;

SELECT
    MIN(capacity * regulation_factor) AS estimated_pathway_flux
FROM pathway_steps;

SELECT
    site_name,
    catalytic_capacity,
    substrate_access,
    regulatory_control,
    cofactor_availability,
    pathway_integration,
    environmental_stability,
    inhibition_risk,
    0.17 * catalytic_capacity +
    0.14 * substrate_access +
    0.15 * regulatory_control +
    0.14 * cofactor_availability +
    0.16 * pathway_integration +
    0.14 * environmental_stability +
    0.10 * (1 - inhibition_risk) AS enzyme_pathway_score
FROM enzyme_condition_sites
ORDER BY enzyme_pathway_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
