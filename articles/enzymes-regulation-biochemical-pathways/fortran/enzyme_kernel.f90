! Compact enzyme kinetic numerical kernel in Fortran.

program enzyme_kernel
  implicit none

  real :: S
  real :: Vmax
  real :: Km
  real :: I
  real :: Ki
  real :: P
  real :: Kf
  real :: v_control
  real :: v_competitive
  real :: v_noncompetitive
  real :: v_feedback
  real :: kcat
  real :: efficiency

  S = 10.0
  Vmax = 120.0
  Km = 5.0
  I = 4.0
  Ki = 2.0
  P = 8.0
  Kf = 6.0
  kcat = 75.0

  v_control = (Vmax * S) / (Km + S)
  v_competitive = (Vmax * S) / (Km * (1.0 + I / Ki) + S)
  v_noncompetitive = (Vmax / (1.0 + I / Ki)) * S / (Km + S)
  v_feedback = v_control / (1.0 + P / Kf)
  efficiency = kcat / Km

  print *, "Control velocity:", v_control
  print *, "Competitive inhibition velocity:", v_competitive
  print *, "Noncompetitive inhibition velocity:", v_noncompetitive
  print *, "Feedback velocity:", v_feedback
  print *, "Catalytic efficiency:", efficiency
end program enzyme_kernel
