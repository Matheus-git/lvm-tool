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
source pv.sh

show_menu() {
    echo
    echo "===================================="
    echo " Gerenciador de LVM - Menu Principal "
    echo "===================================="
    echo "1. Grupo de Volumes (VGs)"
    echo "2. Volumes lógicos (LVs)"
    echo "3. Volumes Físicos (PVs)"
    echo "4. Sair"
    echo "===================================="
}

# Função para redimensionar volume lógico
# resize_lv() {
#     read -p "Digite o nome do Volume Lógico (LV) (ex: /dev/vg_name/lv_name): " lv_path
#     read -p "Digite o novo tamanho do LV (ex: +5G ou -2G): " lv_size
#     sudo lvresize -L "$lv_size" "$lv_path"
#     sudo resize2fs "$lv_path"  # Ajusta o sistema de arquivos (se for ext4)
#     read -p "Pressione Enter para continuar..."
# }

# Loop principal do menu
while true; do
    show_menu
    read -p "Escolha uma opção: " choice

    case $choice in
        1) vg_menu ;;
        2) lv_menu ;;
        3) pv_menu ;;
        4) echo "Saindo..."; break ;;
        *) echo "Opção inválida. Tente novamente." ;;
    esac
done