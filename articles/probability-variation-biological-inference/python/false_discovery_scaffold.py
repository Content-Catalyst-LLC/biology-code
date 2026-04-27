"""
False discovery scaffold using Benjamini-Hochberg adjustment.

Run:
    python python/false_discovery_scaffold.py
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PVAL_PATH = ARTICLE_DIR / "data" / "multiple_testing.csv"


def benjamini_hochberg(p_values: np.ndarray) -> np.ndarray:
    """Return Benjamini-Hochberg adjusted q-values."""

    n = len(p_values)
    order = np.argsort(p_values)
    ranked = p_values[order]

    adjusted = ranked * n / np.arange(1, n + 1)
    adjusted = np.minimum.accumulate(adjusted[::-1])[::-1]
    adjusted = np.minimum(adjusted, 1.0)

    q_values = np.empty(n)
    q_values[order] = adjusted

    return q_values


def main() -> None:
    data = pd.read_csv(PVAL_PATH)
    data["q_value_bh"] = benjamini_hochberg(data["p_value"].to_numpy(dtype=float))
    data["discovery_at_0_05"] = data["q_value_bh"] <= 0.05

    print(data.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
