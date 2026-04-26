"""
Two-state regulatory switching coupled to expression output.

Run:
    python python/regulatory_switching.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIOS_PATH = ARTICLE_DIR / "data" / "regulatory_scenarios.csv"


def simulate_regulatory_expression(
    t_end: float,
    dt: float,
    kon: float,
    koff: float,
    alpha_on: float,
    alpha_off: float,
    beta: float,
    p_on0: float,
    m0: float,
) -> pd.DataFrame:
    """Simulate regulatory activation probability and expression output."""

    times = np.arange(0, t_end + dt, dt)
    p_on = np.zeros_like(times)
    expression = np.zeros_like(times)

    p_on[0] = p_on0
    expression[0] = m0

    for i in range(1, len(times)):
        dp = kon * (1 - p_on[i - 1]) - koff * p_on[i - 1]
        p_on[i] = np.clip(p_on[i - 1] + dp * dt, 0, 1)

        alpha_t = alpha_on * p_on[i] + alpha_off * (1 - p_on[i])
        d_expression = alpha_t - beta * expression[i - 1]
        expression[i] = max(expression[i - 1] + d_expression * dt, 0)

    return pd.DataFrame(
        {
            "time": times,
            "p_on": p_on,
            "expression": expression,
        }
    )


def main() -> None:
    """Run regulatory switching scenarios."""

    scenarios = pd.read_csv(SCENARIOS_PATH)
    summaries = []

    for _, row in scenarios.iterrows():
        result = simulate_regulatory_expression(
            t_end=row["t_end"],
            dt=row["dt"],
            kon=row["kon"],
            koff=row["koff"],
            alpha_on=row["alpha_on"],
            alpha_off=row["alpha_off"],
            beta=row["beta"],
            p_on0=row["p_on0"],
            m0=row["m0"],
        )

        summaries.append(
            {
                "scenario": row["scenario"],
                "final_p_on": result["p_on"].iloc[-1],
                "final_expression": result["expression"].iloc[-1],
                "mean_expression": result["expression"].mean(),
                "max_expression": result["expression"].max(),
            }
        )

    print(pd.DataFrame(summaries).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
