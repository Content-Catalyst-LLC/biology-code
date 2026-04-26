# Methodology Notes

## Purpose

The computational examples support neurobiology reasoning by translating signaling, integration, thresholds, recurrent connectivity, feedback, and response into transparent calculations.

## Core Methods

### Baseline Recovery

A first-pass recovery model is:

dV/dt = -k(V - V*)

where V is a state variable, V* is the target or resting state, and k is a recovery rate.

### Leaky Integration

A compact membrane-like model is:

tau dV/dt = -(V - V_rest) + R I(t)

where tau is a time constant, V_rest is resting potential, R scales input, and I(t) is time-varying input.

### Threshold Events

A simplified response event occurs when:

V(t) >= theta

where theta is the threshold.

### Recurrent Network Response

A compact network model is:

dx_i/dt = -x_i + f(sum_j w_ij x_j + I_i)

where x_i is unit activity, w_ij is connectivity, I_i is external input, and f is a nonlinear activation function.

## Interpretation

These workflows should be interpreted as educational neurobiology scaffolds, not as full biophysical neuron models. They do not replace Hodgkin-Huxley models, conductance-based models, compartmental models, electrophysiology, imaging, or experimental neuroscience. Real applications require calibrated data, uncertainty analysis, biological validation, and domain expertise.
