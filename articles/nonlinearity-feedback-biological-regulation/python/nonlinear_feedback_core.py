"""
Core nonlinear feedback and biological regulation utilities.

Run:
    python python/nonlinear_feedback_core.py
"""

from __future__ import annotations

from dataclasses import dataclass

import numpy as np
import pandas as pd


@dataclass(frozen=True)
class NegativeFeedbackParameters:
    x0: float
    set_point: float
    k: float
    dt: float
    t_end: float


@dataclass(frozen=True)
class PositiveFeedbackParameters:
    x0: float
    alpha: float
    beta: float
    k_half: float
    hill_coefficient: float
    dt: float
    t_end: float


def time_grid(dt: float, t_end: float) -> np.ndarray:
    if dt <= 0:
        raise ValueError("dt must be positive.")
    if t_end <= 0:
        raise ValueError("t_end must be positive.")
    return np.arange(0, t_end + dt, dt)


def saturating_response(signal, vmax: float, k_half: float):
    """Saturating response similar to Michaelis-Menten or Monod kinetics."""
    signal = np.asarray(signal, dtype=float)
    if vmax < 0:
        raise ValueError("vmax must be non-negative.")
    if k_half <= 0:
        raise ValueError("k_half must be positive.")
    return vmax * signal / (k_half + signal)


def hill_response(signal, k_half: float, hill_coefficient: float):
    """Cooperative nonlinear response."""
    signal = np.asarray(signal, dtype=float)
    if k_half <= 0:
        raise ValueError("k_half must be positive.")
    if hill_coefficient <= 0:
        raise ValueError("hill_coefficient must be positive.")

    numerator = signal ** hill_coefficient
    denominator = k_half ** hill_coefficient + signal ** hill_coefficient
    return numerator / denominator


def simulate_negative_feedback(params: NegativeFeedbackParameters) -> pd.DataFrame:
    if params.k < 0:
        raise ValueError("k must be non-negative.")

    t = time_grid(params.dt, params.t_end)
    x = np.zeros_like(t)
    x[0] = params.x0

    for i in range(1, len(t)):
        dx = -params.k * (x[i - 1] - params.set_point)
        x[i] = x[i - 1] + dx * params.dt

    return pd.DataFrame({"time": t, "state": x})


def simulate_positive_feedback(params: PositiveFeedbackParameters) -> pd.DataFrame:
    if params.alpha < 0 or params.beta < 0:
        raise ValueError("alpha and beta must be non-negative.")
    if params.k_half <= 0 or params.hill_coefficient <= 0:
        raise ValueError("k_half and hill_coefficient must be positive.")

    t = time_grid(params.dt, params.t_end)
    x = np.zeros_like(t)
    x[0] = params.x0

    for i in range(1, len(t)):
        production = params.alpha * x[i - 1] ** params.hill_coefficient / (
            params.k_half ** params.hill_coefficient + x[i - 1] ** params.hill_coefficient
        )
        loss = params.beta * x[i - 1]
        dx = production - loss
        x[i] = max(x[i - 1] + dx * params.dt, 0.0)

    return pd.DataFrame({"time": t, "state": x})


def simulate_delayed_negative_feedback(
    x0: float,
    production_rate: float,
    feedback_strength: float,
    delay: float,
    dt: float,
    t_end: float,
) -> pd.DataFrame:
    if production_rate < 0 or feedback_strength < 0:
        raise ValueError("production_rate and feedback_strength must be non-negative.")
    if delay < 0:
        raise ValueError("delay must be non-negative.")

    t = time_grid(dt, t_end)
    x = np.zeros_like(t)
    x[0] = x0

    delay_steps = max(int(delay / dt), 1)

    for i in range(1, len(t)):
        delayed_index = max(i - delay_steps, 0)
        delayed_state = x[delayed_index]
        dx = production_rate - feedback_strength * delayed_state
        x[i] = max(x[i - 1] + dx * dt, 0.0)

    return pd.DataFrame({"time": t, "state": x})


def simulate_logistic(N0: float, r: float, K: float, dt: float, t_end: float) -> pd.DataFrame:
    if N0 < 0:
        raise ValueError("N0 must be non-negative.")
    if r < 0:
        raise ValueError("r must be non-negative.")
    if K <= 0:
        raise ValueError("K must be positive.")

    t = time_grid(dt, t_end)
    N = np.zeros_like(t)
    N[0] = N0

    for i in range(1, len(t)):
        dN = r * N[i - 1] * (1 - N[i - 1] / K)
        N[i] = max(N[i - 1] + dN * dt, 0.0)

    return pd.DataFrame({"time": t, "population": N})


def normalized_sensitivity(base_output: float, perturbed_output: float, base_parameter: float, perturbed_parameter: float) -> float:
    if base_output == 0 or base_parameter == 0 or perturbed_parameter == base_parameter:
        return float("nan")
    return (base_parameter / base_output) * ((perturbed_output - base_output) / (perturbed_parameter - base_parameter))


def main() -> None:
    signals = np.array([5, 20, 80], dtype=float)
    print("saturating_response=", np.round(saturating_response(signals, 1.0, 20), 4))

    print("hill_response=", np.round(hill_response(signals, 40, 4), 4))

    neg = simulate_negative_feedback(NegativeFeedbackParameters(180, 100, 0.18, 0.05, 30))
    print("negative_feedback_final=", round(neg["state"].iloc[-1], 4))

    pos = simulate_positive_feedback(PositiveFeedbackParameters(2.0, 3.0, 0.8, 1.5, 4, 0.01, 80))
    print("positive_feedback_final=", round(pos["state"].iloc[-1], 4))


if __name__ == "__main__":
    main()
