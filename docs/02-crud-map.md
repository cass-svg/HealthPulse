## 1. CRUD map
| Table | C | R | U | D | Pages | Who |
|---|---|---|---|---|---|---|
| `barangays` | ✓ | ✓ | ✓ | ✗ | `/barangays` | RHU Admin: C, R, U. BHW / Health Staff: R only. No delete (keep historical/FK links). |
| `patients` | ✓ | ✓ | ✓ | ✗ | `/patients`, `/patients/[id]` | BHW / Health Staff & RHU Admin: C, R, U. No delete (preserve clinical history). |
| `inventory` | ✓ | ✓ | ✓ | ✗ | `/inventory` | RHU Admin: C, R, U. BHW / Health Staff: R only. No delete (keep dispensing log history). |
| `consultations` | ✓ | ✓ | ✓ | ✗ | `/consultations`, `/patients/[id]` | BHW / Health Staff & RHU Admin: C, R, U. No delete (keep clinical visit records). |
| `dispensing_logs` | ✓ | ✓ | ✗ | ✗ | `/consultations/[id]` | BHW / Health Staff & RHU Admin: C, R. No update/delete (keep stock audit trail). |

## 2. Form fields (`patients` & `consultations`)
### `patients` (Add / Edit)
- `barangay_id` | `<select>` (from `barangays.name`, value = `barangay_id`) | Required (`NOT NULL`)
- `first_name` | `<input type="text">` | Required (`NOT NULL`)
- `last_name` | `<input type="text">` | Required (`NOT NULL`)
- `bio_sex` | `<select>` or radio (`M`, `F`) | Required (`NOT NULL`, `CHECK` in `('M', 'F')`)
- `birth_date` | `<input type="date">` | Required (`NOT NULL`)
- `contact_no` | `<input type="tel">` | Optional (`NULL` allowed)

### `consultations` (Add / Edit)
- `patient_id` | `<select>` (from `patients` name, value = `patient_id`) | Required (`NOT NULL`)
- `barangay_id` | `<select>` (from `barangays.name`, value = `barangay_id`) | Required (`NOT NULL`)
- `consult_date` | `<input type="date">` (defaults to `(CURRENT_DATE)`) | Required (`NOT NULL`)
- `diagnosis` | `<textarea>` | Required (`NOT NULL`)
- `attendant_bhw` | `<input type="text">` | Required (`NOT NULL`)

## 3. Schema changes
None.
