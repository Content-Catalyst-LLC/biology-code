# Biology foundations model in Julia.

function logistic_growth(t, n0, r, k)
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t))
end

function hardy_weinberg(p)
    q = 1 - p
    return Dict("AA" => p^2, "Aa" => 2p*q, "aa" => q^2)
end

function shannon(counts)
    total = sum(counts)
    probs = [x / total for x in counts if x > 0]
    return -sum([p * log(p) for p in probs])
end

function sequence_similarity(a, b)
    if length(a) != length(b)
        error("Sequences must be aligned and equal length.")
    end
    differences = sum([a[i] != b[i] for i in eachindex(a)])
    return 1 - differences / length(a)
end

r = log(735.0 / 100.0) / 10.0

println("growth_rate=", round(r, digits=6))
println("doubling_time=", round(log(2.0) / r, digits=6))
println("logistic_20=", round(logistic_growth(20.0, 100.0, 0.35, 2000.0), digits=3))
println("hardy_weinberg=", hardy_weinberg(0.7))
println("shannon=", round(shannon([25, 18, 11, 6, 4]), digits=6))
println("sequence_similarity=", round(sequence_similarity("ATGCTAGCTAAC", "ATGCTAGCTATC"), digits=6))
