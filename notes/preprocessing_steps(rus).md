# fMRI Preprocessing Pipeline — SPM12

Этот файл описывает поэтапную пространственную и временную обработку fMRI-данных одного испытуемого с использованием SPM12 (MATLAB). Каждому этапу предшествует краткое описание цели. Шаги оформлены в формате действий в интерфейсе SPM Batch Editor.

---

## 1. Realign (коррекция движения)
**Цель:** устранить артефакты, вызванные движениями головы.

**Шаги:**
1. Открыть SPM12 > Batch
2. SPM > Spatial > Realign > Realign: Estimate & Reslice
3. В левой панели: Realign: Estimate & Reslice <-X → дважды клик на Data <-X
4. Создать нужное число Session (New: Session, в нашем случае 2)
5. Для каждой Session:
   - Дважды клик → Specify Files
   - Ввести в поле под надписью Filter: `1:500` (большое число, чтобы вывести все существующие)
   - Выбрать все тома (правой кнопкой мыши и 'select all') → Done

**Параметры (оставить по умолчанию):**
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

## 2. Slice Timing (коррекция временного сдвига)
**Цель:** выровнять временные различия между срезами одного объема.

**Шаги:**
1. SPM > Temporal > Slice Timing
2. Дважды клик на Data <-X → Session <-X
3. Нажать Dependency → выбрать: Realign: Estimate & Reslice: Resliced Images (Sess 1)

**Параметры:**
- Number of Slices = 42
- TR = 2.5
- TA = TR - TR/42 (SPM посчитает автоматически)
- Slice Order = [1:42] (в нашем случае это последовательный порядок)
- Reference Slice = 21
- Prefix = `a`

---

## 3. Coregister (совмещение EPI и T1)
**Цель:** выровнять анатомическое изображение по среднему функциональному.

**Шаги:**
1. SPM > Spatial > Coregister > Coregister: Estimate
2. Reference Image → Dependency: Realign: Estimate & Reslice: Mean Image
3. Source Image → Specify: анатомическое T1 (например, KC001_Anat_... .nii)
4. Other Images — оставить пустым

**Параметры:** оставить все по умолчанию

---

## 4. Segment (сегментация + параметры нормализации)
**Цель:** рассчитать параметры для нормализации и получить карты тканей.

**Шаги:**
1. SPM > Spatial > Segment
2. Volumes → Dependency: Coregister: Estimate: Coregistered Images
3. Save Bias Corrected → выбрать Yes
4. Deformation Fields → выбрать Inverse + Forward (Emilie said it's better to have both just in case!)

---

## 5. Normalise: Write (нормализация анатомии)
**Цель:** применить сегментацию к анатомии → привести в MNI-пространство

**Шаги:**
1. SPM > Spatial > Normalise > Write
2. Data → Subject:
   - Deformation Field → Dependency: Segment: Forward Deformations
   - Images to Write → Dependency: Segment: Bias Corrected (1)
3. Voxel Size = [1 1 1] или [2 2 2]
4. Prefix = `w`

---

## 6. Normalise: Write (нормализация функционала)
**Цель:** привести обработанные EPI изображения в MNI-пространство

**Шаги:**
1. SPM > Spatial > Normalise > Write
2. Data → Subject:
   - Deformation Field → Dependency: Segment: Forward Deformations
   - Images to Write → Dependency: Slice Timing: Slice Timing Corr. Images (Sess 1)
3. Voxel Size = [3 3 3] или [2 2 2]
4. Prefix = `w`

---

## 7. Smooth (пространственное сглаживание)
**Цель:** повысить стабильность статистики и соответствие предпосылкам Гауссовой модели.

**Шаги:**
1. SPM > Spatial > Smooth
2. Images to Smooth → Dependency: Normalise: Write: Normalised Images (Subj 1)
3. FWHM = [8 8 8] мм (или [6 6 6] при необходимости. Мы создаем два batch файла и для 666, и для 888 на всякий случай)
4. Prefix = `s` (или в нашем случае s6 и s8

---

## Финал
- Сохраняем batch: File > Save Batch (лучше — отдельный файл на каждого участника)
- Запускаем: зелёная стрелка (Run)
! Перед запуском обработки, перейди в папку с данными конкретного испытуемого!
- Результирующие файлы имеют префиксы: `swar*.nii`

Эти файлы используются для статистического анализа.

