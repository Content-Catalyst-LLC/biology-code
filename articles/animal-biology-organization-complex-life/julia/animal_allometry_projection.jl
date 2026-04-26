# Animal allometry and population projection in Julia.

species = [
    ("shrew", 0.01, "terrestrial", 0.40),
    ("sparrow", 0.03, "terrestrial", 0.42),
    ("rabbit", 1.5, "terrestrial", 0.38),
    ("fox", 6.0, "terrestrial", 0.44),
    ("deer", 80.0, "terrestrial", 0.48),
    ("seal", 150.0, "marine", 0.55)
]

B0 = 4.2

for animal in species
    name, mass, habitat, exposure = animal
    metabolic_rate = B0 * mass^0.75
    mass_specific_rate = metabolic_rate / mass

    println(
        "species=", name,
        " mass_kg=", mass,
        " metabolic_rate=", round(metabolic_rate, digits=4),
        " mass_specific_rate=", round(mass_specific_rate, digits=4)
    )
end

A = [0.0 1.4; 0.35 0.72]
n = [40.0, 25.0]

for year in 0:20
    total = sum(n)
    println(
        "year=", year,
        " juveniles=", round(n[1], digits=2),
        " adults=", round(n[2], digits=2),
        " total=", round(total, digits=2)
    )

    n = A * n
end
