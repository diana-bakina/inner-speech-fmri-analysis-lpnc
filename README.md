# fMRI Internship — LPNC, Grenoble (April 2025)

This repository contains MATLAB scripts developed during my research internship at the LPNC (Laboratoire de Psychologie et NeuroCognition, CNRS UMR 5105, Université Grenoble Alpes) under the supervision of Hélène Lœvenbruck.

## Internship Objective

The aim of the internship is to conduct deeper analysis of fMRI data collected under different inner speech conditions. The focus is on a region of interest (ROI) in the inferior frontal cortex, potentially involved in the control of inner speech. Analyses will be performed both at the individual and group level to test whether the conditions are associated with different activation patterns in this region.

## Contents

- `check_volume546_batch.m`: Recursively searches through participant folders for inner speech NIfTI files and attempts to load volume 546 from each file to identify loading errors or incomplete data.
- `check_safe_volume_chunks.m`: Loads a NIfTI file in increments of 50 volumes to determine the maximum number of volumes that can be safely read without error.
- `check_volume_range.m`: Allows the user to manually select a NIfTI file and attempts to load volumes 501 to 546 one by one, reporting any read errors.

## Batch Files

Batch configurations for preprocessing (SPM12) are available in the `batches/` folder:

- `preprocessing-888.mat`: full preprocessing pipeline with smoothing FWHM = [8 8 8]
- `preprocessing-666.mat`: same pipeline with FWHM = [6 6 6]

These can be loaded in SPM12 Batch Editor and used directly or modified for other subjects.

## Requirements

- MATLAB
- [SPM toolbox](https://www.fil.ion.ucl.ac.uk/spm/software/)

## Preprocessing Pipeline (SPM12)

Detailed step-by-step guides for preprocessing one subject using SPM12 are available in the `notes/` folder:

- [Preprocessing Steps (Russian)](notes/preprocessing_steps(rus).md)
- [Preprocessing Steps (English)](notes/preprocessing_steps(eng).md)

Each document outlines the spatial and temporal preprocessing flow:
1. Realignment
2. Slice Timing Correction
3. Coregistration
4. Segmentation & Normalisation
5. Smoothing

The instructions follow the Batch Editor interface in SPM12 and include all parameter settings.

## First-Level Analysis (SPM12)

Instructions for first-level (individual subject) GLM-based statistical modeling in SPM12:

- [First-Level Analysis (Russian)](notes/first_lvl_analysis(rus).md)
- [First-Level Analysis (English)](notes/first_lvl_analysis(eng).md)

This process includes:
1. Creating an output directory  
2. Preparing onset files  
3. Specifying the model and timing settings  
4. Importing functional scans and conditions  
5. Setting regressors, HRF model, and high-pass filter  
6. Finalizing and running the model

## Documentation & References

This preprocessing pipeline is based on the following guide:

**Manuel rapide de traitement de données d’IRMf avec le logiciel SPM**  
*Authors: Emilie Cousin, Cédric Pichat*  
Université Grenoble Alpes, September 2019

**Useful links:**
- [SPM official site](http://www.fil.ion.ucl.ac.uk/spm/)
- [SPM12 official manual (English)](http://www.fil.ion.ucl.ac.uk/spm/doc/)
- [SPM99 guide (French, theory still valid for SPM12)](http://irmfmrs.free.fr/IMG/pdf/spm99doc.pdf)
- [Updated guide for SPM8/SPM12 (French, more practical)](http://irmfmrs.free.fr/spip.php?article166)
- [SPM12 toolboxes](http://www.fil.ion.ucl.ac.uk/spm/ext/)
