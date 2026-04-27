"""
Core utilities for disease modeling, epidemiology, and biological spread.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import math
import random

import pandas as pd


def simulate_sir(
    scenario: str,
    population: float,
    initial_susceptible: float,
    initial_infected: float,
    initial_recovered: float,
    beta: float,
    gamma: float,
    dt: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate a deterministic SIR model using Euler approximation."""
    susceptible = float(initial_susceptible)
    infected = float(initial_infected)
    recovered = float(initial_recovered)
    rows = []

    for step in range(steps + 1):
        rows.append(
            {
                "model": "SIR",
                "scenario": scenario,
                "step": step,
                "time": step * dt,
                "susceptible": susceptible,
                "infected": infected,
                "recovered": recovered,
            }
        )

        new_infections = beta * susceptible * infected / population
        new_recoveries = gamma * infected

        susceptible = max(susceptible - dt * new_infections, 0.0)
        infected = max(infected + dt * (new_infections - new_recoveries), 0.0)
        recovered = min(recovered + dt * new_recoveries, population)

    return pd.DataFrame(rows)


def simulate_seir(
    scenario: str,
    population: float,
    initial_susceptible: float,
    initial_exposed: float,
    initial_infected: float,
    initial_recovered: float,
    beta: float,
    sigma: float,
    gamma: float,
    dt: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate a deterministic SEIR model using Euler approximation."""
    susceptible = float(initial_susceptible)
    exposed = float(initial_exposed)
    infected = float(initial_infected)
    recovered = float(initial_recovered)
    rows = []

    for step in range(steps + 1):
        rows.append(
            {
                "model": "SEIR",
                "scenario": scenario,
                "step": step,
                "time": step * dt,
                "susceptible": susceptible,
                "exposed": exposed,
                "infected": infected,
                "recovered": recovered,
            }
        )

        new_exposures = beta * susceptible * infected / population
        new_infections = sigma * exposed
        new_recoveries = gamma * infected

        susceptible = max(susceptible - dt * new_exposures, 0.0)
        exposed = max(exposed + dt * (new_exposures - new_infections), 0.0)
        infected = max(infected + dt * (new_infections - new_recoveries), 0.0)
        recovered = min(recovered + dt * new_recoveries, population)

    return pd.DataFrame(rows)


def summarize_sir(outputs: pd.DataFrame) -> pd.DataFrame:
    """Summarize SIR simulation outputs by scenario."""
    rows = []

    for scenario, subset in outputs.groupby("scenario"):
        peak_row = subset.loc[subset["infected"].idxmax()]
        final_row = subset.sort_values("step").tail(1).iloc[0]

        rows.append(
            {
                "scenario": scenario,
                "peak_infected": peak_row["infected"],
                "time_of_peak": peak_row["time"],
                "final_susceptible": final_row["susceptible"],
                "final_infected": final_row["infected"],
                "final_recovered": final_row["recovered"],
            }
        )

    return pd.DataFrame(rows)


def summarize_seir(outputs: pd.DataFrame) -> pd.DataFrame:
    """Summarize SEIR simulation outputs by scenario."""
    rows = []

    for scenario, subset in outputs.groupby("scenario"):
        peak_row = subset.loc[subset["infected"].idxmax()]
        final_row = subset.sort_values("step").tail(1).iloc[0]

        rows.append(
            {
                "scenario": scenario,
                "peak_infected": peak_row["infected"],
                "time_of_peak": peak_row["time"],
                "final_susceptible": final_row["susceptible"],
                "final_exposed": final_row["exposed"],
                "final_infected": final_row["infected"],
                "final_recovered": final_row["recovered"],
            }
        )

    return pd.DataFrame(rows)


def rt_proxy(incidence: pd.DataFrame, generation_interval_days: float = 4.0) -> pd.DataFrame:
    """Create a simple teaching scaffold for short-window Rt-like growth summaries."""
    result = incidence.copy()
    result["growth_rate_proxy"] = (
        result["reported_cases"]
        .rolling(window=3)
        .apply(lambda x: (x.iloc[-1] - x.iloc[0]) / max(x.iloc[0], 1), raw=False)
    )
    result["rt_proxy"] = 1.0 + result["growth_rate_proxy"] * generation_interval_days
    return result


def reporting_delay_adjustment(incidence: pd.DataFrame) -> pd.DataFrame:
    """Adjust reported cases using an estimated reporting-completeness fraction."""
    result = incidence.copy()
    result["nowcast_cases"] = result["reported_cases"] / result["estimated_reporting_completeness"]
    return result


def simulate_branching_process(
    scenario: str,
    initial_cases: int,
    reproduction_mean: float,
    generations: int,
    random_seed: int,
) -> pd.DataFrame:
    """Simulate a simple stochastic branching process."""
    rng = random.Random(random_seed)
    current_cases = int(initial_cases)
    rows = []

    for generation in range(generations + 1):
        rows.append(
            {
                "scenario": scenario,
                "generation": generation,
                "cases": current_cases,
            }
        )

        next_cases = 0
        for _ in range(current_cases):
            secondary = max(0, round(rng.gauss(reproduction_mean, reproduction_mean ** 0.5)))
            next_cases += secondary

        current_cases = next_cases

    return pd.DataFrame(rows)


def validation_metrics(observed: pd.Series, predicted: pd.Series) -> pd.DataFrame:
    """Calculate compact forecast validation metrics."""
    errors = observed.astype(float) - predicted.astype(float)

    return pd.DataFrame(
        {
            "metric": ["MAE", "RMSE", "Bias"],
            "value": [
                errors.abs().mean(),
                math.sqrt((errors ** 2).mean()),
                errors.mean(),
            ],
        }
    )


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or a not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"
