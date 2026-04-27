# Numerical machine-learning kernel for life-science classification in Julia.
# This dependency-free example demonstrates logistic scoring.

sigmoid(z) = 1.0 / (1.0 + exp(-z))

function predict_probability(immune, metabolic, morphology, stress)
    linear_score = 3.0 * immune - 2.0 * metabolic + 2.2 * morphology + 1.2 * stress - 2.0
    return sigmoid(linear_score)
end

samples = [
    ("EXT001", 0.82, 0.22, 0.76, 0.71, 1),
    ("EXT002", 0.74, 0.29, 0.70, 0.67, 1),
    ("EXT003", 0.38, 0.64, 0.39, 0.41, 0),
    ("EXT004", 0.27, 0.71, 0.33, 0.36, 0),
    ("EXT005", 0.63, 0.36, 0.60, 0.59, 1),
    ("EXT006", 0.43, 0.57, 0.45, 0.43, 0),
]

correct = 0

for sample in samples
    id, immune, metabolic, morphology, stress, observed = sample
    p = predict_probability(immune, metabolic, morphology, stress)
    predicted = p >= 0.5 ? 1 : 0
    global correct += predicted == observed ? 1 : 0
    println(id, " probability=", round(p, digits=5), " predicted=", predicted, " observed=", observed)
end

println("accuracy=", round(correct / length(samples), digits=5))
