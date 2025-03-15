lv_menu() {
    while true; do
        echo
        echo "===================================="
        echo " LV Manager "
        echo "===================================="
        echo "1. List LVs"
        echo "2. Create LV"
        echo "3. LV Details"
        echo "4. Extend LV"
        echo "5. Reduce LV"
        # echo "4. Remove LV"
        echo "6. Go Back"
        echo "===================================="

        read -p "Choose an option: " choice

        case $choice in
            1) list_lvs ;;
            2) create_lv ;;
            3) show_lv ;;
            # 4) remove_lv ;;
            4) extend_lv ;;
            5) reduce_lv ;;
            6) echo "Going back..."; break ;;
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

extend_lv() {
    read -p "Enter the VG name: " vg_name
    read -p "Enter the LV name: " lv_name
    read -p "Enter the new LV size (e.g., 10G): " lv_size
    lv_path=$(sudo lvdisplay | grep -B 1 "LV Name.*$lv_name" | grep "LV Path" | awk '{print $NF}');
    echo
    sudo lvextend -L "$lv_size" "$lv_path"
    sudo e2fsck -f "$lv_path"
    sudo resize2fs "$lv_path"
}

reduce_lv() {
    read -p "Enter the VG name: " vg_name
    read -p "Enter the LV name: " lv_name
    read -p "Enter the new LV size (e.g., 10G): " lv_size
    lv_path=$(sudo lvdisplay | grep -B 1 "LV Name.*$lv_name" | grep "LV Path" | awk '{print $NF}');
    echo

    mount_point=$(findmnt -n -o TARGET --source "$lv_path")
    if [ -n "$mount_point" ]; then
        echo "Erro: dispositivo $lv_path está montado em $mount_point"
        return
    fi
    sudo e2fsck -f "$lv_path"
    sudo resize2fs "$lv_path" "$lv_size"
    sudo lvreduce -L "$lv_size" "$lv_path"
}

show_lv(){
    read -p "Enter the LV name: " lv_name
    echo
    sudo lvdisplay | grep -A 13 -B 1 -w "LV Name.*$lv_name"
}