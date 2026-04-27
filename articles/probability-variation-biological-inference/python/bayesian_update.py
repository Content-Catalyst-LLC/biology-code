"""
Beta-binomial Bayesian updating workflow.

Run:
    python python/bayesian_update.py
"""

from pathlib import Path

import pandas as pd

from probability_core import beta_binomial_update


ARTICLE_DIR = Path(__file__).resolve().parents[1]
PRIOR_PATH = ARTICLE_DIR / "data" / "bayesian_priors.csv"


def main() -> None:
    priors = pd.read_csv(PRIOR_PATH)

    rows = []

    for _, row in priors.iterrows():
        posterior = beta_binomial_update(
            float(row["alpha_prior"]),
            float(row["beta_prior"]),
            int(row["successes"]),
            int(row["trials"]),
        )

        rows.append(
            {
                "scenario": row["scenario"],
                "alpha_prior": row["alpha_prior"],
                "beta_prior": row["beta_prior"],
                "successes": row["successes"],
                "trials": row["trials"],
                "alpha_posterior": posterior.alpha_posterior,
                "beta_posterior": posterior.beta_posterior,
                "posterior_mean": posterior.posterior_mean,
                "posterior_sd": posterior.posterior_variance ** 0.5,
            }
        )

    print(pd.DataFrame(rows).round(5).to_string(index=False))


if __name__ == "__main__":
    main()
