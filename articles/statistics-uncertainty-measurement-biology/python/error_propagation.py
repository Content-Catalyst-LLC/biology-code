"""
Error propagation workflow.

Run:
    python python/error_propagation.py
"""

import pandas as pd

from statistics_measurement_core import propagated_uncertainty_product


def main() -> None:
    length_mm = 12.0
    width_mm = 5.0
    u_length_mm = 0.2
    u_width_mm = 0.1

    area_mm2 = length_mm * width_mm
    u_area_mm2 = propagated_uncertainty_product(length_mm, width_mm, u_length_mm, u_width_mm)

    summary = pd.DataFrame(
        {
            "length_mm": [length_mm],
            "width_mm": [width_mm],
            "area_mm2": [area_mm2],
            "u_length_mm": [u_length_mm],
            "u_width_mm": [u_width_mm],
            "u_area_mm2": [u_area_mm2],
        }
    )

    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
