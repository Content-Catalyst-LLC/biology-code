# Systems biology numerical kernel in Julia.

function simulate_feedback(x0, y0, production_x, production_y, degradation_x, degradation_y, hill_n, dt, steps)
    x = x0
    y = y0

    for _ in 1:steps
        dx = production_x / (1.0 + y^hill_n) - degradation_x * x
        dy = production_y * x - degradation_y * y

        x = max(x + dt * dx, 0.0)
        y = max(y + dt * dy, 0.0)
    end

    return x, y
end

function mass_balance_residual(glucose_import, glycolysis, biomass)
    glucose = 1.0 * glucose_import - 1.0 * glycolysis
    pyruvate = 2.0 * glycolysis - 2.0 * biomass
    biomass_precursor = 1.0 * biomass

    return glucose, pyruvate, biomass_precursor
end

x, y = simulate_feedback(0.20, 0.10, 1.20, 0.80, 0.40, 0.30, 2.0, 0.10, 80)
g, p, b = mass_balance_residual(8.0, 8.0, 4.0)

println("final_x=", round(x, digits=5))
println("final_y=", round(y, digits=5))
println("glucose_residual=", round(g, digits=5))
println("pyruvate_residual=", round(p, digits=5))
println("biomass_residual=", round(b, digits=5))
