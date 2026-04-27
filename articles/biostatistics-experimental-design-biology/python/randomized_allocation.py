"""
Randomized allocation workflow.

Run:
    python python/randomized_allocation.py
"""

import pandas as pd

from experimental_design_core import randomized_block_allocation


def main() -> None:
    blocks = [f"batch_{i:02d}" for i in range(1, 7)]
    treatments = ["control", "low_dose", "high_dose"]

    allocation = randomized_block_allocation(
        blocks=blocks,
        treatments=treatments,
        replicates_per_treatment=3,
        seed=42,
    )

    print(pd.DataFrame(allocation).to_string(index=False))


if __name__ == "__main__":
    main()
