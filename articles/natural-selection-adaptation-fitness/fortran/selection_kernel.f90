! Compact natural selection numerical kernel in Fortran.

program selection_kernel
  implicit none

  real :: p
  real :: q
  real :: w_AA
  real :: w_Aa
  real :: w_aa
  real :: wbar
  real :: p_next
  real :: selected_offspring_AA
  real :: selected_offspring_Aa
  real :: selected_offspring_aa
  real :: max_offspring
  real :: h2
  real :: S
  real :: R

  p = 0.2
  q = 1.0 - p

  w_AA = 1.15
  w_Aa = 1.08
  w_aa = 1.0

  wbar = p ** 2 * w_AA + 2.0 * p * q * w_Aa + q ** 2 * w_aa
  p_next = (p ** 2 * w_AA + p * q * w_Aa) / wbar

  print *, "Mean fitness:", wbar
  print *, "p_next:", p_next
  print *, "delta_p:", p_next - p

  selected_offspring_AA = 8.0
  selected_offspring_Aa = 10.0
  selected_offspring_aa = 5.0
  max_offspring = 10.0

  print *, "relative fitness AA:", selected_offspring_AA / max_offspring
  print *, "relative fitness Aa:", selected_offspring_Aa / max_offspring
  print *, "relative fitness aa:", selected_offspring_aa / max_offspring

  h2 = 0.40
  S = 0.62
  R = h2 * S

  print *, "Breeder equation response:", R
end program selection_kernel
