"""
Simulate directed weighted signal propagation.

Run from article directory:
    python python/02_signal_propagation.py
"""

from pathlib import Path

import pandas as pd

from systems_biology_core import simulate_signal_propagation


ARTICLE_DIR = Path(__file__).resolve().parents[1]
EDGES_PATH = ARTICLE_DIR / "data" / "interactions.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "simulations" / "signal_propagation.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    edges = pd.read_csv(EDGES_PATH)
    signal_edges = edges[edges["source"].isin(["TP53", "MYC", "AKT1", "MAPK1"]) | edges["target"].isin(["TP53", "MYC", "AKT1", "MAPK1"])].copy()

    result = simulate_signal_propagation(
        edges=signal_edges,
        input_node="TP53",
        alpha=0.75,
        steps=8,
    )

    result.to_csv(OUTPUT_PATH, index=False)

    print(result.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
