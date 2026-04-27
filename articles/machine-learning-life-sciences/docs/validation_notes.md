# Validation Notes

Machine-learning validation in the life sciences should be designed around the biological question.

## Common Validation Failures

- random splitting when repeated biological measurements require grouped splitting
- preprocessing before splitting
- duplicated samples across train and test sets
- image tiles from the same slide appearing in both train and test data
- sequence similarity leakage
- batch effects that correlate with labels
- site, instrument, or technician effects
- labels that encode downstream knowledge unavailable at prediction time
- small sample sizes with high-dimensional feature sets
- reporting accuracy without calibration or subgroup analysis

## Better Practice

- split by the true unit of independence
- preserve external validation
- report uncertainty intervals
- report calibration
- analyze subgroup performance
- document provenance
- separate model interpretation from biological causality
- validate against independent biological evidence
