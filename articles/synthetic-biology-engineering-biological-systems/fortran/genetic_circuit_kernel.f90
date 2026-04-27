program genetic_circuit_kernel
  implicit none

  integer :: step, steps
  real :: x, dx, production_rate, input_strength, degradation_rate, dt

  x = 0.05
  production_rate = 1.20
  input_strength = 0.90
  degradation_rate = 0.40
  dt = 0.10
  steps = 80

  do step = 1, steps
     dx = production_rate * input_strength - degradation_rate * x
     x = max(x + dt * dx, 0.0)
  end do

  print *, "final_output_high_input=", x

end program genetic_circuit_kernel
