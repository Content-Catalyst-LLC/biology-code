program yield_water_productivity_kernel
  implicit none

  real :: production_tonnes
  real :: area_hectares
  real :: water_used_m3
  real :: yield_t_ha
  real :: water_productivity

  production_tonnes = 850.0
  area_hectares = 100.0
  water_used_m3 = 420000.0

  yield_t_ha = production_tonnes / area_hectares
  water_productivity = production_tonnes / water_used_m3

  print *, "yield_t_ha=", yield_t_ha
  print *, "water_productivity_t_per_m3=", water_productivity

end program yield_water_productivity_kernel
