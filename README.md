# Daily Incident Header (Bash)

A beginner-friendly Bash script for SOC-style daily incident reporting.  
The analyst enters basic incident details, and the script appends a formatted incident header to a log file (`incident_notes.log`).  
This helps maintain a simple, readable daily record of incident updates.

---

## What this script does
- Prompts the analyst for:
  - Incident ID
  - Severity (Low/Medium/High)
  - Title (short description)
- Automatically adds:
  - Today’s date (`YYYY-MM-DD`)
  - Current system user (analyst name from the system)
- Saves the output by appending to:
  - `incident_notes.log`

---

## How to run (Kali Linux)
```bash
chmod +x daily-incident-header.sh
./daily-incident-header.sh
```

## Where the output is saved

The incident header is appended to 
- incident_notes.log
To view the entries: 
```
cat incident_notes.log
```

## Example Output (saved in incident_notes.log)
```
=== Incident Note Header ===
Incident ID : INC-001
Severity : High 
Title : Failed LogIn
Date : 2026-03-03
Analyst : kali
============================
```

## SKills used 
- echo (printing output)
- read -r (taking user input safely)
- Varibles (storing input and system values)
- command substitution: 
  - $(date+%F) for date 
  - $(whoami) for current user
