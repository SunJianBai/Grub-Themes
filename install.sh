#!/bin/bash

THEME_DIR='/usr/share/grub/themes'
THEME_NAME=''

function echo_title() {     echo -ne "\033[1;44;37m${*}\033[0m\n"; }
function echo_caption() {   echo -ne "\033[0;1;44m${*}\033[0m\n"; }
function echo_bold() {      echo -ne "\033[0;1;34m${*}\033[0m\n"; }
function echo_danger() {    echo -ne "\033[0;31m${*}\033[0m\n"; }
function echo_success() {   echo -ne "\033[0;32m${*}\033[0m\n"; }
function echo_warning() {   echo -ne "\033[0;33m${*}\033[0m\n"; }
function echo_secondary() { echo -ne "\033[0;34m${*}\033[0m\n"; }
function echo_info() {      echo -ne "\033[0;35m${*}\033[0m\n"; }
function echo_primary() {   echo -ne "\033[0;36m${*}\033[0m\n"; }
function echo_error() {     echo -ne "\033[0;1;31m错误:\033[0;31m\t${*}\033[0m\n"; }
function echo_label() {     echo -ne "\033[0;1;32m${*}:\033[0m\t"; }
function echo_prompt() {    echo -ne "\033[0;36m${*}\033[0m "; }

function splash() {
    local hr
    hr=" **$(printf "%${#1}s" | tr ' ' '*')** "
    echo_title "${hr}"
      echo_title " * $1 * "
    echo_title "${hr}"
    echo
}

function check_root() {
      # 检查 root 权限
    ROOT_UID=0
    if [[ ! "${UID}" -eq "${ROOT_UID}" ]]; then
                        # 错误信息
                        echo_error '请以 root 身份运行。'
                        echo_info '例如：sudo ./install.sh'
        exit 1
    fi
}

function select_theme() {
      # 选择主题
            themes=('Amogus' 'Arcade' 'Arch' 'Atomic' 'BigSur' 'Cyberpunk' 'Cyberpunk2' 'CyberRe' 'Darkmatter' 'Deadpool' 'DedSec' 'fallout' 'Ichika' 'Itsuki' 'Kali' 'Mario' 'Miku' 'Monterey' 'Nino' 'Polylight' 'Sekiro' 'Shodan' 'Sleek' 'Tela' 'Vimix' 'Virtualfuture' 'whitesur' 'Yotsuba' 'Quit')

            PS3=$(echo_prompt '\n请选择要安装的主题: ')
    select THEME_NAME in "${themes[@]}"; do
        case "${THEME_NAME}" in
          'Amogus')
                                    splash '正在安装 AmongUS 主题'
            break;;
          'Arcade')
                                    splash '正在安装 Arcade 主题'
            break;;
          'Arch')
                                    splash '正在安装 Arch 主题'
            break;;
          'Atomic')
                                    splash '正在安装 Atomic 主题'
            break;;
          'BigSur')
                                    splash '正在安装 BigSur 主题'
            break;;
          'CyberRe')
                                                splash '正在安装 CyberRe 主题'
                break;;
          'Cyberpunk')
                                                splash '正在安装 Cyberpunk 主题'
                break;;
          'Cyberpunk2')
                                                splash '正在安装 Cyberpunk2 主题'
                break;;
          'Darkmatter')
                                                splash '正在安装 Darkmatter 主题'
                break;;
          'Deadpool')
                                                splash '正在安装 Deadpool 主题'
                break;;
          'DedSec')
                                                splash '正在安装 DedSec 主题' 
                break;;
          'fallout')
                                                splash '正在安装 fallout 主题'
                break;;
          
          'Ichika')
                                                splash '正在安装 Ichika 主题' 
                break;;
          'Itsuki')
                                                splash '正在安装 Itsuki 主题' 
                break;;
          'Kali')
                                                splash '正在安装 Kali 主题' 
                break;;
          'Mario')
                                                splash '正在安装 Mario 主题' 
                break;;
         'Miku')
                                                splash '正在安装 Miku 主题' 
                break;;
          'Monterey')
                                                splash '正在安装 Monterey 主题' 
                break;;
          'Nino')
                                                splash '正在安装 Nino 主题' 
                break;;
          'Polylight')
                                                splash '正在安装 Polylight 主题' 
                break;;
          'Sekiro')
                                                splash '正在安装 Sekiro 主题'
                break;;
          'Shodan')
                                                splash '正在安装 Shodan 主题'
                break;;
          'Sleek')
                                                splash '正在安装 Sleek 主题'
                break;;
          'Tela')
                                                splash '正在安装 Tela 主题'
                break;;
          'Vimix')
                                                splash '正在安装 Vimix 主题'
                break;;
           'Virtualfuture')
                                                splash '正在安装 Virtualfuture 主题'
                break;;
          'whitesur')
                                                splash '正在安装 whitesur 主题' 
                break;;
          'Yotsuba')
                                                splash '正在安装 Yotsuba 主题' 
                break;;
          'Quit')
                                                echo_info '用户选择退出'
                exit 0;;
            *) echo_warning "invalid option \"${REPLY}\"";;
        esac
    done
}

