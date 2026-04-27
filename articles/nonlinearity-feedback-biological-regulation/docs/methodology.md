# Methodology Notes

## Purpose

The computational examples formalize nonlinear feedback and biological regulation through transparent numerical workflows.

## Saturating Response

response = vmax * signal / (k_half + signal)

## Hill Function

response = signal^n / (k_half^n + signal^n)

## Negative Feedback

dx/dt = -k(x - set_point)

## Positive Feedback Switch

dx/dt = alpha * x^n / (k_half^n + x^n) - beta*x

## Delayed Negative Feedback

dx/dt = production_rate - feedback_strength * x(t - delay)

## Logistic Regulation

dN/dt = rN(1 - N/K)

## Predator-Prey Feedback

dX/dt = alpha X - beta X Y

dY/dt = delta X Y - gamma Y

## Sensitivity

S_p = (p / y) * (dy / dp)

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace domain-specific empirical calibration, validated numerical solvers, uncertainty analysis, regulatory review, or expert biological interpretation.
