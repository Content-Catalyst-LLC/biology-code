# Numerical biotechnology intervention kernel in Julia.
# Synthetic educational example.

function responsibility_score(benefit, harm, uncertainty, reversibility, access_equity, governance)
    return benefit * 0.30 + access_equity * 0.20 + reversibility * 0.20 + governance * 0.15 - harm * 0.10 - uncertainty * 0.05
end

function ecological_risk(exposure, magnitude, uncertainty, monitoring, reversibility)
    risk = exposure * magnitude * uncertainty
    governance_buffer = monitoring * reversibility
    net_concern = risk * (1.0 - governance_buffer)
    return risk, governance_buffer, net_concern
end

score = responsibility_score(0.85, 0.20, 0.30, 0.60, 0.35, 0.70)
risk, buffer, concern = ecological_risk(0.85, 0.75, 0.80, 0.40, 0.15)

println("responsibility_score=", round(score, digits=5))
println("ecological_risk=", round(risk, digits=5))
println("governance_buffer=", round(buffer, digits=5))
println("net_concern=", round(concern, digits=5))
