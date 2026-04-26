# DNA, RNA, and molecular logic model in Julia.

function transcript_decay(m0, k, t)
    return m0 * exp(-k * t)
end

function half_life(k)
    return log(2.0) / k
end

function gc_fraction(seq)
    seq_upper = uppercase(seq)
    gc = count(c -> c == 'G' || c == 'C', seq_upper)
    return gc / length(seq_upper)
end

function hamming_distance(seq1, seq2)
    return sum([a != b for (a, b) in zip(seq1, seq2)])
end

function jukes_cantor(p)
    if p >= 0.75
        return NaN
    end

    return -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p)
end

function log2_fold_change(treated, control; epsilon = 1.0)
    return log2((treated + epsilon) / (control + epsilon))
end

seq1 = "ATGCTAGCTAACGGTACCTA"
seq2 = "ATGCTGGCTATCGGTACCTA"

mismatches = hamming_distance(seq1, seq2)
p = mismatches / length(seq1)

k = log(4.0) / 4.0

println("transcript_at_4h=", round(transcript_decay(100.0, k, 4.0), digits=6))
println("half_life_h=", round(half_life(k), digits=6))
println("gc_fraction=", round(gc_fraction(seq1), digits=6))
println("hamming_distance=", mismatches)
println("jukes_cantor=", round(jukes_cantor(p), digits=6))
println("log2_fold_change=", round(log2_fold_change(160.0, 40.0, epsilon = 0.0), digits=6))
