"""
Michaelis-Menten enzyme kinetics workflow.

Run:
    python python/enzyme_kinetics.py
"""

from pathlib import Path

import pandas as pd

from math_biology_core import michaelis_menten


ARTICLE_DIR = Path(__file__).resolve().parents[1]
ENZYME_PATH = ARTICLE_DIR / "data" / "enzyme_kinetics.csv"


def main() -> None:
    data = pd.read_csv(ENZYME_PATH)

    data["velocity"] = michaelis_menten(
        substrate=data["substrate"].to_numpy(dtype=float),
        vmax=float(data["Vmax"].iloc[0]),
        km=float(data["Km"].iloc[0]),
    )

    rows = []

    for scenario, group in data.groupby("scenario"):
        velocity = michaelis_menten(
            substrate=group["substrate"].to_numpy(dtype=float),
            vmax=float(group["Vmax"].iloc[0]),
            km=float(group["Km"].iloc[0]),
        )

        rows.append(
            pd.DataFrame(
                {
                    "scenario": scenario,
                    "substrate": group["substrate"].to_numpy(dtype=float),
                    "velocity": velocity,
                }
            )
        )

    result = pd.concat(rows, ignore_index=True)

    print(result.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
