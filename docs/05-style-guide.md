# Style Guide: HealthPulse

## Colors

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| Primary | #0f766e | Primary buttons, active navigation, key accents |
| Background | #f8fafc | Page background |
| Text | #0f172a | Body text, labels, table cells |
| Success | #15803d | Saved confirmations, healthy stock status |
| Error | #b91c1c | Inline form errors, low/expired stock alerts |

**Contrast Check:**
- Text (#0f172a) on Background (#f8fafc): Ratio 17.07:1 ✓ (Passes WCAG AA)

---

## Fonts

- **Heading Font**: Poppins, Arial, sans-serif
- **Body Font**: Inter, Arial, sans-serif
- **Base Font Size**: 16px

---

## Components

- **Primary Button**: Solid `#0f766e` fill, `#ffffff` text, `8px` border radius, hover `#115e59`.
- **Secondary Button**: Solid `#ffffff` fill, `1px solid #cbd5e1` border, `#0f172a` text, `8px` border radius, hover `#f1f5f9`.
- **Text Input**: Solid `#ffffff` fill, `1px solid #cbd5e1` border, `#0f172a` text (`16px`), `8px` border radius; invalid state uses `1px solid #b91c1c`.
- **Error Message**: `#b91c1c` text (`14px`) displayed directly beneath the invalid input field (e.g., `* Diagnosis is required.`).

---

## CSS Custom Properties

```css
:root {
  --color-primary: #0f766e;
  --color-primary-hover: #115e59;
  --color-bg: #f8fafc;
  --color-surface: #ffffff;
  --color-border: #cbd5e1;
  --color-text: #0f172a;
  --color-success: #15803d;
  --color-error: #b91c1c;
  --font-heading: "Poppins", Arial, sans-serif;
  --font-body: "Inter", Arial, sans-serif;
  --font-size-base: 16px;
  --radius: 8px;
}
