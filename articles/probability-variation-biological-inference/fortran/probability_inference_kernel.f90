! Compact probability and biological inference numerical kernel in Fortran.

program probability_inference_kernel
  implicit none

  integer :: successes, trials, failures
  real :: estimate, se, ci_lower, ci_upper
  real :: alpha_prior, beta_prior, alpha_post, beta_post
  real :: posterior_mean, posterior_variance, posterior_sd
  real :: p, ll, best_p, best_ll

  successes = 68
  trials = 100
  failures = trials - successes

  estimate = real(successes) / real(trials)
  se = sqrt(estimate * (1.0 - estimate) / real(trials))
  ci_lower = max(estimate - 1.96 * se, 0.0)
  ci_upper = min(estimate + 1.96 * se, 1.0)

  alpha_prior = 1.0
  beta_prior = 1.0
  alpha_post = alpha_prior + real(successes)
  beta_post = beta_prior + real(failures)
  posterior_mean = alpha_post / (alpha_post + beta_post)
  posterior_variance = (alpha_post * beta_post) / ((alpha_post + beta_post)**2 * (alpha_post + beta_post + 1.0))
  posterior_sd = sqrt(posterior_variance)

  best_ll = -1.0e30
  best_p = 0.0

  do p = 0.10, 0.90, 0.01
    ll = real(successes) * log(p) + real(failures) * log(1.0 - p)
    if (ll > best_ll) then
      best_ll = ll
      best_p = p
    end if
  end do

  print *, "Estimate:", estimate
  print *, "Standard error:", se
  print *, "CI lower:", ci_lower
  print *, "CI upper:", ci_upper
  print *, "Posterior mean:", posterior_mean
  print *, "Posterior sd:", posterior_sd
  print *, "Best likelihood p:", best_p
  print *, "Best log likelihood:", best_ll
end program probability_inference_kernel
