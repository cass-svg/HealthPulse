-- =============================================================================
-- HealthPulse: seed.sql
-- Sample Data for Lagonoy Barangay Health Stations | MySQL 8.0.16+ (InnoDB)
-- Run schema.sql first, then execute this file.
-- =============================================================================
USE healthpulse;

-- Clear existing rows in reverse foreign-key dependency order (safe re-runs)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE dispensing_logs;
TRUNCATE TABLE consultations;
TRUNCATE TABLE inventory;
TRUNCATE TABLE patients;
TRUNCATE TABLE barangays;
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- 1. BARANGAYS (zone_count > 0, unique name)
-- =============================================================================
INSERT INTO barangays (barangay_id, name, zone_count) VALUES
  (1, 'San Isidro',     7),
  (2, 'San Sebastian',  6),
  (3, 'Gubat',          8),
  (4, 'Agosais',        5);

-- =============================================================================
-- 2. PATIENTS (bio_sex IN ('M', 'F'), valid barangay_id)
-- =============================================================================
INSERT INTO patients (patient_id, barangay_id, first_name, last_name, bio_sex, birth_date, contact_no) VALUES
  (101, 1, 'Elena',   'Ramos',    'F', '1992-04-14', '0917-555-0101'),
  (102, 1, 'Mateo',   'Bautista', 'M', '1985-09-22', '0918-555-0102'),
  (103, 2, 'Clarissa','Mendoza',  'F', '2001-01-10', '0919-555-0103'),
  (104, 3, 'Ramon',   'Dela Cruz','M', '1978-11-05', '0920-555-0104'),
  (105, 4, 'Marisol', 'Navarro',  'F', '1996-07-30', NULL);

-- =============================================================================
-- 3. INVENTORY (stock_qty >= 0, valid expiry_date)
-- =============================================================================
INSERT INTO inventory (item_id, name, dosage_form, stock_qty, expiry_date) VALUES
  (201, 'Amoxicillin 500mg',   'Capsule', 240, '2027-08-31'),
  (202, 'Paracetamol 500mg',   'Tablet',  500, '2028-03-15'),
  (203, 'Losartan 50mg',       'Tablet',  180, '2027-12-01'),
  (204, 'Oral Rehydration Salt', 'Sachet',  120, '2027-06-20'),
  (205, 'Cetirizine 10mg',     'Tablet',   95, '2027-10-10');

-- =============================================================================
-- 4. CONSULTATIONS (consult_date defaults to CURRENT_DATE if omitted)
-- Note: Patient 101 lives in Barangay 1 (San Isidro) but visited Barangay 2
-- (San Sebastian) health station, demonstrating cross-barangay visit tracking.
-- =============================================================================
INSERT INTO consultations (consult_id, patient_id, barangay_id, consult_date, diagnosis, attendant_bhw) VALUES
  (301, 101, 1, '2026-11-05', 'Acute upper respiratory tract infection', 'BHW Lorna Reyes'),
  (302, 102, 1, '2026-11-08', 'Essential hypertension follow-up',        'BHW Lorna Reyes'),
  (303, 103, 2, '2026-11-12', 'Allergic rhinitis',                       'BHW Danilo Cruz'),
  (304, 104, 3, '2026-11-15', 'Acute watery diarrhea without dehydration','BHW Tessie Gomez'),
  (305, 101, 2, '2026-11-18', 'Mild fever and body malaise',            'BHW Danilo Cruz');

-- =============================================================================
-- 5. DISPENSING_LOGS (quantity_issued > 0, unique (consult_id, item_id))
-- =============================================================================
INSERT INTO dispensing_logs (log_id, consult_id, item_id, quantity_issued) VALUES
  (401, 301, 201, 21), -- Consult 301: 21 Amoxicillin capsules
  (402, 301, 202, 10), -- Consult 301: 10 Paracetamol tablets
  (403, 302, 203, 30), -- Consult 302: 30 Losartan tablets
  (404, 303, 205,  7), -- Consult 303: 7 Cetirizine tablets
  (405, 304, 204,  6), -- Consult 304: 6 ORS sachets
  (406, 305, 202,  6); -- Consult 305: 6 Paracetamol tablets
