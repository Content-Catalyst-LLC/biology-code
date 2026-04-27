! Compact differential-equation biology numerical kernel in Fortran.

program differential_equations_kernel
  implicit none

  integer :: step, steps
  real :: dt
  real :: N, r, K, dN
  real :: x, set_point, k_home, dx
  real :: C, elimination_rate, dC
  real :: S, I, R, beta, gamma, dS, dI, dR, peak_I, time_to_peak

  dt = 0.05

  N = 100.0
  r = 0.30
  K = 2000.0
  steps = int(40.0 / dt) + 1

  do step = 2, steps
    dN = r * N * (1.0 - N / K)
    N = max(N + dN * dt, 0.0)
  end do

  x = 180.0
  set_point = 100.0
  k_home = 0.18
  steps = int(30.0 / dt) + 1

  do step = 2, steps
    dx = -k_home * (x - set_point)
    x = x + dx * dt
  end do

  C = 20.0
  elimination_rate = 0.12
  steps = int(48.0 / dt) + 1

  do step = 2, steps
    dC = -elimination_rate * C
    C = max(C + dC * dt, 0.0)
  end do

  S = 0.99
  I = 0.01
  R = 0.0
  beta = 0.35
  gamma = 0.10
  peak_I = I
  time_to_peak = 0.0
  steps = int(120.0 / dt) + 1

  do step = 2, steps
    if (I > peak_I) then
      peak_I = I
      time_to_peak = real(step - 1) * dt
    end if

    dS = -beta * S * I
    dI = beta * S * I - gamma * I
    dR = gamma * I

    S = max(S + dS * dt, 0.0)
    I = max(I + dI * dt, 0.0)
    R = max(R + dR * dt, 0.0)
  end do

  print *, "Logistic final:", N
  print *, "Homeostasis final:", x
  print *, "PK final:", C
  print *, "SIR peak infected:", peak_I
  print *, "SIR time to peak:", time_to_peak
  print *, "SIR final recovered:", R
end program differential_equations_kernel
