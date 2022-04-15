#!/bin/bash

readonly GRAY='\e[1;30m'
readonly GREEN='\e[1;32m'
readonly YELLOW='\e[1;33m'
readonly CYAN='\e[1;36m'
readonly NC='\e[0m'


function echo_json_upd() {
	echo -e "$1"
	[[ -t 3 ]] && echo -e "{\"message\":\"$(echo "$1" | sed 's/\\e\[[0-9;]*m//g')\",\"retcode\":$2}" >&3
}


echo -e "\n===================================================\
         \n   ${GRAY}██████╗ ██╗   ██╗██████╗ ${NC}███╗   ███╗███╗   ██╗  \
         \n   ${GRAY}██╔══██╗██║   ██║██╔══██╗${NC}████╗ ████║████╗  ██║  \
         \n   ${GRAY}██║  ██║██║   ██║██████╔╝${NC}██╔████╔██║██╔██╗ ██║  \
         \n   ${GRAY}██║  ██║██║   ██║██╔═══╝ ${NC}██║╚██╔╝██║██║╚██╗██║  \
         \n   ${GRAY}██████╔╝╚██████╔╝██║     ${NC}██║ ╚═╝ ██║██║ ╚████║  \
         \n   ${GRAY}╚═════╝  ╚═════╝ ╚═╝     ${NC}╚═╝     ╚═╝╚═╝  ╚═══╝  \
         \n                                ╗ made by ${GREEN}sys-od${NC} ╔\
         \n           Source: ${CYAN}https://github.com/sys-od/mns${NC}\
         \n   FAQs: ${CYAN}https://github.com/sys-od/mns/wiki/FAQs${NC}\
         \n  BTC Donations: ${YELLOW}3F6J19DmD5jowwwQbE9zxXoguGPVR716a7${NC}\
         \n===================================================\
         \n                                                   "

mns_update=$(curl -s https://raw.githubusercontent.com/sys-od/mns/master/mns.sh)

if [[ -f /usr/bin/mns && ! $(diff -q <(echo "$mns_update") /usr/bin/mns) ]]; then
	echo_json_upd "${GREEN}mns${NC} is already updated to the last version" 0
else
	echo -e "Checking needed dependencies..."
	if [[ ! $(command -v lsof) ]]; then
		echo -e "Installing ${CYAN}lsof${NC}..."
		sudo apt-get install lsof
	fi
	if [[ ! $(command -v curl) ]]; then
		echo -e "Installing ${CYAN}curl${NC}..."
		sudo apt-get install curl
	fi

	if [[ ! -d ~/.mns ]]; then
		mkdir ~/.mns
	fi
	touch ~/.mns/mns.conf

	update=$([[ -f /usr/bin/mns ]] && echo "1" || echo "0")

	echo "$mns_update" > /usr/bin/mns
	chmod +x /usr/bin/mns

	if [[ $update == "1" ]]; then
		echo_json_upd "${GREEN}mns${NC} updated to the last version, pretty fast, right?" 1
	else
		echo_json_upd "${GREEN}mns${NC} installed, pretty fast, right?" 2
	fi
fi

echo ""
