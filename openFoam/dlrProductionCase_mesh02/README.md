# DLR Production Case
_13-Feb-2020_

Julian M. Toumey

## Description
This case combines the required components for the DLR production case.
These components include

* A further-refined mesh: 24 million cells

* Inflow turbulence generator
  + The `decayingTurbulenceInflowGenerator` boundary patch at the combustor inlet
  + The spatially-varying velocity profile supplied in the order of cell faces.     If the mesh changes, these velocities must be updated
  + The Reynolds stress tensor at the inlet, extracted from turbulent statistics in a previous CONVERGE run

* Field averaging for Reynolds stress 
  + The `controlDict` file contains this configuration
   
* This case is pre-decomposePar. 
  Decomposing will distribute velocities to various processor folders, which may be unique. 

* Because the output format is binary, the 0 folder will be overwritten to contain binary data for velocity. 
  Hence, this case preserves the turbulence inflow generator velocity.
