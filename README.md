# Daily Incident Note Generator (Bash)

A beginner-friendly Bash script to create SOC-style incident notes.  
It collects incident details from the analyst, validates key inputs, and prints a clean note.  
If you choose **Y**, it appends the note to `incident_notes.log` (with a one-time log header).

---

## What this script does

### Collects
- **Incident ID** (accepts `INC-1023` or `1023` → auto converts to `INC-1023`)
- **Severity:** `HIGH / MEDIUM / LOW` (invalid/blank → defaults to `LOW`)
- **Status:** `OPEN / INVESTIGATING / CONTAINED / RESOLVED` (invalid/blank → defaults to `INVESTIGATING`)
- **Title** (short description)
- **Summary** (1 line; blank → `Summary not provided`)

### Auto-adds
- **Date** (`YYYY-MM-DD`)
- **Analyst** (current system user)
- **Priority mapping:**
  - `HIGH → P1`
  - `MEDIUM → P2`
  - `LOW → P3`
- **Next Step** guidance based on severity (escalate / investigate / monitor)

### Logging
- Log file: `incident_notes.log`
- If you choose **Y**:
  - Writes a one-time header if the log is missing/empty
  - Appends each new note with a separator
- If you choose **N**:
  - Does **not** create or modify any log file

---

## How to run (Kali Linux)

```bash
chmod +x daily-incident-header.sh
./daily-incident-header.sh
```

## Example Output (saved in incident_notes.log)

```text
===== Incident Note Header =====
Incident ID: INC-123
Severity: LOW
Priority: P3
Status: INVESTIGATING
Title: Failed login spike
Summary: Spike in failed logins from multiple IPs
Date: 2026-03-05
Analyst: kali
Next Step: Monitor and document, update EOD.
----------------------------------------------------------------
