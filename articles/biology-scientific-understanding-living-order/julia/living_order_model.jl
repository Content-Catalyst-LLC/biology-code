# Biology and living order model in Julia.

function homeostatic_state(time, initial_value, setpoint, k)
    return setpoint + (initial_value - setpoint) * exp(-k * time)
end

function recovery_index(initial_value, final_value, setpoint)
    initial_deviation = abs(initial_value - setpoint)
    if initial_deviation == 0
        return 1.0
    end
    return 1.0 - abs(final_value - setpoint) / initial_deviation
end

function exponential_growth(time, n0, r)
    return n0 * exp(r * time)
end

function doubling_time(r)
    if r <= 0
        return NaN
    end
    return log(2.0) / r
end

function logistic_growth(time, n0, r, k)
    return k / (1.0 + ((k - n0) / n0) * exp(-r * time))
end

function feedback_response(state, setpoint, gain)
    return gain * (setpoint - state)
end

final_state = homeostatic_state(5.0, 10.0, 2.0, 0.4)
r = log(735.0 / 100.0) / 10.0

println("homeostatic_state_t5=", round(final_state, digits=6))
println("recovery_index=", round(recovery_index(10.0, final_state, 2.0), digits=6))
println("growth_rate=", round(r, digits=6))
println("doubling_time=", round(doubling_time(r), digits=6))
println("logistic_growth_t40=", round(logistic_growth(40.0, 100.0, 0.35, 1200.0), digits=6))
println("feedback_response=", round(feedback_response(10.0, 2.0, 0.5), digits=6))
