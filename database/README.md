# Database

MySQL schema, seed data, and local test data for `pcds_queue_db`.

- `schema.sql` — creates the database and all tables (departments, staff_users, service_windows, queue_numbers, queue_counters, qr_sessions, queue_history, audit_logs, system_settings). Safe to re-run (drops and recreates tables).
- `seed.sql` — default departments/windows and system settings. Idempotent; it does not create an admin account.
- `test_data.sql` — sample queue walkthrough data for local development only. Not for production.

Run order: `schema.sql` → `seed.sql` → create an administrator with `backend/create_admin.py`. Run `test_data.sql` only in a non-production database.
