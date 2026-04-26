# Extinction hazard and post-crisis recovery model in Julia.

clades = [
    ("clade_A", 120.0, 30.0),
    ("clade_B", 80.0, 40.0),
    ("clade_C", 50.0, 10.0),
    ("clade_D", 200.0, 110.0),
    ("clade_E", 65.0, 12.0)
]

for clade in clades
    name, initial, survivors = clade
    survivorship = survivors / initial
    extinction = 1.0 - survivorship

    println(
        "clade=", name,
        " survivorship=", round(survivorship, digits=4),
        " extinction=", round(extinction, digits=4)
    )
end

function survivorship(lambda, t)
    return exp(-lambda * t)
end

for scenario in [("background", 0.05), ("elevated_crisis", 0.18), ("severe_crisis", 0.35)]
    name, lambda = scenario
    println("scenario=", name, " survivorship_t10=", round(survivorship(lambda, 10.0), digits=4))
end

function recovery(N0, r, K, time)
    return K / (1.0 + ((K - N0) / N0) * exp(-r * time))
end

println("moderate_recovery_t30=", round(recovery(5.0, 0.14, 60.0, 30.0), digits=3))
