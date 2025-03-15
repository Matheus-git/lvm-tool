pv_menu() {
    while true; do
        echo
        echo "===================================="
        echo " PV Manager "
        echo "===================================="
        echo "1. List PVs"
        echo "2. Create PV"
        echo "3. PV Details"
        # echo "4. Remove PV"
        echo "4. Go Back"
        echo "===================================="

        read -p "Choose an option: " choice

        case $choice in
            1) list_pvs ;;
            2) create_pv ;;
            3) show_pv ;;
            # 4) remove_pv ;;
            4) echo "Going back..."; break ;;
            *) echo "Invalid option. Please try again." ;;
        esac

        echo
        read -p "Press Enter to continue..."
    done
}

list_pvs() {
    echo "Listing PVs:"
    echo
    pv_names=$(sudo pvdisplay | grep "PV Name" | awk '{print $NF}');
    pv_sizes=$(sudo pvdisplay | grep "PV Size" | awk '{for(i=2; i<=NF; i++) printf $i " "; print ""}')
    paste <(echo "$pv_names") <(echo "$pv_sizes") | column -t -s $'\t' -N "PV Name,PV Size"
}

create_pv() {
    read -p "Enter the device to create the PV (e.g., /dev/sdb1): " device
    echo
    sudo pvcreate "$device"
}

show_pv(){
    read -p "Enter the PV name (e.g., /dev/sdb1): " pv_name
    echo
    sudo pvdisplay | grep -A 7 -w "PV Name.*$pv_name"
}