! Compact genomics sequence statistics kernel in Fortran.

program genomics_sequence_kernel
  implicit none

  character(len=64) :: sequence
  integer :: i, seq_len, valid_count, gc_count, ambiguous_count
  character :: base
  real :: gc_content

  sequence = "ATGCGCGTAATTAACCGGTTACCGTAGCTA"
  seq_len = len_trim(sequence)
  valid_count = 0
  gc_count = 0
  ambiguous_count = 0

  do i = 1, seq_len
    base = sequence(i:i)

    if (base == "A" .or. base == "C" .or. base == "G" .or. base == "T") then
      valid_count = valid_count + 1
      if (base == "G" .or. base == "C") gc_count = gc_count + 1
    else
      ambiguous_count = ambiguous_count + 1
    end if
  end do

  if (valid_count > 0) then
    gc_content = real(gc_count) / real(valid_count)
  else
    gc_content = -1.0
  end if

  print *, "sequence_length:", seq_len
  print *, "valid_bases:", valid_count
  print *, "gc_content:", gc_content
  print *, "ambiguous_bases:", ambiguous_count
end program genomics_sequence_kernel
