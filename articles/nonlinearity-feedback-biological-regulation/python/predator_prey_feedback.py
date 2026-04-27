"""
Predator-prey reciprocal feedback scaffold.

Run:
    python python/predator_prey_feedback.py
"""

import numpy as np
import pandas as pd


def simulate_predator_prey(prey0, predator0, alpha, beta, delta, gamma, dt=0.01, t_end=80):
    time = np.arange(0, t_end + dt, dt)
    prey = np.zeros_like(time)
    predator = np.zeros_like(time)

    prey[0] = prey0
    predator[0] = predator0

    for i in range(1, len(time)):
        dprey = alpha * prey[i - 1] - beta * prey[i - 1] * predator[i - 1]
        dpredator = delta * prey[i - 1] * predator[i - 1] - gamma * predator[i - 1]

        prey[i] = max(prey[i - 1] + dprey * dt, 0.0)
        predator[i] = max(predator[i - 1] + dpredator * dt, 0.0)

    return pd.DataFrame({"time": time, "prey": prey, "predator": predator})


def main() -> None:
    trajectory = simulate_predator_prey(
        prey0=40,
        predator0=9,
        alpha=0.60,
        beta=0.025,
        delta=0.018,
        gamma=0.35,
    )

    summary = pd.DataFrame(
        {
            "final_prey": [trajectory["prey"].iloc[-1]],
            "final_predator": [trajectory["predator"].iloc[-1]],
            "max_prey": [trajectory["prey"].max()],
            "max_predator": [trajectory["predator"].max()],
        }
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
