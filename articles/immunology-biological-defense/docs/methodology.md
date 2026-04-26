# Methodology Notes

## Purpose

The computational examples support immunology reasoning by translating pathogen growth, immune activation, clearance, inflammatory damage, repair, and immune-condition scoring into transparent calculations.

## Core Methods

### Pathogen Load Under Immune Control

A compact pathogen model is:

dP/dt = rP - cIP

where P is pathogen load, r is pathogen growth, I is immune activity, and c is the clearance coefficient.

### Inflammatory Regulation

A compact inflammation model is:

dX/dt = aS - bX

where X is inflammatory activity, S is stimulus intensity, a is activation strength, and b is damping or resolution.

### Coupled Host-Pathogen-Immune System

The main coupled scaffold is:

dP/dt = rP - cIP

dI/dt = alpha P - delta I

dD/dt = gamma I - rho D

where P is pathogen load, I is immune effector activity, D is tissue damage or inflammatory burden, and parameters describe growth, clearance, activation, decay, collateral damage, and repair.

### Threshold Screening

The Python and C++ examples classify scenarios using peak pathogen and peak damage thresholds. These thresholds are illustrative and should not be interpreted as clinical cutoffs.

## Interpretation

These workflows should be interpreted as educational computational immunology scaffolds, not clinical models. Real applications require validated biological data, host-specific parameters, tissue context, uncertainty analysis, and expert interpretation.
