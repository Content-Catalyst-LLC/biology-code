"""
Integrate network topology with omics measurements and pathway membership.

Run from article directory:
    python python/06_omics_integration.py
"""

from pathlib import Path
import subprocess
import sys

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
NETWORK_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "network_summary.csv"
EXPRESSION_PATH = ARTICLE_DIR / "data" / "expression.csv"
GENESETS_PATH = ARTICLE_DIR / "data" / "pathway_gene_sets.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "omics_network_integration.csv"


def ensure_network_summary() -> None:
    if not NETWORK_SUMMARY.exists():
        subprocess.run([sys.executable, str(ARTICLE_DIR / "python" / "01_network_summary.py")], check=True)


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    ensure_network_summary()

    network = pd.read_csv(NETWORK_SUMMARY)
    expression = pd.read_csv(EXPRESSION_PATH)
    gene_sets = pd.read_csv(GENESETS_PATH)

    gene_pathways = (
        gene_sets.groupby("gene")
        .agg(pathway_memberships=("pathway", lambda values: ";".join(sorted(set(values)))))
        .reset_index()
        .rename(columns={"gene": "node_id"})
    )

    integration = (
        network.merge(expression.rename(columns={"gene": "node_id"}), on="node_id", how="left")
        .merge(gene_pathways, on="node_id", how="left")
    )

    integration["z_score"] = integration["z_score"].fillna(0.0)
    integration["measurement_type"] = integration["measurement_type"].fillna("not_measured")
    integration["pathway_memberships"] = integration["pathway_memberships"].fillna("not_in_gene_set")
    integration["network_weighted_response"] = integration["degree"] * integration["z_score"]

    integration.to_csv(OUTPUT_PATH, index=False)

    print(integration.round(5).to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
