# Coevolution and symbiosis model in Julia.

function relationship_state(net_effect)
    if net_effect > 0.05
        return "beneficial"
    elseif net_effect >= -0.05
        return "near_neutral"
    else
        return "costly"
    end
end

for stress in 0.0:0.1:1.0
    benefit = 0.8 - 0.3 * stress
    cost = 0.2 + 0.4 * stress
    net_effect = benefit - cost

    println(
        "stress=", round(stress, digits=2),
        " benefit=", round(benefit, digits=3),
        " cost=", round(cost, digits=3),
        " net_effect=", round(net_effect, digits=3),
        " state=", relationship_state(net_effect)
    )
end

function simulate_host_pathogen(; steps=60, host_defense=0.4, pathogen_escape=0.5, feedback=0.03)
    host = host_defense
    pathogen = pathogen_escape

    for time in 0:steps
        infection_pressure = max(pathogen - host, 0.0)

        if time % 10 == 0
            println(
                "time=", time,
                " host_defense=", round(host, digits=4),
                " pathogen_escape=", round(pathogen, digits=4),
                " infection_pressure=", round(infection_pressure, digits=4)
            )
        end

        host = min(max(host + feedback * infection_pressure, 0.0), 1.0)
        pathogen = min(max(pathogen + feedback * max(host - pathogen, 0.0), 0.0), 1.0)
    end
end

simulate_host_pathogen()
