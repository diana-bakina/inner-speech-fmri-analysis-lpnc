# First-Level Analysis — SPM12 (English Version)

This file outlines the step-by-step procedure for first-level model specification in SPM12 for a single subject. Each stage starts with a short goal description followed by exact actions in the Batch Editor interface.

---

## 1. Preparation

**Goal:** create a folder and prepare input data.

**Steps:**

1. Create a directory for results, e.g. `KC001_innerSpeech_stats`
2. Prepare onsets — stimulus timing grouped by condition

   * In seconds or scan numbers (SCANS)
   * Use dots (.) instead of commas (,)

---

## 2. Specify 1st-level Model

**Goal:** define GLM parameters in SPM.

**Steps:**

1. Open: `SPM > Stats > fMRI model specification`
2. Directory → choose the folder `KC001_innerSpeech_stats`
3. Units for design → `SCAN`
4. Interscan interval → `2.5`
5. Microtime resolution → `16`
6. Microtime onset → `8`

---

## 3. Data & Design → Subject/Session

**Goal:** load functional data and stimulus conditions.

**Steps:**

1. Add a new subject → New Subject/Session
2. Set number of sessions (e.g., 2: `7_1` and `9_1`)
3. For each session:

   * Scans → select `swar*.nii` files
   * Conditions → enter onsets manually
   * Time Modulation → `None`
   * Parametric Modulation → leave empty
   * Multiple Conditions → leave empty (if not using a .mat file)
   * Regressors → leave empty (optional)
   * Multiple Regressors → load `rp_*.txt` from Realign
   * High Pass Filter → `128` (in seconds)

---

## 4. Basis Functions

**Goal:** define the modeled BOLD signal shape.

**Steps:**

1. Basis Functions → Canonical HRF
2. Model Derivatives → `No derivatives`
3. Model Interactions (Volterra) → `Do not model interactions`

---

## 5. Other Settings

**Goal:** finalize model configuration.

**Steps:**

* Global Normalisation → `None`
* Explicit Mask → leave empty
* Serial Correlations → `AR(1)` (default)

---

## Final

* Save batch: `File > Save Batch` (separate file per subject recommended)
* Run: green arrow (Run)
* Make sure you are in the subject’s folder before running

Results will be saved in the selected directory and will include `SPM.mat` and activation maps.
