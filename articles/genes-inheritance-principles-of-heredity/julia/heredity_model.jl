# Genes, inheritance, and heredity model in Julia.

function genotype_expectations(p)
    q = 1.0 - p
    return (AA = p^2, Aa = 2.0 * p * q, aa = q^2)
end

function expected_heterozygosity(p)
    q = 1.0 - p
    return 2.0 * p * q
end

function chi_square(observed, expected)
    return sum(((observed .- expected).^2) ./ expected)
end

function recombination_fraction(recombinants, total)
    return recombinants / total
end

function narrow_sense_heritability(VA, VP)
    return VA / VP
end

function breeder_response(h2, S)
    return h2 * S
end

g = genotype_expectations(0.7)

observed = [315.0, 105.0]
expected = [315.0, 105.0]

println("AA=", round(g.AA, digits=4), " Aa=", round(g.Aa, digits=4), " aa=", round(g.aa, digits=4))
println("expected_heterozygosity=", round(expected_heterozygosity(0.7), digits=4))
println("chi_square=", round(chi_square(observed, expected), digits=4))
println("recombination_fraction=", round(recombination_fraction(185.0, 1000.0), digits=4))
println("h2=", round(narrow_sense_heritability(4.0, 13.0), digits=4))
println("response_to_selection=", round(breeder_response(4.0 / 13.0, 5.0), digits=4))
