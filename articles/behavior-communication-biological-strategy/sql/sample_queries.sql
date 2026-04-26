-- Example SQL queries for behavior, communication, and biological strategy workflows.

.headers on
.mode column

SELECT
    option_name,
    benefit,
    energetic_cost,
    predation_risk
FROM behavioral_options
ORDER BY option_id;

SELECT
    strategy_name,
    mate_benefit,
    energetic_cost,
    predator_exposure,
    receiver_detectability
FROM signaling_strategies
ORDER BY strategy_id;

SELECT
    scenario_name,
    predation_weight,
    noise_penalty,
    receiver_state,
    notes
FROM environmental_scenarios
ORDER BY scenario_id;

SELECT
    scenario_name,
    resource_value,
    conflict_cost,
    hawk_frequency
FROM hawk_dove_parameters
ORDER BY parameter_id;

SELECT
    event_date,
    context,
    behavior_category,
    signal_modality
FROM behavior_observations
ORDER BY observation_id;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
