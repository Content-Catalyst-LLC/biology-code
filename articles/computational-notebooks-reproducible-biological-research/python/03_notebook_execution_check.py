"""
Inspect notebook scaffold and record execution-status metadata.

Run from article directory:
    python python/03_notebook_execution_check.py
"""

from pathlib import Path
import json

import pandas as pd


ARTICLE_DIR = Path(__file__).resolve().parents[1]
NOTEBOOK_PATH = ARTICLE_DIR / "notebooks" / "computational_notebooks_biological_research_workflow.ipynb"
EXECUTION_LOG_PATH = ARTICLE_DIR / "data" / "notebook_execution_log.csv"
OUTPUT_PATH = ARTICLE_DIR / "outputs" / "tables" / "notebook_execution_check.csv"


def main() -> None:
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    execution_log = pd.read_csv(EXECUTION_LOG_PATH)

    with NOTEBOOK_PATH.open("r", encoding="utf-8") as handle:
        notebook = json.load(handle)

    n_cells = len(notebook.get("cells", []))
    n_code_cells = sum(1 for cell in notebook.get("cells", []) if cell.get("cell_type") == "code")
    n_markdown_cells = sum(1 for cell in notebook.get("cells", []) if cell.get("cell_type") == "markdown")

    check = execution_log.copy()
    check["notebook_exists"] = NOTEBOOK_PATH.exists()
    check["n_cells"] = n_cells
    check["n_code_cells"] = n_code_cells
    check["n_markdown_cells"] = n_markdown_cells
    check["status"] = check.apply(
        lambda row: "pass" if bool(row["clean_run"]) and int(row["failed_cells"]) == 0 else "review",
        axis=1,
    )

    check.to_csv(OUTPUT_PATH, index=False)

    print(check.to_string(index=False))
    print(f"Saved: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
