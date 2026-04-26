! Compact payoff and softmax choice kernel in Fortran.
!
! This example calculates utilities and softmax probabilities for four
! behavioral options.

program payoff_choice_kernel
  implicit none

  integer, parameter :: n = 4
  integer :: i
  real :: benefit(n)
  real :: energetic_cost(n)
  real :: predation_risk(n)
  real :: utility(n)
  real :: ex(n)
  real :: beta
  real :: max_utility
  real :: denom

  benefit = (/8.0, 14.0, 10.0, 12.0/)
  energetic_cost = (/2.0, 5.0, 4.0, 6.0/)
  predation_risk = (/1.0, 6.0, 3.0, 5.0/)
  beta = 1.1

  do i = 1, n
    utility(i) = benefit(i) - 0.8 * energetic_cost(i) - 1.2 * predation_risk(i)
  end do

  max_utility = maxval(utility)
  denom = 0.0

  do i = 1, n
    ex(i) = exp(beta * (utility(i) - max_utility))
    denom = denom + ex(i)
  end do

  do i = 1, n
    print *, "option", i, "utility", utility(i), "probability", ex(i) / denom
  end do
end program payoff_choice_kernel
