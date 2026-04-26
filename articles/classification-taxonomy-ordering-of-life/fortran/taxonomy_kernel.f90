! Compact taxonomy numerical kernel in Fortran.

program taxonomy_kernel
  implicit none

  real :: p
  real :: jc
  real :: counts(4)
  real :: total
  real :: shannon
  real :: confidence
  integer :: i

  p = 2.0 / 12.0
  jc = -0.75 * log(1.0 - (4.0 / 3.0) * p)

  counts = (/25.0, 18.0, 11.0, 6.0/)
  total = sum(counts)
  shannon = 0.0

  do i = 1, 4
    shannon = shannon - (counts(i) / total) * log(counts(i) / total)
  end do

  confidence = 0.30*0.98 + 0.20*0.90 + 0.15*0.88 + 0.25*0.94 - 0.10*0.05

  print *, "p-distance:", p
  print *, "Jukes-Cantor:", jc
  print *, "Shannon diversity:", shannon
  print *, "Taxonomic confidence:", confidence
end program taxonomy_kernel
