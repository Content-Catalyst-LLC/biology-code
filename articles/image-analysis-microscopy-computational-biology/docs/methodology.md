# Methodology Notes

## Purpose

This repository demonstrates a reproducible educational workflow for microscopy image analysis and computational biology.

## Synthetic Image Generation

Synthetic microscopy images are generated from Gaussian objects on a 2D grid. This is a transparent teaching scaffold for segmentation, feature extraction, and validation.

## Segmentation

Threshold segmentation creates a binary mask:

mask = intensity >= threshold

This is intentionally simple and should not be interpreted as a universal segmentation method.

## Feature Extraction

The workflow summarizes:

- foreground area
- object area
- mean intensity
- integrated intensity
- centroid coordinates
- bounding boxes

## Segmentation Validation

The workflow calculates:

- Dice coefficient
- Intersection over Union
- true positives
- false positives
- false negatives

## Colocalization

The workflow calculates Pearson correlation and threshold-overlap scaffolds between two synthetic channels.

## Tracking

The workflow calculates:

- track length
- total path distance
- net displacement
- mean step distance

## Reproducibility

The repository records:

- input data files
- scripts
- output artifacts
- checksums
- workflow steps
- SQL provenance
- validation reports
