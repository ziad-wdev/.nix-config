# The Color Goldilocks System: UI Design Guidelines

## 1. The Saturation (S) Goldilocks Zone
Keep saturation tightly bounded to define the color's role without causing eye strain.

* **Backgrounds & UI Panels:** 10% – 15% (Subtle tint, avoids muddy greys).
* **Foreground Text:** 15% – 25% (Readable, slightly tinted to match the theme).
* **Accents (Red, Green, Blue):** 35% – 50% (Pops against the background, avoids harsh neon bleeding).

## 2. The Lightness (L) Goldilocks Zone
Lightness dictates function and readability.

### Backgrounds
* **Dark Mode:** 5% – 15% (Never 0% pitch black).
* **Light Mode:** 85% – 95% (Never 100% pure white).

### Text & Accents
* **Text (Dark Mode):** 75% – 85% (Soft off-white to prevent astigmatism bloom).
* **Text (Light Mode):** 15% – 25% (Soft charcoal, easier on the eyes than pure black).
* **Accents:** 55% – 65% (Maintains pigment integrity and contrast).

## 3. Lightness Spacing for Perceptual Depth
To ensure distinct UI elements don't bleed together, use rigid Lightness spacing.

* **Micro-steps** *(UI Borders, Hover states):* Shift L by 5% to 8% from base.
* **Macro-steps** *(Popups, Active Selections):* Shift L by 12% to 15% from base.
* **Text Contrast Spacing:** Minimum gap of 50% Lightness between text and its background.

---

## 4. Defined Scales

### Background (Base 7%)
*Builds 4 levels above a 7% base. Uses micro-steps (6%) for subtle UI changes and macro-steps (8%) for heavy elevation.*

| Level | Lightness | Usage |
| :--- | :--- | :--- |
| `bg-base` | **7%** | Main application background |
| `bg-1` | **13%** (+6%) | Alternate rows, active line |
| `bg-2` | **19%** (+6%) | Hover states, surface borders |
| `bg-3` | **27%** (+8%) | Active selections, dropdown menus |
| `bg-4` | **35%** (+8%) | Floating popups, modal surfaces |

### Accent (Base 55%)
*Builds 2 levels below and 2 above using 8% intervals. Keeps color strictly within the "pigment" zone (39%–71%).*

| Level | Lightness | Usage |
| :--- | :--- | :--- |
| `accent-dark-2` | **39%** (-16%) | Deep borders, pressed states |
| `accent-dark-1` | **47%** (-8%) | Hover states for solid buttons |
| `accent-base` | **55%** | Primary accent, default state |
| `accent-light-1` | **63%** (+8%) | Hover states for outline/ghost buttons |
| `accent-light-2` | **71%** (+16%) | Soft highlights, focus rings |

### Foreground Text (Base 85%)
*Drops 4 levels from 85% landing perfectly in the muted 40–50% range using a uniform 10% subtraction step.*

| Level | Lightness | Usage |
| :--- | :--- | :--- |
| `fg-base` | **85%** | Primary text, maximum focus |
| `fg-1` | **75%** (-10%) | Secondary text, descriptions |
| `fg-2` | **65%** (-10%) | Tertiary text, passive icons |
| `fg-3` | **55%** (-10%) | Disabled states |
| `fg-4` | **45%** (-10%) | Muted text, input placeholders |
