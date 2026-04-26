"""
Simplified host-pathogen coevolutionary dynamics.

Run:
    python python/host_pathogen_dynamics.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "host_pathogen_scenarios.csv"


def simulate_host_pathogen(
    steps: int = 60,
    host_defense: float = 0.4,
    pathogen_escape: float = 0.5,
    feedback: float = 0.03,
) -> pd.DataFrame:
    """Simulate simplified reciprocal adjustment between host defense and pathogen escape."""

    records = []
    host = host_defense
    pathogen = pathogen_escape

    for time in range(steps + 1):
        infection_pressure = max(pathogen - host, 0)

        records.append(
            {
                "time": time,
                "host_defense": host,
                "pathogen_escape": pathogen,
                "infection_pressure": infection_pressure,
            }
        )

        host = min(max(host + feedback * infection_pressure, 0), 1)
        pathogen = min(max(pathogen + feedback * max(host - pathogen, 0), 0), 1)

    return pd.DataFrame(records)


def main() -> None:
    """Run host-pathogen scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        result = simulate_host_pathogen(
            steps=int(row["steps"]),
            host_defense=row["host_defense"],
            pathogen_escape=row["pathogen_escape"],
            feedback=row["feedback"],
        )
        result["scenario"] = row["scenario"]
        runs.append(result)

    output = pd.concat(runs, ignore_index=True)

    summary = (
        output.groupby("scenario")
        .agg(
            final_host_defense=("host_defense", "last"),
            final_pathogen_escape=("pathogen_escape", "last"),
            final_infection_pressure=("infection_pressure", "last"),
            mean_infection_pressure=("infection_pressure", "mean"),
        )
        .reset_index()
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
