"""
Comparative immune scenarios and threshold screening.

This script simulates coupled pathogen, immune, and damage dynamics across
several scenarios and classifies outcomes using illustrative thresholds.

Run:
    python python/immune_scenario_screening.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "immune_scenarios.csv"
THRESHOLDS_PATH = ARTICLE_DIR / "data" / "immune_thresholds.csv"


def simulate_scenario(
    P0: float = 50,
    I0: float = 2,
    D0: float = 0,
    r: float = 0.45,
    c: float = 0.12,
    alpha: float = 0.08,
    delta: float = 0.18,
    gamma: float = 0.06,
    rho: float = 0.10,
    T: float = 30,
    dt: float = 0.05,
) -> dict[str, float]:
    """Simulate coupled pathogen, immune, and damage dynamics."""

    time = np.arange(0, T + dt, dt)
    pathogen = np.zeros(len(time))
    immune = np.zeros(len(time))
    damage = np.zeros(len(time))

    pathogen[0], immune[0], damage[0] = P0, I0, D0

    for index in range(1, len(time)):
        d_pathogen = r * pathogen[index - 1] - c * immune[index - 1] * pathogen[index - 1]
        d_immune = alpha * pathogen[index - 1] - delta * immune[index - 1]
        d_damage = gamma * immune[index - 1] - rho * damage[index - 1]

        pathogen[index] = max(0.0, pathogen[index - 1] + d_pathogen * dt)
        immune[index] = max(0.0, immune[index - 1] + d_immune * dt)
        damage[index] = max(0.0, damage[index - 1] + d_damage * dt)

    return {
        "final_pathogen": float(pathogen[-1]),
        "final_immune": float(immune[-1]),
        "final_damage": float(damage[-1]),
        "peak_pathogen": float(pathogen.max()),
        "peak_immune": float(immune.max()),
        "peak_damage": float(damage.max()),
    }


def classify_risk(row: pd.Series, thresholds: dict[str, float]) -> str:
    """Classify scenario risk from peak pathogen and damage thresholds."""

    if (
        row["peak_pathogen"] > thresholds["peak_pathogen_high"]
        or row["peak_damage"] > thresholds["peak_damage_high"]
    ):
        return "high-risk"

    if (
        row["peak_pathogen"] > thresholds["peak_pathogen_stressed"]
        or row["peak_damage"] > thresholds["peak_damage_stressed"]
    ):
        return "stressed"

    return "controlled"


def main() -> None:
    """Run comparative immune scenario screening."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    threshold_df = pd.read_csv(THRESHOLDS_PATH)
    thresholds = dict(zip(threshold_df["threshold_name"], threshold_df["value"]))

    rows = []

    for _, scenario in scenarios.iterrows():
        result = simulate_scenario(
            P0=scenario["P0"],
            I0=scenario["I0"],
            D0=scenario["D0"],
            r=scenario["r"],
            c=scenario["c"],
            alpha=scenario["alpha"],
            delta=scenario["delta"],
            gamma=scenario["gamma"],
            rho=scenario["rho"],
        )

        result["scenario"] = scenario["scenario"]
        rows.append(result)

    output = pd.DataFrame(rows)
    output["risk_class"] = output.apply(
        lambda row: classify_risk(row, thresholds),
        axis=1,
    )

    print(output.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
