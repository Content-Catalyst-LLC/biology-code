! Compact microscopy image-analysis kernel in Fortran.

program microscopy_image_analysis_kernel
  implicit none

  integer :: x, y, foreground_pixels
  real :: threshold, intensity, integrated_intensity

  threshold = 65.0
  foreground_pixels = 0
  integrated_intensity = 0.0

  do y = 0, 63
    do x = 0, 63
      intensity = synthetic_intensity(real(x), real(y))

      if (intensity >= threshold) then
        foreground_pixels = foreground_pixels + 1
        integrated_intensity = integrated_intensity + intensity
      end if
    end do
  end do

  print *, "foreground_pixels:", foreground_pixels
  print *, "integrated_intensity:", integrated_intensity

contains

  real function gaussian_intensity(x, y, cx, cy, sigma, amplitude)
    real, intent(in) :: x, y, cx, cy, sigma, amplitude
    real :: distance_squared

    distance_squared = (x - cx)**2 + (y - cy)**2
    gaussian_intensity = amplitude * exp(-distance_squared / (2.0 * sigma**2))
  end function gaussian_intensity

  real function synthetic_intensity(x, y)
    real, intent(in) :: x, y

    synthetic_intensity = 18.0 &
      + gaussian_intensity(x, y, 18.0, 20.0, 4.0, 140.0) &
      + gaussian_intensity(x, y, 42.0, 25.0, 5.0, 170.0) &
      + gaussian_intensity(x, y, 30.0, 45.0, 4.5, 155.0)
  end function synthetic_intensity

end program microscopy_image_analysis_kernel
