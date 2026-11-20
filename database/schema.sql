- =============================================================================
-- HealthPulse: schema.sql
-- Municipality of Lagonoy, Camarines Sur | MySQL 8.0.30+ (InnoDB)
-- Run this first, then seed.sql
-- =============================================================================
CREATE DATABASE IF NOT EXISTS healthpulse
  CHARACTER SET UTF8MB4
  COLLATE utf8mb4_unicode_ci;

USE healthpulse;

-- Drop tables in reverse dependency order (for clean re-runs)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS dispensing_logs;
DROP TABLE IF EXISTS consultations;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS barangays;
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- 3.1 DATABASE AND TABLE CREATION (BCNF Schema)
-- =============================================================================

-- 1. BARANGAYS: Municipal geographic units in Lagonoy
CREATE TABLE barangays (
  barangay_id INT          PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  zone_count  INT          NOT NULL,
  CONSTRAINT uq_barangay_name
    UNIQUE (name),
  CONSTRAINT chk_barangay_zones
    CHECK (zone_count > 0)
) ENGINE = InnoDB;

-- 2. PATIENTS: Resident demographics
CREATE TABLE patients (
  patient_id  INT          PRIMARY KEY,
  barangay_id INT          NOT NULL,
  first_name  VARCHAR(50)  NOT NULL,
  last_name   VARCHAR(50)  NOT NULL,
  bio_sex     CHAR(1)      NOT NULL,
  birth_date  DATE         NOT NULL,
  contact_no  VARCHAR(20),
  CONSTRAINT fk_patient_barangay
    FOREIGN KEY (barangay_id) REFERENCES barangays(barangay_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT chk_patient_bio_sex
    CHECK (bio_sex IN ('M', 'F'))
) ENGINE = InnoDB;

-- 3. INVENTORY: Rural Health Unit (RHU) & BHS medicine stocks
CREATE TABLE inventory (
  item_id     INT          PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  dosage_form VARCHAR(50)  NOT NULL,
  stock_qty   INT          NOT NULL DEFAULT 0,
  expiry_date DATE         NOT NULL,
  CONSTRAINT chk_inventory_stock
    CHECK (stock_qty >= 0)
) ENGINE = InnoDB;

-- 4. CONSULTATIONS: Clinical visits & diagnoses
CREATE TABLE consultations (
  consult_id    INT          PRIMARY KEY,
  patient_id    INT          NOT NULL,
  barangay_id   INT          NOT NULL,
  consult_date  DATE         NOT NULL DEFAULT (CURRENT_DATE),
  diagnosis     TEXT         NOT NULL,
  attendant_bhw VARCHAR(100) NOT NULL,
  CONSTRAINT fk_consult_patient
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_consult_barangay
    FOREIGN KEY (barangay_id) REFERENCES barangays(barangay_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 5. DISPENSING_LOGS: Associative bridge resolving M:N (Consultations <-> Inventory)
CREATE TABLE dispensing_logs (
  log_id          INT PRIMARY KEY,
  consult_id      INT NOT NULL,
  item_id         INT NOT NULL,
  quantity_issued INT NOT NULL,
  CONSTRAINT fk_log_consult
    FOREIGN KEY (consult_id) REFERENCES consultations(consult_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_log_item
    FOREIGN KEY (item_id) REFERENCES inventory(item_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT uq_consult_item
    UNIQUE (consult_id, item_id),
  CONSTRAINT chk_log_quantity
    CHECK (quantity_issued > 0)
) ENGINE = InnoDB;

-- =============================================================================
-- INDEXES (Phase 4)
-- =============================================================================
-- 1. Resident lookup by barangay
CREATE INDEX idx_patients_barangay
  ON patients (barangay_id);

-- 2. Searching for a patient by name
CREATE INDEX idx_patients_name
  ON patients (last_name, first_name);

-- 3. Patient clinical visit history
CREATE INDEX idx_consults_patient
  ON consultations (patient_id);

-- 4. Date-range morbidity and consultation reports
CREATE INDEX idx_consults_date
  ON consultations (consult_date);

-- 5. Monitoring expiring medicine stocks
CREATE INDEX idx_inventory_expiry
  ON inventory (expiry_date);
