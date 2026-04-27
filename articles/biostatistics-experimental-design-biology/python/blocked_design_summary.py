"""
Blocked design summary workflow.

Run:
    python python/blocked_design_summary.py
"""

from pathlib import Path

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "blocked_design.csv"


def main() -> None:
    data = pd.read_csv(DATA_PATH)

    wide = data.pivot(index="block", columns="treatment", values="response")
    wide["within_block_difference"] = wide["treated"] - wide["control"]

    summary = pd.DataFrame(
        {
            "mean_within_block_difference": [wide["within_block_difference"].mean()],
            "sd_within_block_difference": [wide["within_block_difference"].std(ddof=1)],
            "n_blocks": [wide.shape[0]],
            "se_difference": [wide["within_block_difference"].std(ddof=1) / (wide.shape[0] ** 0.5)],
        }
    )

    print(wide.round(5).to_string())
    print(summary.round(5).to_string(index=False))


if __name__ == "__main__":
    main()
