! Compact molecular information-flow numerical kernel in Fortran.

program molecular_flow_kernel
  implicit none

  real :: m0
  real :: k
  real :: t
  real :: expression
  real :: half_life
  real :: treated
  real :: control
  real :: log2fc
  real :: p_distance
  real :: jc
  real :: mutations
  real :: genomes
  real :: sites
  real :: generations
  real :: mu

  m0 = 100.0
  k = log(4.0) / 4.0
  t = 4.0

  expression = m0 * exp(-k * t)
  half_life = log(2.0) / k

  treated = 160.0
  control = 40.0
  log2fc = log(treated / control) / log(2.0)

  p_distance = 2.0 / 20.0
  jc = -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p_distance)

  mutations = 12.0
  genomes = 1000.0
  sites = 100000.0
  generations = 1.0
  mu = mutations / (genomes * sites * generations)

  print *, "Transcript at 4h:", expression
  print *, "Half-life:", half_life
  print *, "log2FC:", log2fc
  print *, "Jukes-Cantor distance:", jc
  print *, "Mutation rate:", mu
end program molecular_flow_kernel
