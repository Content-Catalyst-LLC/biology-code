program resistance_selection_kernel
  implicit none

  integer :: step, steps
  real :: frequency, selection_advantage, fitness_cost

  frequency = 0.02
  selection_advantage = 0.18
  fitness_cost = 0.04
  steps = 20

  do step = 1, steps
     frequency = frequency * (1.0 + selection_advantage - fitness_cost)
     if (frequency > 1.0) frequency = 1.0
     if (frequency < 0.0) frequency = 0.0
  end do

  print *, "final_resistant_frequency=", frequency

end program resistance_selection_kernel
