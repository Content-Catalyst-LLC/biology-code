"""
Sensitivity analysis for logistic growth.

Run:
    python python/sensitivity_analysis.py
"""

import pandas as pd

from differential_equations_core import LogisticParameters, simulate_logistic


def normalized_sensitivity(base_output, perturbed_output, base_parameter, perturbed_parameter):
    if base_output == 0 or base_parameter == 0 or perturbed_parameter == base_parameter:
        return float("nan")
    return (base_parameter / base_output) * ((perturbed_output - base_output) / (perturbed_parameter - base_parameter))


def main() -> None:
    base = LogisticParameters(100, 0.30, 2000, 0.05, 40)
    base_output = simulate_logistic(base)["population"].iloc[-1]

    scenarios = [
        ("r", base.r, base.r + 0.02, LogisticParameters(base.N0, base.r + 0.02, base.K, base.dt, base.t_end)),
        ("K", base.K, base.K + 100, LogisticParameters(base.N0, base.r, base.K + 100, base.dt, base.t_end)),
        ("N0", base.N0, base.N0 + 10, LogisticParameters(base.N0 + 10, base.r, base.K, base.dt, base.t_end)),
    ]

    rows = []

    for name, base_value, perturbed_value, params in scenarios:
        perturbed_output = simulate_logistic(params)["population"].iloc[-1]

        rows.append(
            {
                "parameter": name,
                "base_value": base_value,
                "perturbed_value": perturbed_value,
                "base_output": base_output,
                "perturbed_output": perturbed_output,
                "normalized_sensitivity": normalized_sensitivity(base_output, perturbed_output, base_value, perturbed_value),
            }
        )

    print(pd.DataFrame(rows).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
