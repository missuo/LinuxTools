#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#================================================================
#	System Required: CentOS 6/7/8,Debian 8/9/10,Ubuntu 16/18/20
#	Description: Some simple commands for Linux
#	Version: 1.0
#	Author: Vincent Young
# 	Telegram: https://t.me/missuo
#	Github: https://github.com/missuo/LinuxTools
#	Latest Update: June 31, 2021
#=================================================================

# Define Color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

os_info(){
    if [[ -f /etc/redhat-release ]]; then
		release="Centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="Debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="Ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="Centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="Debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="Ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="Centos"
	fi
}
os_info

system_info() {
    source /etc/os-release
    SysInfo_OS_Ver_major="$(echo ${VERSION_ID} | cut -d. -f1)"
    SysInfo_OS_CodeName="${VERSION_CODENAME}"
    SysInfo_OS_Name_lowercase="${ID}"
    SysInfo_OS_Name_Full="${PRETTY_NAME}"
    SysInfo_RelatedOS="${ID_LIKE}"
    SysInfo_Kernel="$(uname -r)"
    SysInfo_Kernel_Ver_major="$(uname -r | awk -F . '{print $1}')"
    SysInfo_Kernel_Ver_minor="$(uname -r | awk -F . '{print $2}')"
    SysInfo_Arch="$(uname -m)"
    SysInfo_Virt="$(systemd-detect-virt)"
}
system_info

show_system_info() {
    echo -e "
System Information
---------------------------------------------------
  Operating System: ${SysInfo_OS_Name_Full}
      Linux Kernel: ${SysInfo_Kernel}
      Architecture: ${SysInfo_Arch}
    Virtualization: ${SysInfo_Virt}
---------------------------------------------------
"
}
show_system_info

# Make Sure Run in Root
[[ $EUID != 0 ]] && echo -e "[${red}Error${plain}] This script must be run as root!" && exit 1

# Menu Function
menu(){
    clear
    echo & echo -e "Linux Tools by Vincent Young
Feedback: https://github.com/missuo/LinuxTools/issues
---------------------Mode List---------------------
0. Exit
1. Install BBR Kernel(@ylx2016)
2. Install Cloudflare Warp(@missuo)
3. Install Cloudflare Warp(@P3TERX)
4. Install Shadowsocks
5. Inatall MTProto(No TLS)
6. Install MTProto(TLS)
7. Install BestTrace
8. Install aaPanel
9. LemonBench
10. Bench
11. Netflix Check(@sjlleo)
12. Change Hostname
13. Media Check
----------------------------------------------------
"
    read -p "Please enter the number of the mode you want: " num
    case $num in
        0) exit 0
        ;;
        1) install_bbr
        ;;
        2) install_cloudflare
        ;;
        3) install_cloudflare_p3terx
        ;;
        4) install_shadowsocks
        ;;
        5) install_mtproto_nontls
        ;;
        6) install_mtproto_tls
        ;;
        7) install_besttrace
        ;;
        8) install_aaPanel
        ;;
        9) install_lemonbench
        ;;
        10) install_bench
        ;;
        11) install_netflix
        ;;
        12) change_hostname
        ;;
        13) media_check
        ;;
        *) echo -e "[${red}Error${plain}] Please enter the correct number!"
        esac
    }

install_bbr() {
    wget -N --no-check-certificate "https://github.000060000.xyz/tcpx.sh" && chmod +x tcpx.sh && ./tcpx.sh
}

install_cloudflare() {
    wget -O warp.sh https://cdn.jsdelivr.net/gh/missuo/CloudflareWarp/warp.sh && bash warp.sh
}

install_cloudflare-p3terx(){
    bash <(curl -fsSL git.io/warp.sh) 
}

install_shadowsocks(){
    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ss-go.sh && chmod +x ss-go.sh && bash ss-go.sh
}

install_mtproto_nontls() {
    wget -N --no-check-certificate https://raw.githubusercontent.com/iiiiiii1/doubi/master/mtproxy_go.sh && bash mtproxy_go.sh
}

install_mtproto_tls() {
    mkdir /home/mtproxy && cd /home/mtproxy
    curl -s -o mtproxy.sh https://raw.githubusercontent.com/ellermister/mtproxy/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh
}

install_besttrace() {
    wget uone.one/besttrace && chmod +x besttrace && mv besttrace /usr/bin/
}

install_aaPanel() {
    if [ $release = "Centos" ]
	then
		yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh forum
	elif [ $release = "Debian" ]
	then
		wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && bash install.sh forum
	elif [ $release = "Ubuntu" ]
	then
		wget -O install.sh http://www.aapanel.com/script/install-ubuntu_6.0_en.sh && sudo bash install.sh forum
	else
		echo -e "[${red}Error${plain}] Your system is not supported!" && exit 1
		exit 1
	fi
}

install_lemonbench() {
    curl -fsSL http://ilemonra.in/LemonBenchIntl | bash -s fast
}

install_bench() {
    wget -qO- bench.sh | bash
}

install_netflix() {
    wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
}

change_hostname(){
    read -p "Please enter the hostname you want: " hostname
    hostnamectl set-hostname $hostname
}

media_check() {
    bash <(curl -sSL "https://git.io/JswGm")
}