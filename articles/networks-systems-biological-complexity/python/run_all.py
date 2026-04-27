"""
Run all Python network and biological-complexity workflows.

Run:
    python python/run_all.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    "network_complexity_core.py",
    "adjacency_matrix.py",
    "degree_centrality.py",
    "module_summary.py",
    "network_diffusion.py",
    "robustness_simulation.py",
    "gene_regulatory_network.py",
    "food_web_summary.py",
    "microbiome_association_scaffold.py",
]


def main() -> None:
    for script in SCRIPTS:
        print(f"\n=== Running {script} ===")
        subprocess.run([sys.executable, str(SCRIPT_DIR / script)], check=True)


if __name__ == "__main__":
    main()
