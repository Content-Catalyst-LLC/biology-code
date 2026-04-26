# Biomolecules and chemical basis of life model in Julia.

function michaelis_menten(substrate, vmax, km)
    return (vmax * substrate) / (km + substrate)
end

function ligand_fraction_bound(ligand, kd)
    return ligand / (kd + ligand)
end

function diffusive_flux(diffusion_coefficient, concentration_gradient)
    return -diffusion_coefficient * concentration_gradient
end

function gc_content(sequence)
    seq = uppercase(sequence)
    g = count(==('G'), seq)
    c = count(==('C'), seq)
    return (g + c) / length(seq)
end

function polymer_mass_estimate(monomer_count, mean_monomer_mass, water_loss_per_bond)
    bonds = max(monomer_count - 1, 0)
    return monomer_count * mean_monomer_mass - bonds * water_loss_per_bond
end

println("velocity=", round(michaelis_menten(6.0, 100.0, 3.0), digits=6))
println("fraction_bound=", round(ligand_fraction_bound(8.0, 8.0), digits=6))
println("diffusive_flux=", round(diffusive_flux(2.0, -0.8), digits=6))
println("gc_content=", round(gc_content("ATGCGCGTATTAACCGGTTAGCGCGATATCGCGTA"), digits=6))
println("polymer_mass=", round(polymer_mass_estimate(12, 110.0, 18.015), digits=6))
