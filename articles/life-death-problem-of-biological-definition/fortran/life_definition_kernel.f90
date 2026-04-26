! Compact life-definition numerical kernel in Fortran.

program life_definition_kernel
  implicit none

  real :: initial_count
  real :: loss_rate
  real :: viable_48
  real :: half_life
  real :: dormant_20
  real :: activated_20
  real :: total_rate
  real :: bacterium_score
  real :: virus_score

  initial_count = 1.0e6
  loss_rate = log(4.0) / 48.0

  viable_48 = initial_count * exp(-loss_rate * 48.0)
  half_life = log(2.0) / loss_rate

  total_rate = 0.02 + 0.05
  dormant_20 = initial_count * exp(-total_rate * 20.0)
  activated_20 = 0.05 * initial_count * (1.0 - exp(-total_rate * 20.0)) / total_rate

  bacterium_score = 0.18*0.95 + 0.18*0.90 + 0.16*0.88 + 0.18*0.90 + 0.12*0.85 + 0.18*0.90
  virus_score = 0.18*0.55 + 0.18*0.05 + 0.16*0.10 + 0.18*0.82 + 0.12*0.25 + 0.18*0.88

  print *, "Viable count at 48h:", viable_48
  print *, "Half-life:", half_life
  print *, "Dormant pool at 20:", dormant_20
  print *, "Activated pool at 20:", activated_20
  print *, "Bacterium score:", bacterium_score
  print *, "Virus score:", virus_score
end program life_definition_kernel
