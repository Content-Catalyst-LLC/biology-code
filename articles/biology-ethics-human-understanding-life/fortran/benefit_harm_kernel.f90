program benefit_harm_kernel
  implicit none

  real :: benefit
  real :: harm
  real :: uncertainty
  real :: consent
  real :: justice
  real :: reversibility
  real :: score

  benefit = 0.80
  harm = 0.25
  uncertainty = 0.30
  consent = 0.75
  justice = 0.60
  reversibility = 0.70

  score = benefit * 0.25 - harm * 0.20 - uncertainty * 0.15 + consent * 0.15 + justice * 0.15 + reversibility * 0.10

  print *, "ethical_review_score=", score

end program benefit_harm_kernel
