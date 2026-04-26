-- Example SQL queries for biomolecular biology workflows.

.headers on
.mode column

SELECT
    sample_id,
    carbohydrate_mg,
    lipid_mg,
    protein_mg,
    nucleic_acid_mg,
    metabolite_mg,
    carbohydrate_mg + lipid_mg + protein_mg + nucleic_acid_mg + metabolite_mg AS total_biomolecule_mg,
    protein_mg / (carbohydrate_mg + lipid_mg + protein_mg + nucleic_acid_mg + metabolite_mg) AS protein_fraction,
    lipid_mg / (carbohydrate_mg + lipid_mg + protein_mg + nucleic_acid_mg + metabolite_mg) AS lipid_fraction
FROM biomolecule_composition
ORDER BY total_biomolecule_mg DESC;

SELECT
    sample_id,
    carbon_mmol,
    nitrogen_mmol,
    phosphorus_mmol,
    carbon_mmol / nitrogen_mmol AS C_to_N,
    carbon_mmol / phosphorus_mmol AS C_to_P,
    nitrogen_mmol / phosphorus_mmol AS N_to_P
FROM elemental_composition
ORDER BY C_to_N DESC;

SELECT
    sequence_id,
    sequence_type,
    length(sequence) AS sequence_length,
    sequence
FROM sequence_records
ORDER BY sequence_type, sequence_id;

SELECT
    assay_id,
    substrate_mM,
    Vmax,
    Km,
    Vmax * substrate_mM / (Km + substrate_mM) AS velocity,
    (Vmax * substrate_mM / (Km + substrate_mM)) / Vmax AS fraction_vmax
FROM enzyme_assays
ORDER BY substrate_mM;

SELECT
    condition_id,
    ligand_uM,
    Kd_uM,
    ligand_uM / (Kd_uM + ligand_uM) AS fraction_bound,
    1 - (ligand_uM / (Kd_uM + ligand_uM)) AS fraction_unbound
FROM ligand_binding_assays
ORDER BY fraction_bound DESC;

SELECT
    polymer_id,
    monomer_count,
    mean_monomer_mass_Da,
    water_loss_per_bond_Da,
    monomer_count - 1 AS n_bonds,
    (monomer_count - 1) * water_loss_per_bond_Da AS estimated_water_loss_Da,
    monomer_count * mean_monomer_mass_Da - (monomer_count - 1) * water_loss_per_bond_Da AS estimated_polymer_mass_Da
FROM polymerization_examples
ORDER BY estimated_polymer_mass_Da DESC;

SELECT
    site_name,
    carbohydrate_support,
    lipid_boundary_function,
    protein_function,
    nucleic_acid_integrity,
    metabolite_balance,
    cofactor_availability,
    stress_penalty,
    0.14 * carbohydrate_support +
    0.15 * lipid_boundary_function +
    0.18 * protein_function +
    0.17 * nucleic_acid_integrity +
    0.14 * metabolite_balance +
    0.12 * cofactor_availability +
    0.10 * (1 - stress_penalty) AS biomolecular_condition_score
FROM biomolecular_condition_sites
ORDER BY biomolecular_condition_score DESC;

SELECT
    dataset_name,
    source_name,
    analytical_method,
    processing_step,
    uncertainty_notes
FROM provenance_records
ORDER BY recorded_at DESC;
