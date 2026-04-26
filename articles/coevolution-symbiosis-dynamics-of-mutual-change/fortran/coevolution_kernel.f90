! Compact coevolution and benefit-cost kernel in Fortran.

program coevolution_kernel
  implicit none

  integer :: step
  real :: stress
  real :: benefit
  real :: cost
  real :: net_effect
  real :: host
  real :: pathogen
  real :: infection_pressure
  real :: feedback

  do step = 0, 10
    stress = real(step) / 10.0
    benefit = 0.8 - 0.3 * stress
    cost = 0.2 + 0.4 * stress
    net_effect = benefit - cost

    print *, "Stress:", stress, " Net effect:", net_effect
  end do

  host = 0.4
  pathogen = 0.5
  feedback = 0.03

  do step = 0, 60
    infection_pressure = max(pathogen - host, 0.0)

    if (mod(step, 10) == 0) then
      print *, "Step:", step, " Host:", host, " Pathogen:", pathogen, " Infection:", infection_pressure
    end if

    host = min(max(host + feedback * infection_pressure, 0.0), 1.0)
    pathogen = min(max(pathogen + feedback * max(host - pathogen, 0.0), 0.0), 1.0)
  end do
end program coevolution_kernel
