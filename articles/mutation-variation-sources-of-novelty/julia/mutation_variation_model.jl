# Mutation, variation, and novelty model in Julia.

function expected_mutations(n_genomes, target_length, mu)
    return n_genomes * target_length * mu
end

function jukes_cantor(d)
    if d >= 0.75
        return NaN
    end

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d)
end

function nucleotide_diversity(p_values)
    return mean(2.0 .* p_values .* (1.0 .- p_values))
end

function mutation_selection_balance(mu, s)
    return sqrt(mu / s)
end

function hardy_weinberg(p)
    q = 1.0 - p
    return (AA = p^2, Aa = 2.0 * p * q, aa = q^2)
end

lambda = expected_mutations(500.0, 1.2e8, 1e-8)
pvals = [0.10, 0.25, 0.50, 0.75, 0.90]
hw = hardy_weinberg(0.6)

println("expected_mutations=", round(lambda, digits=6))
println("jukes_cantor_distance=", round(jukes_cantor(0.15), digits=6))
println("nucleotide_diversity=", round(nucleotide_diversity(pvals), digits=6))
println("mutation_selection_balance_q=", round(mutation_selection_balance(1e-5, 0.01), digits=6))
println("Hardy-Weinberg AA=", round(hw.AA, digits=4), " Aa=", round(hw.Aa, digits=4), " aa=", round(hw.aa, digits=4))