function backup() {
      # 备份 grub 配置
      echo_info 'cp -an /etc/default/grub /etc/default/grub.bak'
    cp -an /etc/default/grub /etc/default/grub.bak
}

function install_theme() {
      # 若不存在，创建主题目录
    if [[ ! -d "${THEME_DIR}/${THEME_NAME}" ]]; then
            # 复制主题文件
            echo_primary "正在安装 ${THEME_NAME} 主题..."

        echo_info "mkdir -p \"${THEME_DIR}/${THEME_NAME}\""
        mkdir -p "${THEME_DIR}/${THEME_NAME}"

        echo_info "cp -a ./themes/\"${THEME_NAME}\"/* \"${THEME_DIR}/${THEME_NAME}\""
        cp -a ./themes/"${THEME_NAME}"/* "${THEME_DIR}/${THEME_NAME}"
    fi
}

function config_grub() {
      echo_primary '启用 GRUB 菜单'
      # 删除已有的 GRUB_TIMEOUT_STYLE 配置
    echo_info "sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub"
    sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub

      echo_info "echo 'GRUB_TIMEOUT_STYLE=\"menu\"' >> /etc/default/grub"
      echo 'GRUB_TIMEOUT_STYLE="menu"' >> /etc/default/grub

      echo_primary '设置 GRUB 超时时间为 10 秒'
      # 删除已有的 GRUB_TIMEOUT 配置
    echo_info "sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub"
    sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub

      echo_info "echo 'GRUB_TIMEOUT=\"10\"' >> /etc/default/grub"
      echo 'GRUB_TIMEOUT="10"' >> /etc/default/grub

      echo_primary "将 ${THEME_NAME} 设置为默认主题"
      # 删除已有的 GRUB_THEME 配置
    echo_info "sed -i '/GRUB_THEME=/d' /etc/default/grub"
    sed -i '/GRUB_THEME=/d' /etc/default/grub

    echo_info "echo \"GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"\" >> /etc/default/grub"
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
}

function update_grub() {
      # 更新 grub 配置
      echo_primary '正在更新 GRUB 配置...'
    if [[ -x "$(command -v update-grub)" ]]; then
        echo_info 'update-grub'
        update-grub

    elif [[ -x "$(command -v grub-mkconfig)" ]]; then
        echo_info 'grub-mkconfig -o /boot/grub/grub.cfg'
        grub-mkconfig -o /boot/grub/grub.cfg

    elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
            if [[ -x "$(command -v zypper)" ]]; then
                  echo_info 'grub2-mkconfig -o /boot/grub2/grub.cfg'
            grub2-mkconfig -o /boot/grub2/grub.cfg

        elif [[ -x "$(command -v dnf)" ]]; then
                  echo_info 'grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg'
            grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}

function main() {
    check_root
    select_theme

    install_theme

    config_grub
    update_grub

      echo_success '安装完成！'
}

main
