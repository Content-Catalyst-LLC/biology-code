"""
Reciprocal host-symbiont trait-frequency feedback.

Run:
    python python/reciprocal_feedback.py
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "reciprocal_frequency_scenarios.csv"


def simulate_reciprocal_feedback(
    host_initial: float,
    symbiont_initial: float,
    host_feedback: float,
    symbiont_feedback: float,
    steps: int,
) -> pd.DataFrame:
    """Simulate reciprocal convergence or lag between host and symbiont matching traits."""

    host = host_initial
    symbiont = symbiont_initial
    records = []

    for time in range(steps + 1):
        records.append(
            {
                "time": time,
                "host_match": host,
                "symbiont_match": symbiont,
                "mismatch": abs(host - symbiont),
            }
        )

        next_host = min(max(host + host_feedback * (symbiont - host), 0), 1)
        next_symbiont = min(max(symbiont + symbiont_feedback * (host - symbiont), 0), 1)

        host = next_host
        symbiont = next_symbiont

    return pd.DataFrame(records)


def main() -> None:
    """Run reciprocal frequency scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    runs = []

    for _, row in scenarios.iterrows():
        result = simulate_reciprocal_feedback(
            host_initial=row["host_initial"],
            symbiont_initial=row["symbiont_initial"],
            host_feedback=row["host_feedback"],
            symbiont_feedback=row["symbiont_feedback"],
            steps=int(row["steps"]),
        )
        result["scenario"] = row["scenario"]
        runs.append(result)

    output = pd.concat(runs, ignore_index=True)

    summary = (
        output.groupby("scenario")
        .agg(
            final_host_match=("host_match", "last"),
            final_symbiont_match=("symbiont_match", "last"),
            final_mismatch=("mismatch", "last"),
            mean_mismatch=("mismatch", "mean"),
        )
        .reset_index()
    )

    print(summary.round(4).to_string(index=False))


if __name__ == "__main__":
    main()
