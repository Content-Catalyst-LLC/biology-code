# Biology ethics numerical kernel in Julia.
# Synthetic educational example.

function ethical_review_score(benefit, harm, uncertainty, consent, justice, reversibility)
    return benefit * 0.25 - harm * 0.20 - uncertainty * 0.15 + consent * 0.15 + justice * 0.15 + reversibility * 0.10
end

function ecological_risk(exposure, magnitude, uncertainty, reversibility)
    risk = exposure * magnitude * uncertainty
    adjusted = risk * (1.0 - reversibility)
    return risk, adjusted
end

score = ethical_review_score(0.80, 0.25, 0.30, 0.75, 0.60, 0.70)
risk, adjusted = ecological_risk(0.75, 0.70, 0.80, 0.20)

println("ethical_review_score=", round(score, digits=5))
println("ecological_risk=", round(risk, digits=5))
println("reversibility_adjusted_risk=", round(adjusted, digits=5))
