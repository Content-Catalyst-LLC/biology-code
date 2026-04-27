# Genomics sequence kernel in Julia.

function gc_content(sequence)
    seq = uppercase(sequence)
    valid = [base for base in seq if base in ['A', 'C', 'G', 'T']]
    if length(valid) == 0
        return NaN
    end
    gc = count(base -> base == 'G' || base == 'C', valid)
    return gc / length(valid)
end

function ambiguous_count(sequence)
    seq = uppercase(sequence)
    return count(base -> !(base in ['A', 'C', 'G', 'T']), seq)
end

function hamming_distance(a, b)
    if length(a) != length(b)
        error("Sequences must have equal length.")
    end
    return sum(collect(uppercase(a)) .!= collect(uppercase(b)))
end

sequence_a = "ATGCGCGTAATTAACCGGTTACCGTAGCTA"
sequence_b = "ATGCGCGTAATTAACCGGTTACCGTAACTA"

println("length=", length(sequence_a))
println("gc_content=", round(gc_content(sequence_a), digits=5))
println("ambiguous_bases=", ambiguous_count(sequence_a))
println("hamming_distance=", hamming_distance(sequence_a, sequence_b))
