# fMRI Internship — LPNC, Grenoble (April 2025)

This repository contains MATLAB scripts developed during my research internship at the LPNC (Laboratoire de Psychologie et NeuroCognition, CNRS UMR 5105, Université Grenoble Alpes) under the supervision of Hélène Lœvenbruck.

## Internship Objective

The aim of the internship is to conduct deeper analysis of fMRI data collected under different inner speech conditions. The focus is on a region of interest (ROI) in the inferior frontal cortex, potentially involved in the control of inner speech. Analyses will be performed both at the individual and group level to test whether the conditions are associated with different activation patterns in this region.

## Contents

- `check_volume546_batch.m`: Recursively searches through participant folders for inner speech NIfTI files and attempts to load volume 546 from each file to identify loading errors or incomplete data.
- `check_safe_volume_chunks.m`: Loads a NIfTI file in increments of 50 volumes to determine the maximum number of volumes that can be safely read without error.
- `check_volume_range.m`: Allows the user to manually select a NIfTI file and attempts to load volumes 501 to 546 one by one, reporting any read errors.

## Requirements

- MATLAB
- [SPM toolbox](https://www.fil.ion.ucl.ac.uk/spm/software/)

