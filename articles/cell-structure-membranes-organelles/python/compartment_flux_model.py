"""
Compartment import-export-consumption simulation.

Run:
    python python/compartment_flux_model.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
SCENARIO_PATH = ARTICLE_DIR / "data" / "compartment_flux_scenarios.csv"


def simulate_compartment_flux(
    cytosol_initial: float,
    organelle_initial: float,
    k_import: float,
    k_export: float,
    organelle_consumption: float,
    time_end: float,
    dt: float,
) -> pd.DataFrame:
    """Simulate import, export, and consumption between cytosol and organelle."""

    if dt <= 0:
        raise ValueError("dt must be positive.")
    if time_end <= 0:
        raise ValueError("time_end must be positive.")

    time = np.arange(0, time_end + dt, dt)

    cytosol = np.zeros_like(time, dtype=float)
    organelle = np.zeros_like(time, dtype=float)

    cytosol[0] = cytosol_initial
    organelle[0] = organelle_initial

    for i in range(1, len(time)):
        import_flux = k_import * cytosol[i - 1]
        export_flux = k_export * organelle[i - 1]
        consumption = organelle_consumption * organelle[i - 1]

        d_cytosol = -import_flux + export_flux
        d_organelle = import_flux - export_flux - consumption

        cytosol[i] = max(cytosol[i - 1] + d_cytosol * dt, 0)
        organelle[i] = max(organelle[i - 1] + d_organelle * dt, 0)

    return pd.DataFrame(
        {
            "time": time,
            "cytosol_concentration": cytosol,
            "organelle_concentration": organelle,
        }
    )


def main() -> None:
    """Run all compartment flux scenarios."""

    scenarios = pd.read_csv(SCENARIO_PATH)

    summary_rows = []

    for _, row in scenarios.iterrows():
        sim = simulate_compartment_flux(
            row["cytosol_initial"],
            row["organelle_initial"],
            row["k_import"],
            row["k_export"],
            row["organelle_consumption"],
            row["time_end"],
            row["dt"],
        )

        summary_rows.append(
            {
                "scenario": row["scenario"],
                "final_cytosol": sim["cytosol_concentration"].iloc[-1],
                "final_organelle": sim["organelle_concentration"].iloc[-1],
                "peak_organelle": sim["organelle_concentration"].max(),
                "time_to_peak_organelle": sim.loc[
                    sim["organelle_concentration"].idxmax(),
                    "time",
                ],
            }
        )

    print(pd.DataFrame(summary_rows).round(4).to_string(index=False))


if __name__ == "__main__":
    main()
