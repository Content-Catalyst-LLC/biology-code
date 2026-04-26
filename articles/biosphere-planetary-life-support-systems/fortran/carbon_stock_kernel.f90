! Compact biosphere carbon-stock kernel in Fortran.
!
! This example tracks a simplified biosphere carbon stock under productivity,
! respiration, disturbance, land-use loss, and regrowth.

program carbon_stock_kernel
  implicit none

  integer, parameter :: years = 60
  integer :: year
  real :: biomass
  real :: npp
  real :: respiration
  real :: disturbance
  real :: land_use_loss
  real :: regrowth

  biomass = 100.0
  npp = 8.0
  disturbance = 1.2
  land_use_loss = 0.8

  do year = 1, years
    respiration = 0.035 * biomass
    regrowth = 0.025 * max(0.0, 140.0 - biomass)

    biomass = biomass + npp - respiration - disturbance - land_use_loss + regrowth

    if (biomass < 0.0) biomass = 0.0

    ! Illustrative disturbance pulse every 20 years.
    if (mod(year, 20) == 0) then
      biomass = biomass * 0.92
    end if
  end do

  print *, "Final biosphere functional biomass stock:", biomass
end program carbon_stock_kernel
