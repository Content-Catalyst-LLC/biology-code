# Epidemiology modeling kernel in Julia.

function sir_final(population, initial_infected, beta, gamma, dt, steps)
    susceptible = population - initial_infected
    infected = initial_infected
    recovered = 0.0

    for _ in 1:steps
        new_infections = beta * susceptible * infected / population
        new_recoveries = gamma * infected

        susceptible = max(susceptible - dt * new_infections, 0.0)
        infected = max(infected + dt * (new_infections - new_recoveries), 0.0)
        recovered = min(recovered + dt * new_recoveries, population)
    end

    return susceptible, infected, recovered
end

function seir_final(population, initial_exposed, initial_infected, beta, sigma, gamma, dt, steps)
    susceptible = population - initial_exposed - initial_infected
    exposed = initial_exposed
    infected = initial_infected
    recovered = 0.0

    for _ in 1:steps
        new_exposures = beta * susceptible * infected / population
        new_infections = sigma * exposed
        new_recoveries = gamma * infected

        susceptible = max(susceptible - dt * new_exposures, 0.0)
        exposed = max(exposed + dt * (new_exposures - new_infections), 0.0)
        infected = max(infected + dt * (new_infections - new_recoveries), 0.0)
        recovered = min(recovered + dt * new_recoveries, population)
    end

    return susceptible, exposed, infected, recovered
end

s, i, r = sir_final(10000.0, 10.0, 0.32, 0.10, 0.25, 240)
ss, e, ii, rr = seir_final(10000.0, 20.0, 10.0, 0.32, 0.20, 0.10, 0.25, 240)

println("sir_final_susceptible=", round(s, digits=5))
println("sir_final_infected=", round(i, digits=5))
println("sir_final_recovered=", round(r, digits=5))
println("seir_final_susceptible=", round(ss, digits=5))
println("seir_final_exposed=", round(e, digits=5))
println("seir_final_infected=", round(ii, digits=5))
println("seir_final_recovered=", round(rr, digits=5))
