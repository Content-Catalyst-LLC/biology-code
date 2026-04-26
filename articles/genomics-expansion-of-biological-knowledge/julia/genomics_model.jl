# Genomics model in Julia.

function expected_heterozygosity(p)
    return 2.0 * p * (1.0 - p)
end

function nucleotide_diversity(p_values)
    return mean(2.0 .* p_values .* (1.0 .- p_values))
end

function fst_style(p1, p2)
    pbar = (p1 + p2) / 2.0
    ht = 2.0 * pbar * (1.0 - pbar)
    hs = (2.0 * p1 * (1.0 - p1) + 2.0 * p2 * (1.0 - p2)) / 2.0

    if ht <= 0.0
        return 0.0
    end

    return (ht - hs) / ht
end

function jukes_cantor(d)
    if d >= 0.75
        return NaN
    end

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d)
end

function log2_fold_change(treated, control; epsilon = 1.0)
    return log2((treated + epsilon) / (control + epsilon))
end

p_values = [0.05, 0.18, 0.34, 0.52, 0.81]

println("expected_heterozygosity_p_0_8=", round(expected_heterozygosity(0.8), digits=6))
println("nucleotide_diversity=", round(nucleotide_diversity(p_values), digits=6))
println("fst_style=", round(fst_style(0.40, 0.75), digits=6))
println("jukes_cantor=", round(jukes_cantor(0.15), digits=6))
println("log2_fc=", round(log2_fold_change(160.0, 100.0), digits=6))
