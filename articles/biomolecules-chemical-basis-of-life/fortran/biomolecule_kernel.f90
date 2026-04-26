! Compact biomolecular numerical kernel in Fortran.

program biomolecule_kernel
  implicit none

  real :: substrate
  real :: vmax
  real :: km
  real :: velocity
  real :: ligand
  real :: kd
  real :: fraction_bound
  real :: diffusion_coefficient
  real :: concentration_gradient
  real :: flux
  integer :: monomer_count
  real :: mean_monomer_mass
  real :: water_loss_per_bond
  real :: polymer_mass

  substrate = 6.0
  vmax = 100.0
  km = 3.0
  velocity = (vmax * substrate) / (km + substrate)

  ligand = 8.0
  kd = 8.0
  fraction_bound = ligand / (kd + ligand)

  diffusion_coefficient = 2.0
  concentration_gradient = -0.8
  flux = -diffusion_coefficient * concentration_gradient

  monomer_count = 12
  mean_monomer_mass = 110.0
  water_loss_per_bond = 18.015
  polymer_mass = monomer_count * mean_monomer_mass - (monomer_count - 1) * water_loss_per_bond

  print *, "Michaelis-Menten velocity:", velocity
  print *, "Fraction bound:", fraction_bound
  print *, "Diffusive flux:", flux
  print *, "Estimated polymer mass:", polymer_mass
end program biomolecule_kernel
