# Biological methods model in Julia.

function exponential_growth(t, n0, r)
    return n0 * exp(r * t)
end

function logistic_growth(t, n0, r, k)
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t))
end

function doubling_time(r)
    return log(2.0) / r
end

function assay_metrics(tp, fn, tn, fp)
    sensitivity = tp / (tp + fn)
    specificity = tn / (tn + fp)
    ppv = tp / (tp + fp)
    npv = tn / (tn + fn)
    accuracy = (tp + tn) / (tp + fn + tn + fp)
    return sensitivity, specificity, ppv, npv, accuracy
end

function hamming_distance(a, b)
    if length(a) != length(b)
        error("Sequences must be aligned.")
    end
    return sum([a[i] != b[i] for i in eachindex(a)])
end

r = log(10.0) / 10.0
println("growth_rate=", round(r, digits=6))
println("doubling_time=", round(doubling_time(r), digits=6))
println("logistic_24=", round(logistic_growth(24.0, 1.0e5, 0.45, 2.0e6), digits=3))
println("assay_metrics=", assay_metrics(84, 16, 91, 9))
println("hamming_distance=", hamming_distance("ATGCTAGCTAAC", "ATGCTAGCTATC"))
