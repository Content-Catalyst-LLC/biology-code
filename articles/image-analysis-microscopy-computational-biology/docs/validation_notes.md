# Validation Notes

## Image Analysis

- Threshold segmentation is sensitive to background, noise, illumination, and contrast.
- Pixel measurements should be calibrated to physical units when real data are used.
- Segmentation should be checked against expert review or ground truth where possible.
- Feature tables are only as reliable as segmentation and acquisition quality.
- Colocalization should be interpreted with optical blur, bleed-through, background, and resolution limits in mind.
- Tracking errors can distort displacement, velocity, lineage, and division timing.

## Metadata

- Real microscopy data should preserve pixel size, z-spacing, channels, acquisition settings, instrument information, sample identity, and processing history.
- OME-style metadata and interoperable formats are preferred when practical.

## Limitations

The examples do not implement production segmentation, deep learning, OME-TIFF writing, microscopy file readers, real connected-component labeling, watershed segmentation, deconvolution, drift correction, illumination correction, 3D segmentation, or clinical image interpretation.
