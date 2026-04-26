"""
Leaky neural integration with repeated inputs.

This script models a membrane-like state variable that moves toward rest,
receives repeated input pulses, and produces simplified threshold events.

Run:
    python python/leaky_integrator_response.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PARAMETERS_PATH = ARTICLE_DIR / "data" / "neural_parameters.csv"
PULSES_PATH = ARTICLE_DIR / "data" / "input_pulses.csv"


def load_parameters() -> dict[str, float]:
    """Load scalar parameters from CSV."""

    params = pd.read_csv(PARAMETERS_PATH)
    return dict(zip(params["parameter"], params["value"]))


def build_input_series(time: np.ndarray) -> np.ndarray:
    """Build input series from pulse table."""

    pulses = pd.read_csv(PULSES_PATH)
    inputs = np.zeros_like(time, dtype=float)

    for _, pulse in pulses.iterrows():
        mask = (time >= pulse["start_time"]) & (time < pulse["end_time"])
        inputs[mask] = pulse["input_amplitude"]

    return inputs


def simulate_leaky_integrator() -> pd.DataFrame:
    """Simulate leaky integration and threshold events."""

    params = load_parameters()

    dt = float(params["dt"])
    time_end = float(params["time_end"])
    tau = float(params["tau"])
    v_rest = float(params["v_rest"])
    resistance_scale = float(params["resistance_scale"])
    threshold = float(params["threshold"])

    time = np.arange(0, time_end + dt, dt)
    inputs = build_input_series(time)

    voltage = np.zeros_like(time, dtype=float)
    voltage[0] = v_rest

    for index in range(1, len(time)):
        d_voltage = (
            -(voltage[index - 1] - v_rest)
            + resistance_scale * inputs[index - 1]
        ) / tau

        voltage[index] = voltage[index - 1] + d_voltage * dt

    output = pd.DataFrame(
        {
            "time": time,
            "input": inputs,
            "voltage_state": voltage,
            "threshold_event": (voltage >= threshold).astype(int),
        }
    )

    return output


def main() -> None:
    """Run simulation and print diagnostics."""

    output = simulate_leaky_integrator()

    print(output.head(20).round(3).to_string(index=False))
    print("\nDiagnostics:")
    print(
        pd.Series(
            {
                "max_voltage": output["voltage_state"].max(),
                "event_count": output["threshold_event"].sum(),
                "final_voltage": output["voltage_state"].iloc[-1],
            }
        ).round(3)
    )


if __name__ == "__main__":
    main()
