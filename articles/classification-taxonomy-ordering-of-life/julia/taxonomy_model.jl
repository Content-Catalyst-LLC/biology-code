# Taxonomy model in Julia.

function p_distance(seq1, seq2)
    if length(seq1) != length(seq2)
        error("Sequences must be aligned and equal length.")
    end
    differences = sum([seq1[i] != seq2[i] for i in eachindex(seq1)])
    return differences / length(seq1)
end

function jukes_cantor(p)
    if p >= 0.75
        return NaN
    end
    return -0.75 * log(1 - (4 / 3) * p)
end

function shannon(counts)
    total = sum(counts)
    probs = [x / total for x in counts if x > 0]
    return -sum([p * log(p) for p in probs])
end

function bray_curtis(x, y)
    return 1 - (2 * sum(min.(x, y))) / (sum(x) + sum(y))
end

function taxonomic_confidence(s, m, g, p, u)
    return 0.30*s + 0.20*m + 0.15*g + 0.25*p - 0.10*u
end

p = p_distance("ATGCTAGCTAAC", "ATGCTAGCTATC")
println("p_distance=", round(p, digits=6))
println("jukes_cantor=", round(jukes_cantor(p), digits=6))
println("shannon=", round(shannon([25, 18, 11, 6]), digits=6))
println("bray_curtis=", round(bray_curtis([25, 18, 11, 6], [10, 24, 15, 12]), digits=6))
println("confidence=", round(taxonomic_confidence(0.98, 0.90, 0.88, 0.94, 0.05), digits=6))
