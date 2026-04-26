! Compact membrane integration and threshold kernel in Fortran.
!
! This example simulates a membrane-like state variable moving toward rest
! under repeated input pulses.

program membrane_integration_kernel
  implicit none

  integer, parameter :: n_steps = 401
  integer :: i
  real :: dt
  real :: time
  real :: tau
  real :: v_rest
  real :: resistance_scale
  real :: threshold
  real :: input_value
  real :: voltage
  real :: d_voltage
  integer :: event_count
  real :: max_voltage

  dt = 0.1
  tau = 3.0
  v_rest = -65.0
  resistance_scale = 1.0
  threshold = -60.0
  voltage = v_rest
  max_voltage = voltage
  event_count = 0

  do i = 1, n_steps
    time = (i - 1) * dt

    input_value = 0.0
    if (time >= 5.0 .and. time < 8.0) input_value = 8.0
    if (time >= 15.0 .and. time < 17.0) input_value = 5.0
    if (time >= 28.0 .and. time < 31.0) input_value = 10.0

    d_voltage = (-(voltage - v_rest) + resistance_scale * input_value) / tau
    voltage = voltage + d_voltage * dt

    if (voltage > max_voltage) max_voltage = voltage
    if (voltage >= threshold) event_count = event_count + 1
  end do

  print *, "Max voltage:", max_voltage
  print *, "Event count:", event_count
  print *, "Final voltage:", voltage
end program membrane_integration_kernel
