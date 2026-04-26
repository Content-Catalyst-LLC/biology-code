"""
Survival-curve workflow.

Run:
    python python/survival_curve.py
"""

from __future__ import annotations

import numpy as np
import pandas as pd

from definition_core import survival_probability, viability_decay


def main() -> None:
    """Generate survival and viability curve examples."""

    time_h = np.linspace(0, 96, 193)
    hazard_rate = 0.0289
    initial_viable_count = 1.0e6

    survival = survival_probability(time_h, hazard_rate)
    viable_count = viability_decay(time_h, initial_viable_count, hazard_rate)

    df = pd.DataFrame(
        {
            "time_h": time_h,
            "survival_probability": survival,
            "viable_count": viable_count,
        }
    )

    print(df.head(12).round(5).to_string(index=False))
    print(df.tail(12).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
