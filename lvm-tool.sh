#!/bin/bash

# ========================================================
# Script: LVM Manager
# Description: Bash tool to manage Logical Volume Manager (LVM).
#              Allows creating, listing, resizing, and removing physical volumes (PVs),
#              volume groups (VGs), and logical volumes (LVs).
# Author: Matheus Silva
# Version: 1.0.0
# Date: 2025-03-05
# License: MIT
# Repository: https://github.com/Matheus-git/lvm-tool
# ========================================================

source vg.sh
source lv.sh
source pv.sh

show_menu() {
    clear
    echo "===================================="
    echo " LVM Manager - Main Menu "
    echo "===================================="
    echo "1. Volume Groups (VGs)"
    echo "2. Logical Volumes (LVs)"
    echo "3. Physical Volumes (PVs)"
    echo "4. Exit"
    echo "===================================="
}

while true; do
    show_menu
    read -p "Choose an option: " choice

    case $choice in
        1) vg_menu ;;
        2) lv_menu ;;
        3) pv_menu ;;
        4) echo "Exiting..."; break ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done