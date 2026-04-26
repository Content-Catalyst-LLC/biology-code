"""
Parameter sensitivity workflow for logistic growth.

Run:
    python python/sensitivity_analysis.py
"""

import numpy as np
import pandas as pd

from math_biology_core import LogisticParameters, local_sensitivity, logistic_growth


def main() -> None:
    time = np.array([40.0])

    base = LogisticParameters(initial_population=100, growth_rate=0.30, carrying_capacity=2000)
    base_output = float(logistic_growth(time, base)[0])

    rows = []

    for parameter_name, base_value, perturbation in [
        ("growth_rate", base.growth_rate, 0.01),
        ("carrying_capacity", base.carrying_capacity, 50.0),
        ("initial_population", base.initial_population, 5.0),
    ]:
        kwargs = {
            "initial_population": base.initial_population,
            "growth_rate": base.growth_rate,
            "carrying_capacity": base.carrying_capacity,
        }
        kwargs[parameter_name] = base_value + perturbation

        perturbed = LogisticParameters(**kwargs)
        perturbed_output = float(logistic_growth(time, perturbed)[0])

        rows.append(
            {
                "parameter": parameter_name,
                "base_value": base_value,
                "perturbed_value": base_value + perturbation,
                "base_output": base_output,
                "perturbed_output": perturbed_output,
                "normalized_local_sensitivity": local_sensitivity(
                    base_output,
                    perturbed_output,
                    base_value,
                    base_value + perturbation,
                ),
            }
        )

    print(pd.DataFrame(rows).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
