! Compact signaling numerical kernel in Fortran.

program signaling_kernel
  implicit none

  real :: L
  real :: Kd
  real :: K
  real :: n
  real :: occupancy
  real :: hill
  real :: k_decay
  real :: half_life
  real :: signal_4
  real :: Q
  real :: N
  real :: a
  real :: d
  real :: dt
  real :: Q_next

  L = 3.0
  Kd = 1.5
  K = 2.0
  n = 3.0

  occupancy = L / (Kd + L)
  hill = (L ** n) / (K ** n + L ** n)

  k_decay = log(4.0) / 4.0
  half_life = log(2.0) / k_decay
  signal_4 = 100.0 * exp(-k_decay * 4.0)

  Q = 0.5
  N = 1.0e8
  a = 1.0e-9
  d = 0.35
  dt = 0.1
  Q_next = Q + (a * N - d * Q) * dt

  if (Q_next < 0.0) Q_next = 0.0

  print *, "Occupancy:", occupancy
  print *, "Hill response:", hill
  print *, "Signal at 4 min:", signal_4
  print *, "Half-life:", half_life
  print *, "Quorum next:", Q_next
end program signaling_kernel
