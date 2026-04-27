"""
Sensitivity analysis for negative feedback return.

Run:
    python python/sensitivity_analysis.py
"""

import pandas as pd

from nonlinear_feedback_core import NegativeFeedbackParameters, normalized_sensitivity, simulate_negative_feedback


def main() -> None:
    base = NegativeFeedbackParameters(180, 100, 0.18, 0.05, 30)
    base_output = simulate_negative_feedback(base)["state"].iloc[-1]

    perturbed = NegativeFeedbackParameters(180, 100, 0.20, 0.05, 30)
    perturbed_output = simulate_negative_feedback(perturbed)["state"].iloc[-1]

    sensitivity = normalized_sensitivity(
        base_output=base_output,
        perturbed_output=perturbed_output,
        base_parameter=base.k,
        perturbed_parameter=perturbed.k,
    )

    result = pd.DataFrame(
        {
            "parameter": ["feedback_rate_k"],
            "base_k": [base.k],
            "perturbed_k": [perturbed.k],
            "base_output": [base_output],
            "perturbed_output": [perturbed_output],
            "normalized_sensitivity": [sensitivity],
        }
    )

    print(result.round(6).to_string(index=False))


if __name__ == "__main__":
    main()
