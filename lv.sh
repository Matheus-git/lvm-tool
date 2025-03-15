lv_menu() {
    while true; do
        echo
        echo "===================================="
        echo " LV Manager "
        echo "===================================="
        echo "1. List LVs"
        echo "2. Create LV"
        echo "3. LV Details"
        # echo "4. Remove LV"
        echo "4. Go Back"
        echo "===================================="

        read -p "Choose an option: " choice

        case $choice in
            1) list_lvs ;;
            2) create_lv ;;
            3) show_lv ;;
            # 4) remove_lv ;;
            4) echo "Going back..."; break ;;
            *) echo "Invalid option. Please try again." ;;
        esac

        echo
        read -p "Press Enter to continue..."
    done
}

list_lvs() {
    echo "Listing LVs:"
    echo
    lv_names=$(sudo lvdisplay | grep "LV Name" | awk '{print $NF}');
    lv_sizes=$(sudo lvdisplay | grep "LV Size" | awk '{print $(NF-1), $NF}');
    paste <(echo "$lv_names") <(echo "$lv_sizes") | column -t -s $'\t' -N "LV Name,LV Size"
}

create_lv() {
    read -p "Enter the VG name: " vg_name
    read -p "Enter the LV name: " lv_name
    read -p "Enter the LV size (e.g., 10G): " lv_size
    echo
    sudo lvcreate -n "$lv_name" -L "$lv_size" "$vg_name"
}

show_lv(){
    read -p "Enter the LV name: " lv_name
    echo
    sudo lvdisplay | grep -A 13 -B 1 -w "LV Name.*$lv_name"
}