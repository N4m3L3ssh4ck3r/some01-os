#!/usr/bin/env bash
## 2023 - some01
## This script installs dependencies used by some01.py
##
##
gitinstall=1 ## by default we will install this
pipinstall=1 ## By default we will install this
printf "\n[i] Welcome to some01! (2022 @some01)\n"
if [ $EUID -ne 0 ]
then
    printf "[!] Please run this script as root. You are EUID: ${EUID}\n"
    exit 1
else
    if [[ $(which pip|wc -l) == "1" ]]
    then
        printf "[i] Python PIP already installed.\n"
        pipinstall=0
    fi
    if [[ $(which git|wc -l) == "1" ]]
    then
        printf "[i] Git already installed.\n"
        gitinstall=0
    fi
    printf "[i] This script installs the following dependencies used by some01:\n"
    if [[ $pipinstall -eq 1 ]]
    then
        printf "  -- python3-pip\n"
    fi
    if [[ $gitinstall -eq 1 ]]
    then
        printf "  -- git\n\n"
    fi
    printf "  -- Python3 pip modules\n\n"
    printf "[?] Shall I continue? [y/n] "
    read ans
    if [[ "$ans" == "y" ]]
    then
        if [ $gitinstall -eq 1 ] || [ $pipinstall -eq 1 ]
        then
            apt update
            if [[ "$gitinstall" -eq 1 ]]
            then
                apt install git -y
            fi
            if [[ "$pipinstall" -eq 1 ]]
            then
                apt install python3-pip -y
            fi

        fi
        python3 -m pip install --upgrade pip
        python3 -m pip install -r requirements.txt

        mkdir -p /etc/some01/apps_repo
        cp files/apps_repo/some01_apps.json /etc/some01/apps_repo
        cp files/apps_repo/some01_apps.json /etc/some01/apps_repo/some01_apps_backup.json ## Make a backup

        printf "\n[i] All done! Now run 'python3 some01.py'\n"
    else
        printf "[i] Thanks for choosing some01. Maybe another time? \n"
        exit 1
    fi
fi
# Test comment A
