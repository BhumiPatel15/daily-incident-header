#!/bin/sh


# ================================
# Task 2 — Incident Note Header Generator (Basics only)
# File: 02_incident_header.sh
# Goal: Practice ONLY echo, variables, read -r, command substitution $(...)
#
# REQUIREMENTS:
#
# 1) Print this title line exactly:
#    === Incident Note Header ===
#
# 2) Ask the user (using read -r) for:
#    - Incident ID (example: INC-1023)
#    - Severity (example: Low/Medium/High)
#    - Short issue title (example: Failed login spike)
#
# 3) Store each input in a variable.
#
# 4) Capture (using command substitution) and store:
#    - Today’s date in YYYY-MM-DD (hint: date +%F)
#    - Current system user (hint: whoami)
#
# 5) Output must print a clean header like this (same labels):
#
#    === Incident Note Header ===
#    Incident: INC-1023
#    Severity: High
#    Title: Failed login spike
#    Date: 2026-03-03
#    Analyst: bhumi
#
# RULES:
# - ✅ Use only: echo, read -r, variables, $(date ...), $(whoami)
# - ❌ No loops, no if/else, no functions, no case, no files, no extra commands
# ================================

echo "Please Enter Below Details"
echo "Incident ID :"
read -r INC
echo "Severity :"
read -r Severity 
echo "Title :"
read -r title
today=$(date +"%F")
username=$(whoami)
log_file="incident_notes.log"

{
echo "=== Incident Note Header ==="
echo "Incident ID: $INC"
echo "Severity: $Severity"
echo "Title: $title"
echo "Date: $today"
echo "Analyst: $username"
echo "============================"
}>>$log_file

echo "Incident data is saved successfully under $log_file file"
