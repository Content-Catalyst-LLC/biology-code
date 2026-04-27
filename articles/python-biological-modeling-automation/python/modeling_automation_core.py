"""
Core utilities for Python-based biological modeling and automation.
"""

from __future__ import annotations

from pathlib import Path
import hashlib

import pandas as pd


def simulate_logistic_growth(
    scenario: str,
    initial_population: float,
    growth_rate: float,
    carrying_capacity: float,
    dt: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate deterministic logistic growth using Euler approximation."""
    if initial_population < 0:
        raise ValueError("initial_population must be non-negative.")
    if carrying_capacity <= 0:
        raise ValueError("carrying_capacity must be positive.")
    if dt <= 0:
        raise ValueError("dt must be positive.")
    if steps < 1:
        raise ValueError("steps must be positive.")

    population = float(initial_population)
    rows = []

    for step in range(steps + 1):
        rows.append(
            {
                "model": "logistic_growth",
                "scenario": scenario,
                "step": step,
                "time": step * dt,
                "population": population,
            }
        )

        growth = growth_rate * population * (1.0 - population / carrying_capacity)
        population = max(population + dt * growth, 0.0)

    return pd.DataFrame(rows)


def simulate_two_compartment_model(
    scenario: str,
    initial_a: float,
    initial_b: float,
    k_ab: float,
    k_ba: float,
    k_clear: float,
    dt: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate exchange between two biological compartments."""
    if initial_a < 0 or initial_b < 0:
        raise ValueError("Initial compartment amounts must be non-negative.")
    if min(k_ab, k_ba, k_clear) < 0:
        raise ValueError("Rate constants must be non-negative.")
    if dt <= 0:
        raise ValueError("dt must be positive.")
    if steps < 1:
        raise ValueError("steps must be positive.")

    amount_a = float(initial_a)
    amount_b = float(initial_b)
    rows = []

    for step in range(steps + 1):
        rows.append(
            {
                "model": "two_compartment",
                "scenario": scenario,
                "step": step,
                "time": step * dt,
                "compartment_a": amount_a,
                "compartment_b": amount_b,
                "total_amount": amount_a + amount_b,
            }
        )

        flow_ab = k_ab * amount_a
        flow_ba = k_ba * amount_b
        clearance = k_clear * amount_a

        amount_a = max(amount_a + dt * (-flow_ab + flow_ba - clearance), 0.0)
        amount_b = max(amount_b + dt * (flow_ab - flow_ba), 0.0)

    return pd.DataFrame(rows)


def validate_parameter_table(
    table: pd.DataFrame,
    rules: pd.DataFrame,
    table_name: str,
) -> pd.DataFrame:
    """Validate parameter values using a parameter-rules table."""
    rows = []
    rule_lookup = rules.set_index("parameter").to_dict(orient="index")

    for parameter in table.columns:
        if parameter not in rule_lookup:
            continue

        lower = float(rule_lookup[parameter]["lower_bound"])
        upper = float(rule_lookup[parameter]["upper_bound"])

        for row_index, value in table[parameter].items():
            try:
                numeric_value = float(value)
                passed = lower <= numeric_value <= upper
            except (TypeError, ValueError):
                numeric_value = None
                passed = False

            rows.append(
                {
                    "table_name": table_name,
                    "row_index": int(row_index),
                    "parameter": parameter,
                    "value": value,
                    "lower_bound": lower,
                    "upper_bound": upper,
                    "passed": passed,
                    "message": "within expected range" if passed else "outside expected range or nonnumeric",
                }
            )

    return pd.DataFrame(rows)


def summarize_logistic_outputs(outputs: pd.DataFrame) -> pd.DataFrame:
    """Summarize final state for each logistic-growth scenario."""
    return (
        outputs.sort_values(["scenario", "step"])
        .groupby("scenario")
        .tail(1)
        .loc[:, ["model", "scenario", "time", "population"]]
        .rename(columns={"population": "final_population"})
        .reset_index(drop=True)
    )


def summarize_compartment_outputs(outputs: pd.DataFrame) -> pd.DataFrame:
    """Summarize final state for each two-compartment scenario."""
    return (
        outputs.sort_values(["scenario", "step"])
        .groupby("scenario")
        .tail(1)
        .loc[:, ["model", "scenario", "time", "compartment_a", "compartment_b", "total_amount"]]
        .rename(
            columns={
                "compartment_a": "final_compartment_a",
                "compartment_b": "final_compartment_b",
                "total_amount": "final_total_amount",
            }
        )
        .reset_index(drop=True)
    )


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a file checksum or a not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"
