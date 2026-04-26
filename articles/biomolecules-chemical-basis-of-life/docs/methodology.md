# Methodology Notes

## Purpose

The computational examples support biomolecular reasoning by translating biomolecular composition, kinetic rate laws, binding relationships, sequence composition, diffusion gradients, polymerization mass balance, and biomolecular condition scoring into transparent calculations.

## Core Methods

### Michaelis-Menten Kinetics

v = Vmax * S / (Km + S)

where v is reaction velocity, Vmax is maximum velocity, S is substrate concentration, and Km is the Michaelis constant.

### Ligand Binding

theta = L / (Kd + L)

where theta is fractional occupancy, L is ligand concentration, and Kd is dissociation constant.

### Diffusion

J = -D dC/dx

where J is flux, D is diffusion coefficient, and dC/dx is concentration gradient.

### GC Content

GC = (G + C) / (A + T + G + C)

### Amino-Acid Fraction

f_a = n_a / N

where n_a is the count of amino acid a and N is total sequence length.

### Composition Fractions

fraction_i = mass_i / total_mass

### Polymerization Mass Balance

polymer_mass = monomer_count * monomer_mass - water_loss

where water_loss is often approximated for condensation reactions when monomers are joined.

## Interpretation

These workflows should be interpreted as educational and methodological scaffolds, not calibrated clinical, pharmacological, structural-biology, molecular-docking, diagnostic, or regulatory models. Real applications require empirical data, uncertainty analysis, calibration, assay validation, quality control, and domain expertise.
