"""
Estimate simplified containment-layer failure probability.

Run from article directory:
    python python/02_containment_probability.py
"""

from pathlib import Path
import pandas as pd

from biotechnology_intervention_core import containment_failure_probability


ARTICLE_DIR = Path(__file__).resolve().parents[1]
INPUT_PATH = ARTICLE_DIR / "data" / "containment_layers.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "containment_probability.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    layers = pd.read_csv(INPUT_PATH)
    probability_any_failure = containment_failure_probability(layers)

    output = pd.DataFrame(
        {
            "metric": [
                "n_layers",
                "estimated_probability_any_layer_failure",
                "interpretation_warning",
            ],
            "value": [
                str(len(layers)),
                f"{probability_any_failure:.6f}",
                "Conceptual educational estimate; not a facility-specific biosafety model.",
            ],
        }
    )

    output.to_csv(OUTPUT_PATH, index=False)

    print(layers.to_string(index=False))
    print(output.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
