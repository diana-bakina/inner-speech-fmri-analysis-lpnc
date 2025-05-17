# First-Level Analysis — SPM12

Этот файл описывает пошаговую процедуру создания модели первого уровня в SPM12 для анализа данных одного испытуемого. Каждый этап начинается с краткого пояснения цели и сопровождается действиями в интерфейсе Batch Editor.

---

## 1. Подготовка (Preparation)

**Цель:** создать директорию и подготовить данные для анализа.

**Шаги:**

1. Создать папку для результатов, например: `KC001_innerSpeech_stats`
2. Подготовить onsets — временные метки стимулов, сгруппированные по условиям

   * В секундах или номерах томов (SCANS)
   * Использовать точки (.) вместо запятых (,)

---

## 2. Specify 1st-level Model (указание параметров модели)

**Цель:** задать параметры GLM модели в SPM.

**Шаги:**

1. Открыть: `SPM > Stats > fMRI model specification`
2. Directory → выбрать созданную папку (`KC001_innerSpeech_stats`)
3. Units for design → `SCAN`
4. Interscan interval → `2.5`
5. Microtime resolution → `16`
6. Microtime onset → `8`

---

## 3. Data & Design → Subject/Session

**Цель:** загрузить функциональные данные и условия эксперимента.

**Шаги:**

1. Добавить нового субъекта → New Subject/Session
2. Указать число сессий (например, 2: `7_1` и `9_1`)
3. Для каждой сессии:

   * Scans → выбрать `swar*.nii` файлы
   * Conditions → ввести вручную onset-ы
   * Time Modulation → `None`
   * Parametric Modulation → пусто
   * Multiple Conditions → пусто (если нет .mat файла)
   * Regressors → пусто (опционально)
   * Multiple Regressors → загрузить `rp_*.txt` после Realign
   * High Pass Filter → `128` (в секундах)

---

## 4. Basis Functions

**Цель:** задать форму моделируемого сигнала BOLD.

**Шаги:**

1. Basis Functions → Canonical HRF
2. Model Derivatives → `No derivatives`
3. Model Interactions (Volterra) → `Do not model interactions`

---

## 5. Other Settings

**Цель:** завершить конфигурацию модели.

**Шаги:**

* Global Normalisation → `None`
* Explicit Mask → пусто
* Serial Correlations → `AR(1)` (по умолчанию)

---

## Финал

* Сохраняем batch: `File > Save Batch` (лучше — отдельный файл на каждого участника)
* Запускаем: зелёная стрелка (Run)
* Убедись, что находишься в папке участника перед запуском

Результаты сохранятся в указанной директории и будут включать файл `SPM.mat` и статистические карты.
