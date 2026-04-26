! Compact cell-architecture numerical kernel in Fortran.

program cell_architecture_kernel
  implicit none

  real :: radius
  real :: surface_area
  real :: volume
  real :: sa_to_volume
  real :: permeability
  real :: c_out
  real :: c_in
  real :: membrane_flux
  real :: diffusion_coefficient
  real :: gradient
  real :: diff_flux
  real :: cell_area
  real :: mitochondrial_area
  real :: lysosome_count
  real :: mito_fraction
  real :: lysosome_density

  radius = 5.0
  surface_area = 4.0 * 3.14159265 * radius ** 2
  volume = (4.0 / 3.0) * 3.14159265 * radius ** 3
  sa_to_volume = surface_area / volume

  permeability = 0.05
  c_out = 10.0
  c_in = 3.0
  membrane_flux = permeability * (c_out - c_in)

  diffusion_coefficient = 2.0
  gradient = -0.8
  diff_flux = -diffusion_coefficient * gradient

  cell_area = 420.0
  mitochondrial_area = 62.0
  lysosome_count = 18.0
  mito_fraction = mitochondrial_area / cell_area
  lysosome_density = lysosome_count / cell_area

  print *, "Surface area:", surface_area
  print *, "Volume:", volume
  print *, "SA:V:", sa_to_volume
  print *, "Membrane flux:", membrane_flux
  print *, "Diffusive flux:", diff_flux
  print *, "Mitochondrial fraction:", mito_fraction
  print *, "Lysosome density:", lysosome_density
end program cell_architecture_kernel
