# Modern biological thought quantitative model in Julia.

function logistic_growth(t, n0, r, k)
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t))
end

function hardy_weinberg(p)
    q = 1 - p
    return Dict("AA" => p^2, "Aa" => 2p*q, "aa" => q^2)
end

function selection_update(p, w_AA, w_Aa, w_aa)
    q = 1 - p
    wbar = p^2*w_AA + 2*p*q*w_Aa + q^2*w_aa
    return (p^2*w_AA + p*q*w_Aa) / wbar
end

function sequence_similarity(a, b)
    if length(a) != length(b)
        error("Sequences must be aligned and equal length.")
    end
    differences = sum([a[i] != b[i] for i in eachindex(a)])
    return 1 - differences / length(a)
end

r = log(708.0 / 100.0) / 10.0

println("growth_rate=", round(r, digits=6))
println("doubling_time=", round(log(2.0) / r, digits=6))
println("logistic_20=", round(logistic_growth(20.0, 100.0, 0.35, 2000.0), digits=3))
println("hardy_weinberg=", hardy_weinberg(0.7))
println("selection_update=", round(selection_update(0.5, 1.1, 1.05, 1.0), digits=6))
println("sequence_similarity=", round(sequence_similarity("ATGCTAGCTAAC", "ATGCTAGCTATC"), digits=6))
