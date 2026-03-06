# Daily Incident Note Generator (Bash)

A beginner-friendly Bash script to create SOC-style incident notes.  
It collects incident details from the analyst, validates key inputs, and prints a clean note.  
If you choose **Y**, it appends the note to a **daily log file** like `incident_notes_YYYY-MM-DD.log` (with a one-time log header).

---

## What this script does

### Collects
- **Incident ID** (accepts `INC-1023` or `1023` → auto converts to `INC-1023`)
- **Severity:** `HIGH / MEDIUM / LOW` (invalid/blank → defaults to `LOW`)
- **Status:** `OPEN / INVESTIGATING / CONTAINED / RESOLVED` (invalid/blank → defaults to `INVESTIGATING`)
- **Title** (short description)
- **Summary** (1 line; blank → `Summary not provided`)

### Auto-adds
- **Timestamp** (`YYYY-MM-DD HH:MM:SS`)
- **Analyst** (current system user)
- **Priority mapping:**
  - `HIGH → P1`
  - `MEDIUM → P2`
  - `LOW → P3`
- **Next Step** guidance based on severity (escalate / investigate / monitor)
- If **Status = RESOLVED**, Next Step switches to a closure message.

### Logging (Daily Rotation)
- Log file format: `incident_notes_YYYY-MM-DD.log`
- If you choose **Y**:
  - Writes a one-time header if the daily log is missing/empty
  - Appends each new note with a separator line
- If you choose **N**:
  - Does **not** create or modify any log file

---

## How to run (Kali Linux)

```bash
chmod +x daily-incident-header.sh
./daily-incident-header.sh
```
### Collects
- Incident ID (accepts `INC-1023` or `1023` → auto converts to `INC-1023`)

## Where the output is saved

The incident header is appended to 
- incident_notes.log
To view the entries: 
```
cat incident_notes_*.log
```

## Example Output (saved in incident_notes.log)
```
=== Incident Note Header ===
Incident ID : INC-001
Severity : High 
Priority : P1
Status : INVESTIGATING
Title : Failed Login spike
SUmmary : Spike in failed logins from multiple IPs.
Date : 2026-03-03 13:25:40
Analyst : kali
Next Step : Escalate to 0n-call, contain impact, update in 30 mins.
====================================================================
```

## SKills used 
- `echo` (printing output)
- `read -r` (taking user input safely) / `read -r -p` (safe user input + prompts)
- Varibles (storing input and system values)
- command substitution: 
  - `$(date...)` for date/time 
  - `$(whoami)` for current user
- `if / elif / else` (validation + logic)
- File append redirection:
  - `>> incident_notes_YYYY-MM-DD.log`
====================================================================

