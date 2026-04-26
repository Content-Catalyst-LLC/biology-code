# Epigenetics and gene-expression model in Julia.

function transcript_decay(m0, k, t)
    return m0 * exp(-k * t)
end

function half_life(k)
    return log(2.0) / k
end

function methylation_fraction(methylated, unmethylated)
    total = methylated + unmethylated

    if total <= 0
        return NaN
    end

    return methylated / total
end

function regulatory_steady_state(kon, koff)
    return kon / (kon + koff)
end

function log2_fold_change(treated, control; epsilon = 1e-6)
    return log2((treated + epsilon) / (control + epsilon))
end

m0 = 120.0
k = log(4.0) / 6.0

println("expression at 6h=", round(transcript_decay(m0, k, 6.0), digits=4))
println("half_life_h=", round(half_life(k), digits=4))
println("methylation_fraction=", round(methylation_fraction(85.0, 15.0), digits=4))
println("p_on_steady_state=", round(regulatory_steady_state(0.28, 0.10), digits=4))
println("log2FC_expr=", round(log2_fold_change(25.0, 12.0), digits=4))
