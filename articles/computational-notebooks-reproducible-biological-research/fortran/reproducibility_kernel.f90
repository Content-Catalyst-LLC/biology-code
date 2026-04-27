program reproducibility_kernel
  implicit none

  integer :: required_steps
  integer :: documented_steps
  integer :: failed_cells
  integer :: executed_cells
  real :: completeness
  real :: failure_rate

  required_steps = 6
  documented_steps = 6
  failed_cells = 0
  executed_cells = 4

  completeness = real(documented_steps) / real(required_steps)
  failure_rate = real(failed_cells) / real(executed_cells)

  print *, "workflow_completeness=", completeness
  print *, "failure_rate=", failure_rate

  if (completeness == 1.0 .and. failure_rate == 0.0) then
     print *, "status=pass"
  else
     print *, "status=review"
  end if

end program reproducibility_kernel
