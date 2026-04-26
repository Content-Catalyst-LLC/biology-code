# Behavioral strategy model in Julia.
#
# This compact workflow calculates softmax behavioral choice and
# sender-receiver signaling scores.

using Statistics

function softmax(values; beta=1.0)
    centered = values .- maximum(values)
    ex = exp.(beta .* centered)
    return ex ./ sum(ex)
end

options = [
    ("safe_foraging", 8.0, 2.0, 1.0),
    ("risky_foraging", 14.0, 5.0, 6.0),
    ("territorial_display", 10.0, 4.0, 3.0),
    ("mate_search", 12.0, 6.0, 5.0)
]

utilities = [
    benefit - 0.8 * energetic_cost - 1.2 * predation_risk
    for (_, benefit, energetic_cost, predation_risk) in options
]

probabilities = softmax(utilities, beta=1.1)

for (i, option) in enumerate(options)
    println(
        "option=", option[1],
        " utility=", round(utilities[i], digits=3),
        " choice_probability=", round(probabilities[i], digits=3)
    )
end

signals = [
    ("quiet_signal", 6.0, 1.0, 1.0, 0.45),
    ("loud_signal", 12.0, 5.0, 7.0, 0.90),
    ("multimodal_signal", 10.0, 4.0, 4.0, 0.85),
    ("cryptic_display", 4.0, 1.0, 0.5, 0.30)
]

receiver_state = 0.75

for signal in signals
    strategy, mate_benefit, energetic_cost, predator_exposure, detectability = signal

    sender_utility = mate_benefit - 0.8 * energetic_cost - 1.1 * predator_exposure
    receiver_response = 1 / (1 + exp(-6 * (detectability * receiver_state - 0.35)))
    combined_score = sender_utility * receiver_response

    println(
        "strategy=", strategy,
        " sender_utility=", round(sender_utility, digits=3),
        " receiver_response=", round(receiver_response, digits=3),
        " combined_score=", round(combined_score, digits=3)
    )
end
