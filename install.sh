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
                                    themes=(
                                          'Amogus' \
                                          'Arcade（街机）' \
                                          'Arch' \
                                          'Atomic（原子）' \
                                          'BigSur（大苏尔）' \
                                          'Cyberpunk（赛博朋克）' \
                                          'Cyberpunk2（赛博朋克2）' \
                                          'CyberRe' \
                                          'Darkmatter（暗物质）' \
                                          'Deadpool（死侍）' \
                                          'DedSec（死码）' \
                                          'fallout（辐射）' \
                                          'Ichika（一花）' \
                                          'Itsuki（五木）' \
                                          'Kali' \
                                          'Mario（马里奥）' \
                                          'Miku（初音未来）' \
                                          'Monterey（蒙特雷）' \
                                          'Nino（二乃）' \
                                          'Polylight（多光）' \
                                          'Sekiro（只狼）' \
                                          'Shodan（守望者）' \
                                          'Sleek（极简）' \
                                          'Tela（特拉）' \
                                          'Vimix' \
                                          'Virtualfuture（虚拟未来）' \
                                          'whitesur（白苏尔）' \
                                          'Yotsuba（四叶）' \
                                          'Quit'
                                    )

            PS3=$(echo_prompt '\n请选择要安装的主题: ')
            select THEME_NAME in "${themes[@]}"; do
                        case "${THEME_NAME}" in
                              'Amogus') splash '正在安装 Amogus 主题'; break;;
                              'Arcade（街机）') splash '正在安装 Arcade（街机）主题'; break;;
                              'Arch') splash '正在安装 Arch 主题'; break;;
                              'Atomic（原子）') splash '正在安装 Atomic（原子）主题'; break;;
                              'BigSur（大苏尔）') splash '正在安装 BigSur（大苏尔）主题'; break;;
                              'Cyberpunk（赛博朋克）') splash '正在安装 Cyberpunk（赛博朋克）主题'; break;;
                              'Cyberpunk2（赛博朋克2）') splash '正在安装 Cyberpunk2（赛博朋克2）主题'; break;;
                              'CyberRe') splash '正在安装 CyberRe 主题'; break;;
                              'Darkmatter（暗物质）') splash '正在安装 Darkmatter（暗物质）主题'; break;;
                              'Deadpool（死侍）') splash '正在安装 Deadpool（死侍）主题'; break;;
                              'DedSec（死码）') splash '正在安装 DedSec（死码）主题'; break;;
                              'fallout（辐射）') splash '正在安装 fallout（辐射）主题'; break;;
                              'Ichika（一花）') splash '正在安装 Ichika（一花）主题'; break;;
                              'Itsuki（五木）') splash '正在安装 Itsuki（五木）主题'; break;;
                              'Kali') splash '正在安装 Kali 主题'; break;;
                              'Mario（马里奥）') splash '正在安装 Mario（马里奥）主题'; break;;
                              'Miku（初音未来）') splash '正在安装 Miku（初音未来）主题'; break;;
                              'Monterey（蒙特雷）') splash '正在安装 Monterey（蒙特雷）主题'; break;;
                              'Nino（二乃）') splash '正在安装 Nino（二乃）主题'; break;;
                              'Polylight（多光）') splash '正在安装 Polylight（多光）主题'; break;;
                              'Sekiro（只狼）') splash '正在安装 Sekiro（只狼）主题'; break;;
                              'Shodan（守望者）') splash '正在安装 Shodan（守望者）主题'; break;;
                              'Sleek（极简）') splash '正在安装 Sleek（极简）主题'; break;;
                              'Tela（特拉）') splash '正在安装 Tela（特拉）主题'; break;;
                              'Vimix') splash '正在安装 Vimix 主题'; break;;
                              'Virtualfuture（虚拟未来）') splash '正在安装 Virtualfuture（虚拟未来）主题'; break;;
                              'whitesur（白苏尔）') splash '正在安装 whitesur（白苏尔）主题'; break;;
                              'Yotsuba（四叶）') splash '正在安装 Yotsuba（四叶）主题'; break;;
                              'Quit') echo_info '用户选择退出'; exit 0;;
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
  echo_primary '设置 GRUB 默认项和菜单样式'
  # 设置 GRUB_DEFAULT
  echo_info "sed -i '/GRUB_DEFAULT=/d' /etc/default/grub"
  sed -i '/GRUB_DEFAULT=/d' /etc/default/grub
  echo_info "echo 'GRUB_DEFAULT=\"1\"' >> /etc/default/grub"
  echo 'GRUB_DEFAULT="1"' >> /etc/default/grub

  # 设置 GRUB_TIMEOUT_STYLE
  echo_info "sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub"
  sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub
  echo_info "echo 'GRUB_TIMEOUT_STYLE=\"hidden\"' >> /etc/default/grub"
  echo 'GRUB_TIMEOUT_STYLE="hidden"' >> /etc/default/grub

  # 设置 GRUB_TIMEOUT
  echo_info "sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub"
  sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub
  echo_info "echo 'GRUB_TIMEOUT=\"3\"' >> /etc/default/grub"
  echo 'GRUB_TIMEOUT="3"' >> /etc/default/grub

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
