# Agriculture and food-systems numerical kernel in Julia.
# Synthetic educational example.

function yield_t_ha(production_tonnes, area_hectares)
    return production_tonnes / area_hectares
end

function nutrient_use_efficiency(nutrient_harvested_kg, nutrient_input_kg)
    return nutrient_harvested_kg / nutrient_input_kg
end

function resilience_index(crop_diversity, soil_function, landscape, pollinator, natural_enemy)
    return 0.25 * crop_diversity + 0.25 * soil_function + 0.20 * landscape + 0.15 * pollinator + 0.15 * natural_enemy
end

println("yield_t_ha=", round(yield_t_ha(850.0, 100.0), digits=5))
println("nutrient_use_efficiency=", round(nutrient_use_efficiency(4800.0, 12000.0), digits=5))
println("resilience_index=", round(resilience_index(0.80, 0.82, 0.88, 0.84, 0.78), digits=5))
