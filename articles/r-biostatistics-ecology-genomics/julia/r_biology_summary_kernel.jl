# R biology summary kernel in Julia.

function mean_value(values)
    return sum(values) / length(values)
end

function sample_sd(values)
    m = mean_value(values)
    return sqrt(sum((values .- m).^2) / (length(values) - 1))
end

function shannon_diversity(counts)
    positive = filter(x -> x > 0, counts)
    total = sum(positive)
    p = positive ./ total
    return -sum(p .* log.(p))
end

function log2_fold_change(control, treated; pseudocount=1.0)
    return log2((mean_value(treated) + pseudocount) / (mean_value(control) + pseudocount))
end

control = [10.2, 10.5, 10.1, 10.4, 10.3, 10.6]
treated = [12.1, 12.4, 11.9, 12.0, 12.5]
counts = [18.0, 7.0, 3.0, 0.0]
gene_control = [120.0, 130.0, 125.0]
gene_treated = [300.0, 310.0, 290.0]

println("control_mean=", round(mean_value(control), digits=5))
println("treated_mean=", round(mean_value(treated), digits=5))
println("control_sd=", round(sample_sd(control), digits=5))
println("shannon_diversity=", round(shannon_diversity(counts), digits=5))
println("gene_log2_fold_change=", round(log2_fold_change(gene_control, gene_treated), digits=5))
