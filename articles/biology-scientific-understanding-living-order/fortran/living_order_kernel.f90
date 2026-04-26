! Compact living-order numerical kernel in Fortran.

program living_order_kernel
  implicit none

  real :: initial_value
  real :: setpoint
  real :: correction_rate
  real :: final_state
  real :: recovery
  real :: r
  real :: doubling_time
  real :: logistic
  real :: feedback

  initial_value = 10.0
  setpoint = 2.0
  correction_rate = 0.4

  final_state = setpoint + (initial_value - setpoint) * exp(-correction_rate * 5.0)
  recovery = 1.0 - abs(final_state - setpoint) / abs(initial_value - setpoint)

  r = log(735.0 / 100.0) / 10.0
  doubling_time = log(2.0) / r

  logistic = 1200.0 / (1.0 + ((1200.0 - 100.0) / 100.0) * exp(-0.35 * 40.0))
  feedback = 0.5 * (setpoint - initial_value)

  print *, "Homeostatic state at t=5:", final_state
  print *, "Recovery index:", recovery
  print *, "Growth rate:", r
  print *, "Doubling time:", doubling_time
  print *, "Logistic growth t=40:", logistic
  print *, "Feedback response:", feedback
end program living_order_kernel
