# Soil organic carbon change for synthetic agriculture systems.

soil <- read.csv(file.path("data", "soil_carbon.csv"), stringsAsFactors = FALSE)

soil$delta_soc_t_ha <- soil$soc_t1_t_ha - soil$soc_t0_t_ha
soil$annualized_soc_change_t_ha_yr <- soil$delta_soc_t_ha / soil$years

soil <- soil[order(-soil$annualized_soc_change_t_ha_yr), ]

print(round(soil, 4))
