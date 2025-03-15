#!/bin/bash

# ========================================================
# Script: Gerenciador de LVM
# Descrição: Ferramenta em Bash para gerenciar Logical Volume Manager (LVM).
#            Permite criar, listar, redimensionar e remover volumes físicos (PVs),
#            grupos de volumes (VGs) e volumes lógicos (LVs).
# Autor: Matheus Silva
# Versão: 1.0
# Data: 2025-03-05
# Licença: MIT
# Repositório: https://github.com/Matheus-git/lvm-tool
# ========================================================

# Função para exibir o menu

source vg.sh
source lv.sh

show_menu() {
    echo
    echo "===================================="
    echo " Gerenciador de LVM - Menu Principal "
    echo "===================================="
    echo "1. Volumes Físicos (PVs)"
    echo "2. Volumes lógicos (LVs)"
    echo "3. Listar Volumes Lógicos (LVs)"
    echo "4. Criar Volume Físico (PV)"
    echo "5. Criar Grupo de Volumes (VG)"
    echo "6. Criar Volume Lógico (LV)"
    echo "7. Redimensionar Volume Lógico (LV)"
    echo "8. Remover Volume Lógico (LV)"
    echo "9. Remover Grupo de Volumes (VG)"
    echo "10. Remover Volume Físico (PV)"
    echo "11. Sair"
    echo "===================================="
}

# Função para listar volumes físicos
list_pvs() {
    echo "Listando Volumes Físicos (PVs):"
    sudo pvs
    read -p "Pressione Enter para continuar..."
}

# Função para criar volume físico
create_pv() {
    read -p "Digite o dispositivo para criar o PV (ex: /dev/sdb1): " device
    sudo pvcreate "$device"
    read -p "Pressione Enter para continuar..."
}

# Função para criar volume lógico
# create_lv() {
#     read -p "Digite o nome do Volume Lógico (LV): " lv_name
#     read -p "Digite o nome do Grupo de Volumes (VG): " vg_name
#     read -p "Digite o tamanho do LV (ex: 10G): " lv_size
#     sudo lvcreate -n "$lv_name" -L "$lv_size" "$vg_name"
#     read -p "Pressione Enter para continuar..."
# }

# Função para redimensionar volume lógico
# resize_lv() {
#     read -p "Digite o nome do Volume Lógico (LV) (ex: /dev/vg_name/lv_name): " lv_path
#     read -p "Digite o novo tamanho do LV (ex: +5G ou -2G): " lv_size
#     sudo lvresize -L "$lv_size" "$lv_path"
#     sudo resize2fs "$lv_path"  # Ajusta o sistema de arquivos (se for ext4)
#     read -p "Pressione Enter para continuar..."
# }

# Função para remover volume lógico
remove_lv() {
    read -p "Digite o nome do Volume Lógico (LV) (ex: /dev/vg_name/lv_name): " lv_path
    sudo lvremove "$lv_path"
    read -p "Pressione Enter para continuar..."
}


# Função para remover volume físico
remove_pv() {
    read -p "Digite o dispositivo do Volume Físico (PV) (ex: /dev/sdb1): " device
    sudo pvremove "$device"
    read -p "Pressione Enter para continuar..."
}

# Loop principal do menu
while true; do
    show_menu
    read -p "Escolha uma opção: " choice

    case $choice in
        1) vg_menu ;;
        2) lv_menu ;;
        4) create_pv ;;
        6) create_lv ;;
        7) resize_lv ;;
        8) remove_lv ;;
        10) remove_pv ;;
        11) echo "Saindo..."; break ;;
        *) echo "Opção inválida. Tente novamente." ;;
    esac
done