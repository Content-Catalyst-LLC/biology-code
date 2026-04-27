! Computational ecology kernel in Fortran.

program computational_ecology_kernel
  implicit none

  real :: suitability, score
  real :: occupancy, colonization, extinction
  real :: runoff
  integer :: step

  score = -2.0 + 0.05 * 16.2 + 0.0015 * 820.0 + 2.4 * 0.82 - 2.0 * 0.18
  suitability = 1.0 / (1.0 + exp(-score))

  occupancy = 0.42
  colonization = 0.12
  extinction = 0.08

  do step = 1, 30
    occupancy = occupancy * (1.0 - extinction) + (1.0 - occupancy) * colonization
    if (occupancy < 0.0) occupancy = 0.0
    if (occupancy > 1.0) occupancy = 1.0
  end do

  runoff = 42.0 * (1.0 - 0.62) * 0.30

  print *, "suitability:", suitability
  print *, "final_occupancy:", occupancy
  print *, "runoff_mm:", runoff
end program computational_ecology_kernel
