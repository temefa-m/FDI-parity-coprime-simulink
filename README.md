# Fault Detection (FDI) for Vehicle Lateral Dynamics (MATLAB/Simulink)

This repository contains a MATLAB/Simulink implementation of **fault detection** for a vehicle lateral dynamics model using two residual-generation approaches: **Coprime Factorization** and **Parity Space**.  
The objective is to generate a residual signal that remains close to zero in the healthy case and shows a clear deviation when a fault occurs, even in the presence of disturbances and measurement noise.

## Problem statement
A linear vehicle lateral dynamics system is considered in the form:

ẋ = Ax + Bu + E_d d + E_f f  
y  = Cx + Du + F_d d + F_f f + ν  

where `d` represents unknown inputs/disturbances and `ν` is measurement noise.  
The task is to propose and simulate an FDI scheme using:
- Coprime Factorization
- Parity

and discuss how the parity-based approach can be made more robust to unknown inputs.

## Implemented methods

### Coprime factorization (residual filter)
In this approach, the residual generator is constructed based on a stable coprime factorization and a redundancy relation, leading to an estimated output ŷ and the residual:

r = y − ŷ  

This method provides a clean **dynamic residual filter** implementation and (in this project) enables reliable fault detection under noise/disturbance assumptions.

### Parity-space residual generation
The parity method builds a linear relation over a finite time window (with length `s`, typically `s > n`) using stacked input/output samples. The residual is (approximately) zero in the fault-free case and deviates significantly when a fault is injected.  
In Simulink, delay blocks are used to construct the time-windowed signals, compute the parity residual, and generate an alarm using a threshold.

## Robustness to unknown inputs (Parity discussion)
In parity-based FDI, robustness against unknown inputs/disturbances can be improved by designing the parity projection (or residual direction) to **attenuate/decouple** the disturbance subspace while maintaining sensitivity to faults.  
In practice, this relates to selecting an appropriate window length `s`, using structured residual design, and tuning thresholds to account for disturbance/noise levels and input transients (to reduce false alarms).

## Repository structure
- `src/` : MATLAB scripts for model setup, residual generation, and plotting
- `simulink/` : Simulink model(s) implementing coprime/parity residual generators and alarm logic
- `results/` : Figures/screenshots of outputs, residuals, and alarm signals (optional)

## How to run
1. Open MATLAB and ensure required toolboxes for control/system modeling are available.
2. Open the Simulink model
3. Run the simulation.
4. Inspect:
   - System output `y` in healthy and faulty cases
   - Residual `r` for both methods (near zero when healthy, clear deviation under faults)
   - Alarm signal based on thresholding (note: false alarms may occur during strong input transients)

## Notes on fault scenarios
The implementation considers disturbances and measurement noise, and injects step-like faults to evaluate detectability through residual/alarm behavior.  
Depending on the modeled fault channels and available measurements, not all faults may be equally observable in the output/residual.

## Author
Fateme Mohammadi
