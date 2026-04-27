"""
Core utilities for microscopy image analysis and computational biology workflows.
"""

from __future__ import annotations

from pathlib import Path
import hashlib
import math

import pandas as pd


def gaussian_intensity(x: float, y: float, cx: float, cy: float, sigma: float, amplitude: float) -> float:
    """Return intensity from a 2D Gaussian object."""
    distance_squared = (x - cx) ** 2 + (y - cy) ** 2
    return amplitude * math.exp(-distance_squared / (2.0 * sigma ** 2))


def generate_synthetic_image(objects: pd.DataFrame, width: int, height: int, channel: str, background: float = 18.0) -> pd.DataFrame:
    """Generate a synthetic microscopy image as a tidy pixel table."""
    channel_objects = objects[objects["channel"] == channel]
    rows = []

    for y in range(height):
        for x in range(width):
            intensity = float(background)

            for _, obj in channel_objects.iterrows():
                intensity += gaussian_intensity(
                    x=x,
                    y=y,
                    cx=float(obj["cx"]),
                    cy=float(obj["cy"]),
                    sigma=float(obj["sigma"]),
                    amplitude=float(obj["amplitude"]),
                )

            rows.append(
                {
                    "image_id": "synthetic_image_001",
                    "channel": channel,
                    "x": x,
                    "y": y,
                    "intensity": intensity,
                }
            )

    return pd.DataFrame(rows)


def threshold_segmentation(image: pd.DataFrame, threshold: float) -> pd.DataFrame:
    """Apply threshold segmentation to a tidy pixel table."""
    result = image.copy()
    result["threshold"] = threshold
    result["mask"] = result["intensity"] >= threshold
    return result


def approximate_object_assignment(mask: pd.DataFrame, objects: pd.DataFrame) -> pd.DataFrame:
    """
    Assign foreground pixels to the nearest synthetic object centroid.

    This is a transparent educational scaffold, not a production connected-component algorithm.
    """
    foreground = mask[mask["mask"]].copy()
    channel_objects = objects[objects["channel"] == "A"].copy()

    assigned_rows = []

    for _, pixel in foreground.iterrows():
        best_object = None
        best_distance = float("inf")

        for _, obj in channel_objects.iterrows():
            distance = math.sqrt((pixel["x"] - obj["cx"]) ** 2 + (pixel["y"] - obj["cy"]) ** 2)
            if distance < best_distance:
                best_distance = distance
                best_object = obj["object_id"]

        record = pixel.to_dict()
        record["object_id"] = best_object
        record["distance_to_assigned_centroid"] = best_distance
        assigned_rows.append(record)

    return pd.DataFrame(assigned_rows)


def extract_object_features(assigned_pixels: pd.DataFrame) -> pd.DataFrame:
    """Extract object-level feature summaries from assigned foreground pixels."""
    if len(assigned_pixels) == 0:
        return pd.DataFrame(
            columns=[
                "object_id",
                "area_pixels",
                "mean_intensity",
                "integrated_intensity",
                "centroid_x",
                "centroid_y",
                "min_x",
                "max_x",
                "min_y",
                "max_y",
            ]
        )

    features = (
        assigned_pixels.groupby("object_id")
        .agg(
            area_pixels=("intensity", "size"),
            mean_intensity=("intensity", "mean"),
            integrated_intensity=("intensity", "sum"),
            centroid_x=("x", "mean"),
            centroid_y=("y", "mean"),
            min_x=("x", "min"),
            max_x=("x", "max"),
            min_y=("y", "min"),
            max_y=("y", "max"),
        )
        .reset_index()
    )

    return features


def segmentation_metrics(validation_pixels: pd.DataFrame) -> pd.DataFrame:
    """Calculate compact segmentation validation metrics."""
    expert = validation_pixels["expert_mask"] == 1
    model = validation_pixels["model_mask"] == 1

    intersection = (expert & model).sum()
    union = (expert | model).sum()
    expert_area = expert.sum()
    model_area = model.sum()

    true_positive = intersection
    false_positive = (~expert & model).sum()
    false_negative = (expert & ~model).sum()
    true_negative = (~expert & ~model).sum()

    dice = 2 * intersection / (expert_area + model_area) if (expert_area + model_area) > 0 else float("nan")
    iou = intersection / union if union > 0 else float("nan")

    return pd.DataFrame(
        {
            "metric": ["Dice", "IoU", "true_positive", "false_positive", "false_negative", "true_negative"],
            "value": [dice, iou, true_positive, false_positive, false_negative, true_negative],
        }
    )


def colocalization_summary(pixels: pd.DataFrame, threshold_a: float = 30.0, threshold_b: float = 30.0) -> pd.DataFrame:
    """Calculate Pearson and threshold-overlap colocalization scaffolds."""
    result = pixels.copy()
    pearson = result["channel_a"].corr(result["channel_b"])

    result["a_positive"] = result["channel_a"] >= threshold_a
    result["b_positive"] = result["channel_b"] >= threshold_b

    overlap_a = (result["a_positive"] & result["b_positive"]).sum() / max(result["a_positive"].sum(), 1)
    overlap_b = (result["a_positive"] & result["b_positive"]).sum() / max(result["b_positive"].sum(), 1)

    return pd.DataFrame(
        {
            "metric": ["pearson_colocalization", "overlap_fraction_a_positive", "overlap_fraction_b_positive"],
            "value": [pearson, overlap_a, overlap_b],
        }
    )


def tracking_summary(tracks: pd.DataFrame) -> pd.DataFrame:
    """Summarize simple object trajectories."""
    rows = []

    for track_id, subset in tracks.sort_values(["track_id", "frame"]).groupby("track_id"):
        subset = subset.reset_index(drop=True)

        total_distance = 0.0
        for i in range(len(subset) - 1):
            dx = subset.loc[i + 1, "x"] - subset.loc[i, "x"]
            dy = subset.loc[i + 1, "y"] - subset.loc[i, "y"]
            total_distance += math.sqrt(dx ** 2 + dy ** 2)

        net_displacement = math.sqrt(
            (subset.loc[len(subset) - 1, "x"] - subset.loc[0, "x"]) ** 2
            + (subset.loc[len(subset) - 1, "y"] - subset.loc[0, "y"]) ** 2
        )

        rows.append(
            {
                "track_id": track_id,
                "frames": len(subset),
                "total_distance": total_distance,
                "net_displacement": net_displacement,
                "mean_step_distance": total_distance / max(len(subset) - 1, 1),
            }
        )

    return pd.DataFrame(rows)


def sha256_file(path: Path) -> str:
    """Calculate SHA-256 checksum for a file."""
    digest = hashlib.sha256()

    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(65536), b""):
            digest.update(block)

    return digest.hexdigest()


def safe_sha256(path: Path) -> str:
    """Return a checksum or a not-available marker."""
    if path.exists() and path.is_file():
        return sha256_file(path)
    return "not_available"
