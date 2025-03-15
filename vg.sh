vg_menu() {
    while true; do
        echo
        echo "===================================="
        echo " VG Manager "
        echo "===================================="
        echo "1. List VGs"
        echo "2. Create VG"
        echo "3. VG Details"
        # echo "4. Remove VG"
        echo "4. Go Back"
        echo "===================================="

        read -p "Choose an option: " choice

        case $choice in
            1) list_vgs ;;
            2) create_vg ;;
            3) show_vg ;;
            # 4) remove_vg ;;
            4) echo "Going back..."; break ;;
            *) echo "Invalid option. Please try again." ;;
        esac

        echo
        read -p "Press Enter to continue..."
    done
}

list_vgs() {
    echo "Listing VGs:"
    echo
    vg_names=$(sudo vgdisplay | grep "VG Name" | awk '{print $NF}');
    vg_sizes=$(sudo vgdisplay | grep "VG Size" | awk '{print $(NF-1), $NF}');
    paste <(echo "$vg_names") <(echo "$vg_sizes") | column -t -s $'\t' -N "VG Name,VG Size"
}

create_vg() {
    read -p "Enter the VG name: " vg_name
    read -p "Enter the device to add to the VG (e.g., /dev/sdb1): " device
    echo
    sudo vgcreate "$vg_name" "$device"
}

show_vg(){
    read -p "Enter the VG name: " vg_name
    echo
    sudo vgdisplay | grep -A 19 -w "VG Name.*$vg_name"
}