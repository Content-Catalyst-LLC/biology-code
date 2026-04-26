"""
Small recurrent neural network response and threshold activation.

This script simulates a three-unit recurrent network with nonlinear activation,
time-varying inputs, and simplified threshold events.

Run:
    python python/recurrent_network_response.py
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
WEIGHTS_PATH = ARTICLE_DIR / "data" / "network_weights.csv"
INPUTS_PATH = ARTICLE_DIR / "data" / "network_inputs.csv"


def sigmoid(values: np.ndarray) -> np.ndarray:
    """Nonlinear activation function."""

    return 1 / (1 + np.exp(-values))


def load_weights() -> tuple[list[str], np.ndarray]:
    """Load recurrent weight matrix."""

    weights_df = pd.read_csv(WEIGHTS_PATH)
    units = weights_df["unit"].tolist()
    weights = weights_df.drop(columns=["unit"]).to_numpy(dtype=float)
    return units, weights


def main() -> None:
    """Run recurrent network simulation."""

    units, weights = load_weights()
    inputs_df = pd.read_csv(INPUTS_PATH)
    inputs = inputs_df[units].to_numpy(dtype=float)

    time_steps = len(inputs_df)
    activity = np.zeros((time_steps, len(units)))

    for index in range(1, time_steps):
        recurrent_drive = weights @ activity[index - 1]
        activity[index] = (
            0.85 * activity[index - 1]
            + sigmoid(recurrent_drive + inputs[index - 1])
        )

    activity_df = pd.DataFrame(activity, columns=units)
    activity_df.insert(0, "time", inputs_df["time"])

    threshold = 1.2
    events = (activity_df[units] > threshold).astype(int)

    print("Network activity:")
    print(activity_df.round(3).to_string(index=False))

    print("\nThreshold events:")
    print(events.to_string(index=False))

    print("\nEvent summary:")
    print(events.sum().rename("event_count").to_string())


if __name__ == "__main__":
    main()
