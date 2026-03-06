#!/usr/bin/env bash

# =========================================
# SOC Incident Note Generator (Bash)
# File: daily-incident-header.sh
#
# What it does
# - Takes incident details from the analyst and prints a clean SOC-style note.
# - Validates/cleans inputs (Incident ID, Severity, Status).
# - Adds Priority + Next Step based on Severity.
# - If Status is RESOLVED, Next Step switches to a closure message.
# - Daily log rotation: saves to incident_notes_YYYY-MM-DD.log.
# - If user chooses Y, appends to the daily log and writes the log header once.
#
# Inputs
# - Incident ID: INC-1023 or 1023 (auto -> INC-1023)
# - Severity: HIGH / MEDIUM / LOW (invalid -> LOW)
# - Status: OPEN / INVESTIGATING / CONTAINED / RESOLVED (invalid -> INVESTIGATING)
# - Title, Summary (blank summary -> "Summary not provided")
#
# Notes
# - Uses: echo, read -r, variables, if/else, $(date), $(whoami)
# =========================================

echo "Please Enter Below Details"
read -r -p "Incident ID :" INC

if [ -z "$INC" ]; then
        echo "Incident ID cannot be empty."
        exit 1
elif [[ "$INC" =~ ^[0-9]+$ ]]; then
        INC="INC-$INC"
elif [[ "$INC" =~ ^INC-[0-9]+$ ]]; then
        :
else  
        echo "Invalid Input for the Incident ID"
        exit 1
fi

read -r -p"Severity (HIGH/MEDIUM/LOW): " Severity

if [[ "${Severity^^}" == HIGH ]];then 
        priority="P1"
        next_step="Escalate to on-call, contain impact, update in 30 mins."
elif [[ "${Severity^^}" == MEDIUM ]];then
        priority="P2"
        next_step="Investigate logs, confirm scope, update in 2 hrs."
elif [[ "${Severity^^}" == LOW ]];then
        priority="P3"
        next_step="Monitor and document, update EOD."
else 
        Severity="LOW"
        priority="P3"
        next_step="Monitor and document, update EOD."
        echo "Warning: Invalid Severity. Defaulting to LOW"
fi 

read -r -p "Status (OPEN/INVESTIGATING/CONTAINED/RESOLVED):" Status

if [[ "${Status^^}" =~ ^(OPEN|INVESTIGATING|CONTAINED|RESOLVED)$ ]];then
        :
else
        Status="INVESTIGATING"
        echo "Warning: INvalid Status. Defaulting it to INVESTIGATING"
fi

if [[ "${Status^^}" == RESOLVED ]];then 
	next_step="Close ticket + document RCA."
fi 

read -r -p "Title:" title

read -r -p "Summary (1 line):" summary
if [[ -z "$summary" ]]; then
        summary="Summary not provided"
fi

username=$(whoami)
today=$(date +"%F %H:%M:%S")
day=$(date +"%F")
log_file="incident_notes_$(date +"%F").log"
echo "Do you want to save the data to $log_file (Y/N) ?"
read -r CONSENT

if [[ "${CONSENT^^}" == Y ]]; then
	if [[ ! -s "$log_file" ]]; then
		{
			echo "===== Incident Note Header ====="
		}>>$log_file
	fi
        {
                echo "Incident ID: $INC"
                echo "Severity: $Severity"
                echo "Priority: $priority"
                echo "Status: $Status"
                echo "Title: $title"
                echo "Summary: $summary"
                echo "Date: $today"
                echo "Analyst: $username"
                echo "Next Step: $next_step"
		echo "----------------------------------------------------------------"
        }>>$log_file 
        echo " Incident data is saved successully under $log_file file."
else
        echo "Thank You the Data for Incident ID: $INC will not be saved."
fi
