program ml_life_sciences_kernel
  implicit none

  integer, parameter :: n = 6
  integer :: i, observed(n), predicted, correct
  real :: immune(n), metabolic(n), morphology(n), stress(n), probability

  immune = (/0.82, 0.74, 0.38, 0.27, 0.63, 0.43/)
  metabolic = (/0.22, 0.29, 0.64, 0.71, 0.36, 0.57/)
  morphology = (/0.76, 0.70, 0.39, 0.33, 0.60, 0.45/)
  stress = (/0.71, 0.67, 0.41, 0.36, 0.59, 0.43/)
  observed = (/1, 1, 0, 0, 1, 0/)

  correct = 0

  do i = 1, n
     probability = sigmoid(3.0 * immune(i) - 2.0 * metabolic(i) + 2.2 * morphology(i) + 1.2 * stress(i) - 2.0)

     if (probability >= 0.5) then
        predicted = 1
     else
        predicted = 0
     end if

     if (predicted == observed(i)) correct = correct + 1

     print *, "sample=", i, " probability=", probability, " predicted=", predicted, " observed=", observed(i)
  end do

  print *, "accuracy=", real(correct) / real(n)

contains

  real function sigmoid(z)
    real, intent(in) :: z
    sigmoid = 1.0 / (1.0 + exp(-z))
  end function sigmoid

end program ml_life_sciences_kernel
