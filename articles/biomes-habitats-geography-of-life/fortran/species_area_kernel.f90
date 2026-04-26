! Compact species-area numerical kernel in Fortran.
!
! Computes expected species richness using S = c * A^z.

program species_area_kernel
  implicit none

  real :: c
  real :: z
  real :: area
  real :: richness

  c = 10.0
  z = 0.25
  area = 100.0

  richness = c * area ** z

  print *, "Expected species richness:", richness
end program species_area_kernel
