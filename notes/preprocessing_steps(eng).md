# fMRI Preprocessing Pipeline — SPM12 (English Version)

This document outlines the step-by-step spatial and temporal preprocessing of fMRI data for a single subject using SPM12 (MATLAB). Each stage includes a brief description of the goal followed by instructions for setting it up in the SPM Batch Editor.

---

## 1. Realign (motion correction)
**Goal:** remove artifacts caused by subject head movement.

**Steps:**
1. Open SPM12 > Batch
2. SPM > Spatial > Realign > Realign: Estimate & Reslice
3. In the left panel: Realign: Estimate & Reslice <-X → double-click on Data <-X
4. Create required number of Sessions (New: Session, in our case 2)
5. For each Session:
   - Double-click → Specify Files
   - In the Filter field, enter: `1:500` (a high number to list all existing volumes)
   - Select all volumes (right-click → 'select all') → Done

**Parameters (keep default values):**
- Quality = 0.9
- Separation = 4
- Smoothing = 5
- Num Passes = Register to mean
- Interpolation = 2nd Degree B-Spline
- Wrapping = No wrap
- Weighting = 0

**Reslice Options:**
- Resliced Images = All Images + Mean Image
- Interpolation = 4th Degree B-Spline
- Masking = Mask Images
- Prefix = `r`

---

## 2. Slice Timing (slice acquisition time correction)
**Goal:** correct temporal differences between slices within each volume.

**Steps:**
1. SPM > Temporal > Slice Timing
2. Double-click on Data <-X → Session <-X
3. Click Dependency → choose: Realign: Estimate & Reslice: Resliced Images (Sess 1)

**Parameters:**
- Number of Slices = 42
- TR = 2.5
- TA = TR - TR/42 (SPM calculates this automatically)
- Slice Order = [1:42] (sequential order in our case)
- Reference Slice = 21
- Prefix = `a`

---

## 3. Coregister (align EPI and T1)
**Goal:** align anatomical image with mean functional image.

**Steps:**
1. SPM > Spatial > Coregister > Coregister: Estimate
2. Reference Image → Dependency: Realign: Estimate & Reslice: Mean Image
3. Source Image → Specify: anatomical T1 (e.g., KC001_Anat_... .nii)
4. Other Images — leave empty

**Parameters:** keep all default

---

## 4. Segment (segmentation + normalization parameters)
**Goal:** compute normalization parameters and generate tissue probability maps.

**Steps:**
1. SPM > Spatial > Segment
2. Volumes → Dependency: Coregister: Estimate: Coregistered Images
3. Save Bias Corrected → select Yes
4. Deformation Fields → select Inverse + Forward (Emilie said it's better to have both just in case!)

---

## 5. Normalise: Write (normalize anatomy)
**Goal:** apply segmentation-derived transformations to anatomical image to bring it into MNI space.

**Steps:**
1. SPM > Spatial > Normalise > Write
2. Data → Subject:
   - Deformation Field → Dependency: Segment: Forward Deformations
   - Images to Write → Dependency: Segment: Bias Corrected (1)
3. Voxel Size = [1 1 1] or [2 2 2]
4. Prefix = `w`

---

## 6. Normalise: Write (normalize functional images)
**Goal:** bring preprocessed EPI images into MNI space.

**Steps:**
1. SPM > Spatial > Normalise > Write
2. Data → Subject:
   - Deformation Field → Dependency: Segment: Forward Deformations
   - Images to Write → Dependency: Slice Timing: Slice Timing Corr. Images (Sess 1)
3. Voxel Size = [3 3 3] or [2 2 2]
4. Prefix = `w`

---

## 7. Smooth (spatial smoothing)
**Goal:** improve statistical validity and reduce noise using Gaussian smoothing.

**Steps:**
1. SPM > Spatial > Smooth
2. Images to Smooth → Dependency: Normalise: Write: Normalised Images (Subj 1)
3. FWHM = [8 8 8] mm (or [6 6 6] if needed — we create two batch files, one for each)
4. Prefix = `s` (or in our case, `s6` and `s8`)

---

## Final Step
- Save your batch: File > Save Batch (preferably a separate file per subject)
- Run: green arrow (Run)
! Make sure you are in the subject’s data folder before running the pipeline.
- Output files will have prefixes: `swar*.nii`

These are the files to be used for statistical analysis.

