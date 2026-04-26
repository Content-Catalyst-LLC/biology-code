# Methodology Notes

## Purpose

The computational examples support behavioral-biology reasoning by translating payoff logic, probabilistic choice, sender-receiver communication, environmental noise, and conflict strategy into transparent calculations.

## Core Methods

### Payoff Logic

A minimal behavioral payoff can be written as:

W = B - C

where W is net payoff, B is benefit, and C is cost.

### Softmax Choice

Choice probability is modeled as:

P_i = exp(beta U_i) / sum_j exp(beta U_j)

where U_i is the utility of option i and beta controls how strongly utility differences influence choice.

### Sender-Receiver Signaling

Communication is modeled as a combined sender and receiver problem. Sender utility includes mate benefit, energetic cost, and predator exposure. Receiver response is modeled using a logistic function of detectability and receiver state.

### Environmental Noise

Noisy conditions reduce detectability, which can lower receiver response and combined strategic score.

### Hawk-Dove Conflict

The Hawk-Dove model represents strategic conflict where payoffs depend on resource value V and cost of conflict C. It is useful for illustrating why restraint can emerge under individual-level selection when escalation is costly.

## Interpretation

These workflows should be interpreted as educational behavioral ecology scaffolds, not as operational behavioral predictions. Real applications require observation, experimental validation, sensory ecology, species-specific parameter estimation, and ecological interpretation.
