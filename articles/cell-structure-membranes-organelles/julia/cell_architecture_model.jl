# Cell structure, membranes, and organelles model in Julia.

function sphere_surface_area(radius_um)
    return 4.0 * pi * radius_um^2
end

function sphere_volume(radius_um)
    return (4.0 / 3.0) * pi * radius_um^3
end

function surface_area_to_volume(radius_um)
    return sphere_surface_area(radius_um) / sphere_volume(radius_um)
end

function permeability_flux(permeability, c_out, c_in)
    return permeability * (c_out - c_in)
end

function diffusive_flux(diffusion_coefficient, gradient)
    return -diffusion_coefficient * gradient
end

function organelle_fraction(organelle_area, cell_area)
    return organelle_area / cell_area
end

function organelle_density(count, cell_area)
    return count / cell_area
end

radius = 5.0

println("surface_area_um2=", round(sphere_surface_area(radius), digits=6))
println("volume_um3=", round(sphere_volume(radius), digits=6))
println("sa_to_volume=", round(surface_area_to_volume(radius), digits=6))
println("permeability_flux=", round(permeability_flux(0.05, 10.0, 3.0), digits=6))
println("diffusive_flux=", round(diffusive_flux(2.0, -0.8), digits=6))
println("mitochondrial_fraction=", round(organelle_fraction(62.0, 420.0), digits=6))
println("lysosome_density=", round(organelle_density(18.0, 420.0), digits=6))
