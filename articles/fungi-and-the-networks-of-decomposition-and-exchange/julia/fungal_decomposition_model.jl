# Fungal decomposition and biomass recovery model in Julia.
#
# This compact workflow calculates effective decomposition rates and simulates
# fungal biomass recovery after disturbance and restoration.

function temp_multiplier(temp; tref=10.0, q10=2.0)
    return q10 ^ ((temp - tref) / 10.0)
end

function moisture_multiplier(moisture; m_opt=0.6, sigma=0.22)
    return exp(-((moisture - m_opt)^2) / (2 * sigma^2))
end

function quality_multiplier(lignin_n; slope=0.03)
    return exp(-slope * lignin_n)
end

function guild_multiplier(guild)
    if guild == "white_rot"
        return 1.20
    elseif guild == "brown_rot"
        return 0.95
    elseif guild == "mixed_saprotroph"
        return 1.00
    elseif guild == "disturbance_simplified"
        return 0.72
    else
        return 1.00
    end
end

function effective_k(k0, temp, moisture, lignin_n, guild)
    return k0 *
        temp_multiplier(temp) *
        moisture_multiplier(moisture) *
        quality_multiplier(lignin_n) *
        guild_multiplier(guild)
end

sites = [
    ("cool_conifer_forest", 100.0, 0.07, 9.0, 0.65, 18.0, "white_rot"),
    ("warm_restoration_site", 100.0, 0.07, 18.0, 0.58, 14.0, "mixed_saprotroph"),
    ("drought_stressed_woodland", 100.0, 0.07, 22.0, 0.25, 20.0, "disturbance_simplified"),
    ("nutrient_enriched_riparian", 100.0, 0.07, 16.0, 0.72, 12.0, "white_rot")
]

for site in sites
    name, M0, k0, temp, moisture, lignin_n, guild = site
    k_eff = effective_k(k0, temp, moisture, lignin_n, guild)
    remaining = M0 * exp(-k_eff * 24.0)
    half_life = log(2.0) / k_eff

    println(
        "site=", name,
        " k_eff=", round(k_eff, digits=4),
        " remaining_t24=", round(remaining, digits=3),
        " half_life=", round(half_life, digits=3)
    )
end

function biomass_recovery(; days=240, B0=3.0, r=0.045, K=60.0, m=0.018)
    biomass = B0

    for day in 1:days
        d_biomass = r * biomass * (1.0 - biomass / K) - m * biomass
        biomass = max(0.0, biomass + d_biomass)
    end

    return biomass
end

println("Example recovery biomass: ", round(biomass_recovery(), digits=3))
