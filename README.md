Fault Detection (FDI) for Vehicle Lateral Dynamics (MATLAB/Simulink)
This repository contains a MATLAB/Simulink implementation of fault detection for a vehicle lateral dynamics model using two residual-generation approaches: Coprime Factorization and Parity Space.
​
The goal is to design a residual signal that stays close to zero in the healthy case and changes clearly when a fault occurs, even in the presence of disturbances and measurement noise.
​

Problem statement
A linear vehicle lateral dynamics system is considered in the form: 
x
˙
=
A
x
+
B
u
+
E
d
d
+
E
f
f
x
˙
 =Ax+Bu+E 
d
 d+E 
f
 f, 
y
=
C
x
+
D
u
+
F
d
d
+
F
f
f
+
ν
y=Cx+Du+F 
d
 d+F 
f
 f+ν, where 
d
d represents unknown inputs/disturbances and 
ν
ν is measurement noise.
​
The task is to propose and simulate an FDI scheme using: (1) Coprime Factorization and (2) Parity, and discuss how parity-based residuals can be made more robust against unknown inputs.
​

Methods implemented
Coprime Factorization (residual filter)
A residual generator is built based on a stable left coprime factorization of the plant and a redundancy relation, yielding an estimated output 
y
^
y
^
  and residual 
r
=
y
−
y
^
r=y− 
y
^
 .
​
This approach provides a clean dynamic residual filter and (in this project) shows reliable fault detection while maintaining stability under noise/disturbance assumptions.
​

Parity-space residual generation
The parity method constructs a linear relation over a finite time window (with window length 
s
>
n
s>n) using stacked input/output samples; the residual is (approximately) zero in the fault-free case and deviates significantly under faults.
​
In Simulink, delayed blocks are used to build the time-windowed signals and generate the parity residual, then an alarm is produced using a threshold.
​

Robustness to unknown inputs (Parity discussion)
In parity-based FDI, robustness against unknown inputs/disturbances can be improved by designing the parity vector (or residual projection) to attenuate/decouple the disturbance subspace while keeping sensitivity to faults.
​
Practically, this is related to choosing an appropriate window length 
s
s, using structured residual design, and setting thresholds that account for transients and disturbance/noise levels (to reduce false alarms).
​

Project structure
src/ : MATLAB scripts for model setup, residual generation, and plotting.

simulink/ : Simulink model(s) implementing coprime/parity residual generators and alarm logic.

results/ : Saved plots/screenshots of outputs, residuals, and alarm signals (optional).

How to run
Open MATLAB and ensure required toolboxes for control/system modeling are available.
​

Open the Simulink model: simulink/<YOUR_MODEL_NAME>.slx.

Run the simulation.

Inspect:

System output 
y
y in healthy and faulty cases.
​

Residual 
r
r for both methods (should be small near zero when healthy, and deviate under faults).
​

Alarm signal based on thresholding (note possible false alarms during strong input transients).
​

Notes on fault scenarios
The implementation considers disturbances and noise, and injects step-like faults to evaluate detectability through residual/alarm behavior.
​
Based on the modeled fault channels and observations, fault effects may differ in visibility at the output/residual (not all faults are equally observable).
​

Author
Fateme Mohammadi
