# Microbial growth and recovery model in Julia.
#
# This compact workflow simulates Monod growth and community recovery after
# disturbance.

function simulate_monod(; days=48.0, dt=0.1, N0=1.0e4, S0=100.0, mu_max=0.8, Ks=20.0, yield_coeff=1.0e6)
    steps = Int(round(days / dt)) + 1
    abundance = N0
    substrate = S0

    for _ in 2:steps
        mu = mu_max * substrate / (Ks + substrate)
        d_abundance = mu * abundance * dt
        d_substrate = -(d_abundance / yield_coeff)

        abundance = max(abundance + d_abundance, 0.0)
        substrate = max(substrate + d_substrate, 0.0)
    end

    return abundance, substrate
end

scenarios = [
    ("rich_media", 1.0e4, 150.0, 0.9, 15.0),
    ("poor_media", 1.0e4, 50.0, 0.6, 25.0),
    ("stress_condition", 1.0e4, 50.0, 0.3, 30.0)
]

for scenario in scenarios
    name, N0, S0, mu_max, Ks = scenario
    final_abundance, final_substrate = simulate_monod(N0=N0, S0=S0, mu_max=mu_max, Ks=Ks)

    println(
        "scenario=", name,
        " final_abundance=", round(final_abundance, digits=3),
        " remaining_substrate=", round(final_substrate, digits=3)
    )
end

function recovery(; days=120, B0=8.0, r=0.06, K=75.0, m=0.025)
    biomass = B0

    for _ in 1:days
        d_biomass = r * biomass * (1.0 - biomass / K) - m * biomass
        biomass = max(biomass + d_biomass, 0.0)
    end

    return biomass
end

println("Example final recovery biomass: ", round(recovery(), digits=3))
