#!/bin/bash

# ========================================
# BACKUP VERIFICATION SCRIPT
# ========================================
# Purpose: Compare file counts between multiple servers at specified paths
# 
# This script provides a basic method to verify backup completion by counting
# files on different servers and comparing the results. While not a comprehensive
# backup verification tool, matching file counts can indicate that backups
# have been successfully transferred.
#
# Usage: ./verify-backups.sh
#
# How it works:
# - Connects to each configured server via SSH
# - Runs 'find' command to count files at specified paths
# - Displays results with progress indicators
# - Compare the file counts manually to verify backup consistency
#
# Note: This verification method has limitations:
# - Only counts files, doesn't verify file integrity or content
# - Use additional verification methods for critical backup validation
#
# ========================================
# Author: Jereme Hancock (This tool was developed with assistance from AI language models)
# Version: 1.0
# ========================================

# ========================================
# SERVER CONFIGURATION
# ========================================

# Format: "Display Name|SSH User@Host|Path"
SERVERS=(
    "Display Name|SSH User@Host|Path"
    "Display Name|SSH User@Host|Path"
    "Display Name|SSH User@Host|Path"
)

# ========================================
# COLOR CONFIGURATION
# ========================================
RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
BLUE='\033[94m'
PURPLE='\033[95m'
CYAN='\033[96m'
WHITE='\033[97m'
BOLD='\033[1m'
RESET='\033[0m'

# Function to show pulsing progress dots
show_progress() {
    local pid=$1
    local count=0
    while kill -0 $pid 2>/dev/null; do
        printf "."
        count=$((count + 1))
        if [ $count -eq 10 ]; then
            # Clear the 10 dots and start over
            printf "\b\b\b\b\b\b\b\b\b\b          \b\b\b\b\b\b\b\b\b\b"
            count=0
        fi
        sleep 0.3
    done
}

echo -e "${BOLD}${CYAN}========================================================================================================${RESET}"
echo -e "${BOLD}${CYAN}                                          BACKUPS COUNT REPORT                                          ${RESET}"
echo -e "${BOLD}${CYAN}========================================================================================================${RESET}"

# Loop through each server
for i in "${!SERVERS[@]}"; do
    # Parse server configuration using pipe delimiter
    IFS='|' read -r server_name server_host server_path <<< "${SERVERS[$i]}"
    
    echo -e "${BOLD}${GREEN}🖥️  $server_name${RESET}"
    echo -e "${YELLOW}   Path:${RESET} ${BLUE}$server_path${RESET}"
    echo -ne "${PURPLE}   File count:${RESET} ${CYAN}Counting${RESET}"
    
    # Run command in background and show progress
    temp_file="/tmp/server${i}_count"
    ssh "$server_host" "find \"$server_path\" -type f" | wc -l > "$temp_file" 2>/dev/null &
    show_progress $!
    wait $!
    
    # Clear the entire line and show result
    printf "\r   File count: %-50s" ""
    printf "\r${PURPLE}   File count:${RESET} ${BOLD}${GREEN}$(cat "$temp_file")${RESET}\n"
    rm -f "$temp_file"
    echo
done

echo -e "${BOLD}${GREEN}✅ Report completed at ${YELLOW}$(date)${RESET}"
