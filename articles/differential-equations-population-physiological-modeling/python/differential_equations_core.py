"""
Core differential-equation utilities for biological modeling.

Run:
    python python/differential_equations_core.py
"""

from __future__ import annotations

from dataclasses import dataclass
import math

import numpy as np
import pandas as pd


@dataclass(frozen=True)
class LogisticParameters:
    N0: float
    r: float
    K: float
    dt: float
    t_end: float


@dataclass(frozen=True)
class PredatorPreyParameters:
    prey0: float
    predator0: float
    alpha: float
    beta: float
    delta: float
    gamma: float
    dt: float
    t_end: float


@dataclass(frozen=True)
class SIRParameters:
    beta: float
    gamma: float
    S0: float
    I0: float
    R0: float
    dt: float
    t_end: float


def time_grid(dt: float, t_end: float) -> np.ndarray:
    if dt <= 0:
        raise ValueError("dt must be positive.")
    if t_end <= 0:
        raise ValueError("t_end must be positive.")
    return np.arange(0, t_end + dt, dt)


def simulate_logistic(params: LogisticParameters) -> pd.DataFrame:
    if params.N0 <= 0:
        raise ValueError("N0 must be positive.")
    if params.r < 0:
        raise ValueError("r must be non-negative.")
    if params.K <= params.N0:
        raise ValueError("K should exceed N0 for this logistic example.")

    t = time_grid(params.dt, params.t_end)
    N = np.zeros_like(t)
    N[0] = params.N0

    for i in range(1, len(t)):
        dN = params.r * N[i - 1] * (1 - N[i - 1] / params.K)
        N[i] = max(N[i - 1] + dN * params.dt, 0.0)

    return pd.DataFrame({"time": t, "population": N})


def simulate_predator_prey(params: PredatorPreyParameters) -> pd.DataFrame:
    if min(params.prey0, params.predator0, params.alpha, params.beta, params.delta, params.gamma) < 0:
        raise ValueError("Predator-prey states and rates must be non-negative.")

    t = time_grid(params.dt, params.t_end)
    prey = np.zeros_like(t)
    predator = np.zeros_like(t)

    prey[0] = params.prey0
    predator[0] = params.predator0

    for i in range(1, len(t)):
        dprey = params.alpha * prey[i - 1] - params.beta * prey[i - 1] * predator[i - 1]
        dpredator = params.delta * prey[i - 1] * predator[i - 1] - params.gamma * predator[i - 1]

        prey[i] = max(prey[i - 1] + dprey * params.dt, 0.0)
        predator[i] = max(predator[i - 1] + dpredator * params.dt, 0.0)

    return pd.DataFrame({"time": t, "prey": prey, "predator": predator})


def simulate_sir(params: SIRParameters) -> pd.DataFrame:
    if params.beta < 0 or params.gamma < 0:
        raise ValueError("beta and gamma must be non-negative.")
    if min(params.S0, params.I0, params.R0) < 0:
        raise ValueError("initial compartments must be non-negative.")

    t = time_grid(params.dt, params.t_end)
    S = np.zeros_like(t)
    I = np.zeros_like(t)
    R = np.zeros_like(t)

    S[0] = params.S0
    I[0] = params.I0
    R[0] = params.R0

    for i in range(1, len(t)):
        dS = -params.beta * S[i - 1] * I[i - 1]
        dI = params.beta * S[i - 1] * I[i - 1] - params.gamma * I[i - 1]
        dR = params.gamma * I[i - 1]

        S[i] = max(S[i - 1] + dS * params.dt, 0.0)
        I[i] = max(I[i - 1] + dI * params.dt, 0.0)
        R[i] = max(R[i - 1] + dR * params.dt, 0.0)

    return pd.DataFrame({"time": t, "susceptible": S, "infected": I, "recovered": R})


def simulate_homeostasis(x0: float, set_point: float, k: float, dt: float, t_end: float) -> pd.DataFrame:
    if k < 0:
        raise ValueError("k must be non-negative.")

    t = time_grid(dt, t_end)
    x = np.zeros_like(t)
    x[0] = x0

    for i in range(1, len(t)):
        dx = -k * (x[i - 1] - set_point)
        x[i] = x[i - 1] + dx * dt

    return pd.DataFrame({"time": t, "state": x})


def simulate_one_compartment(C0: float, elimination_rate: float, dt: float, t_end: float) -> pd.DataFrame:
    if C0 < 0:
        raise ValueError("C0 must be non-negative.")
    if elimination_rate < 0:
        raise ValueError("elimination_rate must be non-negative.")

    t = time_grid(dt, t_end)
    C = np.zeros_like(t)
    C[0] = C0

    for i in range(1, len(t)):
        dC = -elimination_rate * C[i - 1]
        C[i] = max(C[i - 1] + dC * dt, 0.0)

    return pd.DataFrame({"time": t, "concentration": C})


def monod_growth(substrate: float, mu_max: float, K_s: float) -> float:
    if K_s <= 0:
        raise ValueError("K_s must be positive.")
    return mu_max * substrate / (K_s + substrate)


def simulate_chemostat(
    X0: float,
    S0: float,
    S_in: float,
    D: float,
    Y: float,
    mu_max: float,
    K_s: float,
    dt: float,
    t_end: float,
) -> pd.DataFrame:
    if min(X0, S0, S_in, D, mu_max, K_s) < 0:
        raise ValueError("Chemostat states and rate parameters must be non-negative.")
    if Y <= 0:
        raise ValueError("yield coefficient Y must be positive.")

    t = time_grid(dt, t_end)
    X = np.zeros_like(t)
    S = np.zeros_like(t)

    X[0] = X0
    S[0] = S0

    for i in range(1, len(t)):
        mu = monod_growth(S[i - 1], mu_max, K_s)
        dX = mu * X[i - 1] - D * X[i - 1]
        dS = D * (S_in - S[i - 1]) - (1 / Y) * mu * X[i - 1]

        X[i] = max(X[i - 1] + dX * dt, 0.0)
        S[i] = max(S[i - 1] + dS * dt, 0.0)

    return pd.DataFrame({"time": t, "biomass": X, "substrate": S})


def main() -> None:
    logistic = simulate_logistic(LogisticParameters(100, 0.30, 2000, 0.05, 40))
    print("logistic_final=", round(logistic["population"].iloc[-1], 4))

    sir = simulate_sir(SIRParameters(0.35, 0.10, 0.99, 0.01, 0.0, 0.05, 120))
    print("sir_peak_infected=", round(sir["infected"].max(), 6))

    home = simulate_homeostasis(180, 100, 0.18, 0.05, 30)
    print("homeostasis_final=", round(home["state"].iloc[-1], 4))

    pk = simulate_one_compartment(20.0, 0.12, 0.05, 48)
    print("pk_final=", round(pk["concentration"].iloc[-1], 4))

    chem = simulate_chemostat(0.1, 10, 20, 0.20, 0.50, 0.80, 2.0, 0.01, 80)
    print("chemostat_final_biomass=", round(chem["biomass"].iloc[-1], 4))


if __name__ == "__main__":
    main()
