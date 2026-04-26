! Compact mathematical-biology numerical kernel in Fortran.

program math_biology_kernel
  implicit none

  integer :: step, nsteps
  real :: t, dt
  real :: n0, r, k, logistic_final
  real :: s, i, recovered, beta, gamma, ds, di, dr
  real :: peak_i, time_to_peak
  real :: prey, predator, alpha, pred_beta, delta, pred_gamma
  real :: dprey, dpredator
  real :: substrate, vmax, km, velocity

  n0 = 100.0
  r = 0.30
  k = 2000.0
  t = 40.0
  logistic_final = k / (1.0 + ((k - n0) / n0) * exp(-r * t))

  beta = 0.35
  gamma = 0.10
  s = 0.99
  i = 0.01
  recovered = 0.0
  dt = 0.05
  nsteps = int(120.0 / dt)
  peak_i = i
  time_to_peak = 0.0

  do step = 1, nsteps
    if (i > peak_i) then
      peak_i = i
      time_to_peak = step * dt
    end if

    ds = -beta * s * i
    di = beta * s * i - gamma * i
    dr = gamma * i

    s = max(s + ds * dt, 0.0)
    i = max(i + di * dt, 0.0)
    recovered = max(recovered + dr * dt, 0.0)
  end do

  prey = 40.0
  predator = 9.0
  alpha = 0.60
  pred_beta = 0.025
  delta = 0.018
  pred_gamma = 0.35
  dt = 0.01
  nsteps = int(80.0 / dt)

  do step = 1, nsteps
    dprey = alpha * prey - pred_beta * prey * predator
    dpredator = delta * prey * predator - pred_gamma * predator

    prey = max(prey + dprey * dt, 0.0)
    predator = max(predator + dpredator * dt, 0.0)
  end do

  substrate = 5.0
  vmax = 10.0
  km = 2.0
  velocity = vmax * substrate / (km + substrate)

  print *, "Logistic final:", logistic_final
  print *, "SIR peak infected:", peak_i
  print *, "SIR time to peak:", time_to_peak
  print *, "SIR final recovered:", recovered
  print *, "Final prey:", prey
  print *, "Final predator:", predator
  print *, "Michaelis-Menten velocity:", velocity
end program math_biology_kernel
