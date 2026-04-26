# Methodology Notes

## Purpose

The computational examples support enzyme and pathway reasoning by translating Michaelis-Menten kinetics, inhibition models, catalytic efficiency, assay fitting, feedback inhibition, pathway bottlenecks, and condition scoring into transparent calculations.

## Core Methods

### Michaelis-Menten Kinetics

v = Vmax * S / (Km + S)

where v is reaction velocity, Vmax is maximal velocity, S is substrate concentration, and Km is the Michaelis constant.

### Catalytic Efficiency

efficiency = kcat / Km

where kcat is turnover number and Km is the Michaelis constant.

### Competitive Inhibition

v = Vmax * S / (Km * (1 + I / Ki) + S)

where I is inhibitor concentration and Ki is inhibition constant.

### Noncompetitive Inhibition

v = (Vmax / (1 + I / Ki)) * S / (Km + S)

where inhibitor reduces apparent catalytic capacity.

### Hill-Type Allosteric Response

v = Vmax * S^n / (K^n + S^n)

where n is the Hill coefficient.

### Feedback Inhibition

v_feedback = v_base / (1 + P / Kf)

where P is product concentration and Kf is feedback sensitivity.

### Simple Pathway Bottleneck

J = min(v1, v2, ..., vn)

where J is simplified pathway throughput and vi are step capacities.

## Interpretation

These workflows should be interpreted as educational computational enzyme-biology scaffolds, not calibrated clinical chemistry, pharmacology, enzyme engineering, metabolic engineering, or high-throughput screening models. Real applications require empirical data, quality control, experimental design, calibration, uncertainty analysis, and domain expertise.
