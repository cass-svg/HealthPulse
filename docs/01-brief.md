# Project Brief: HealthPulse

## 1. The problem
Barangay Health Workers and Rural Health Unit staff in Lagonoy use manual paper logbooks. Tracking patients, consultations, and medicine stocks on paper causes duplicate entries and lost records. Staff also struggle to catch low or expiring medicine stock in time.

## 2. Users and what they need to do
| User role | What they need to do in the app |
|---|---|
| BHW / Health Staff | Register patients, log consultations, and record dispensed medicines. |
| RHU Admin / Health Officer | Manage barangays, update medicine inventory, and view health reports. |

## 3. The database behind it
Database: `healthpulse` (5 tables).
- `barangays`: Stores Lagonoy barangays and their zone counts.
- `patients`: Stores resident patient profiles linked to their barangay.
- `consultations`: Records clinical visits, diagnoses, and attending BHWs for each patient.
- `inventory`: Tracks available medicines, stock quantities, and expiration dates.
- `dispensing_logs`: Links consultations and inventory to record how much medicine was issued.

## 4. Must-have features (for the final project)
- Register new patients and assign them to a barangay.
- Search existing patient records and view past consultations.
- Log new consultations and record dispensed medicines.
- Track medicine stock levels and block dispensing when stock is insufficient.
- View summary counts of consultations and medicine usage by barangay.

## 5. Nice-to-have features (only if there's time)
- Highlight medicines nearing their expiration date.
- Export consultation and inventory summaries as printable reports.
- Filter patient and dispensing history by date range.

## 6. Similar apps I looked at
- OpenMRS / clinic record systems: Borrow the clean separation between patient profiles and visit/consultation logs.
- Standard inventory trackers: Borrow clear stock-level indicators so low supplies stand out quickly.
