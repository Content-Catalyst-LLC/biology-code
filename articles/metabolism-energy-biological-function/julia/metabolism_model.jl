# Metabolism, energy, and biological function model in Julia.

function exponential_growth(t, n0, r)
    return n0 * exp(r * t)
end

function logistic_growth(t, n0, r, k)
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t))
end

function doubling_time(r)
    if r <= 0
        return NaN
    end
    return log(2.0) / r
end

function monod_growth(substrate, mu_max, ks)
    return mu_max * substrate / (ks + substrate)
end

function biomass_yield(delta_x, delta_s)
    return delta_x / delta_s
end

function allocation_fraction(component, substrate_input)
    return component / substrate_input
end

function toy_objective(biomass_flux, product_flux)
    return biomass_flux + 0.25 * product_flux
end

n0 = 1.0e5
r = log(4.0) / 48.0
k = 1.0e6

println("abundance_48h=", round(exponential_growth(48.0, n0, r), digits=3))
println("doubling_time_h=", round(doubling_time(r), digits=3))
println("logistic_96h=", round(logistic_growth(96.0, n0, 0.035, k), digits=3))
println("monod_growth=", round(monod_growth(5.0, 0.08, 2.5), digits=6))
println("biomass_yield=", round(biomass_yield(0.75, 1.50), digits=6))
println("maintenance_fraction=", round(allocation_fraction(0.70, 2.0), digits=6))
println("toy_objective=", round(toy_objective(8.0, 2.0), digits=6))
