# Plant productivity and biomass recovery model in Julia.

sites = [
    ("temperate_forest", 2200.0, 900.0, 700.0),
    ("grassland", 1450.0, 600.0, 500.0),
    ("wetland", 1800.0, 760.0, 680.0),
    ("restoration_site", 1300.0, 620.0, 710.0)
]

for site in sites
    name, gpp, ra, rh = site
    npp = gpp - ra
    nep = gpp - (ra + rh)

    println(
        "site=", name,
        " NPP=", round(npp, digits=3),
        " NEP=", round(nep, digits=3)
    )
end

function light_response(I; alpha=0.05, Amax=18.0, Rd=1.5)
    return (alpha * I * Amax) / (alpha * I + Amax) - Rd
end

println("Assimilation at I=1000: ", round(light_response(1000.0), digits=3))

function biomass_recovery(; days=365, B0=40.0, r=0.010, K=220.0, m=0.0025)
    biomass = B0

    for _ in 1:days
        d_biomass = r * biomass * (1.0 - biomass / K) - m * biomass
        biomass = max(0.0, biomass + d_biomass)
    end

    return biomass
end

println("Final biomass: ", round(biomass_recovery(), digits=3))
