"""
Restoration Scenario Screening

This script compares restoration scenarios using a coupled recovery model:

    dV/dt = aS - bV - cD
    dM/dt = pV + qB - rM
    dF/dt = uV + vM - wD
"""

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]


def load_parameters() -> dict[str, float]:
    """Load model parameters from CSV."""
    params = pd.read_csv(ARTICLE_DIR / "data" / "restoration_parameters.csv")
    return dict(zip(params["parameter"], params["value"]))


def simulate_restoration(
    scenario: pd.Series,
    parameters: dict[str, float],
    initial_v: float = 10.0,
    initial_m: float = 8.0,
    initial_f: float = 6.0,
) -> pd.DataFrame:
    """Simulate one restoration scenario."""
    dt = float(parameters["dt"])
    t_end = float(parameters["T"])
    time = np.arange(0.0, t_end + dt, dt)

    v_state = np.zeros(len(time))
    m_state = np.zeros(len(time))
    f_state = np.zeros(len(time))

    v_state[0] = initial_v
    m_state[0] = initial_m
    f_state[0] = initial_f

    s_effort = float(scenario["S"])
    b_support = float(scenario["B"])
    disturbance = float(scenario["D"])

    for i in range(1, len(time)):
        d_v = (
            parameters["a"] * s_effort
            - parameters["b"] * v_state[i - 1]
            - parameters["c"] * disturbance
        )

        d_m = (
            parameters["p"] * v_state[i - 1]
            + parameters["q"] * b_support
            - parameters["r"] * m_state[i - 1]
        )

        d_f = (
            parameters["u"] * v_state[i - 1]
            + parameters["v"] * m_state[i - 1]
            - parameters["w"] * disturbance
        )

        v_state[i] = max(0.0, v_state[i - 1] + d_v * dt)
        m_state[i] = max(0.0, m_state[i - 1] + d_m * dt)
        f_state[i] = max(0.0, f_state[i - 1] + d_f * dt)

    return pd.DataFrame(
        {
            "scenario": scenario["scenario"],
            "time": time,
            "vegetation_structure": v_state,
            "soil_microbial_recovery": m_state,
            "functional_integrity": f_state,
            "restoration_effort": s_effort,
            "belowground_support": b_support,
            "disturbance_pressure": disturbance,
            "description": scenario["description"],
        }
    )


def classify_recovery(final_f: float) -> str:
    """Classify restoration outcome from final functional integrity."""
    if final_f >= 12.0:
        return "strong-recovery"
    if final_f >= 8.0:
        return "partial-recovery"
    return "stalled"


def main() -> None:
    """Run all restoration scenarios."""
    parameters = load_parameters()
    scenarios = pd.read_csv(ARTICLE_DIR / "data" / "restoration_scenarios.csv")

    trajectories = [
        simulate_restoration(scenario, parameters)
        for _, scenario in scenarios.iterrows()
    ]

    trajectory_table = pd.concat(trajectories, ignore_index=True)

    summary = (
        trajectory_table.groupby("scenario", as_index=False)
        .agg(
            final_V=("vegetation_structure", "last"),
            final_M=("soil_microbial_recovery", "last"),
            final_F=("functional_integrity", "last"),
            peak_F=("functional_integrity", "max"),
            restoration_effort=("restoration_effort", "first"),
            belowground_support=("belowground_support", "first"),
            disturbance_pressure=("disturbance_pressure", "first"),
            description=("description", "first"),
        )
    )

    summary["restoration_class"] = summary["final_F"].apply(classify_recovery)

    trajectory_table.to_csv(
        ARTICLE_DIR / "data" / "computed_restoration_trajectories_python.csv",
        index=False,
    )

    summary.to_csv(
        ARTICLE_DIR / "data" / "computed_restoration_scenario_summary_python.csv",
        index=False,
    )

    print("Restoration scenario summary:")
    print(summary.round(3).to_string(index=False))


if __name__ == "__main__":
    main()
