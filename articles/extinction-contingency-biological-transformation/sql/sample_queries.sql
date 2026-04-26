-- Example SQL queries for extinction, contingency, and transformation workflows.

.headers on
.mode column

SELECT
    clade_name,
    initial_lineages,
    surviving_lineages,
    initial_lineages - surviving_lineages AS loss_count,
    surviving_lineages / initial_lineages AS survivorship,
    1 - (surviving_lineages / initial_lineages) AS extinction
FROM clade_survivorship
ORDER BY extinction DESC;

SELECT
    scenario_name,
    extinction_hazard,
    time_horizon,
    exp(-extinction_hazard * time_horizon) AS survivorship_at_horizon
FROM hazard_scenarios
ORDER BY extinction_hazard DESC;

SELECT
    scenario_name,
    initial_richness,
    recovery_rate,
    carrying_capacity,
    time_horizon
FROM recovery_scenarios
ORDER BY recovery_rate DESC;

SELECT
    taxon_name,
    range_size,
    trophic_flexibility,
    habitat_dependence,
    0.4 * (1 - range_size) +
    0.3 * (1 - trophic_flexibility) +
    0.3 * habitat_dependence AS risk_index
FROM trait_risk_taxa
ORDER BY risk_index DESC;

SELECT
    status,
    sum(branch_length) AS total_branch_length
FROM phylogenetic_loss
GROUP BY status;

SELECT
    site_name,
    lineage_irreplaceability,
    range_contraction,
    habitat_fragmentation,
    functional_uniqueness,
    recovery_potential,
    monitoring_confidence
FROM extinction_condition_sites
ORDER BY site_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
