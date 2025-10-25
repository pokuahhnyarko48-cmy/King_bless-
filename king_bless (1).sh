#!/bin/bash

# king_bless - Powerful Password Cracking Multi Tool (SKELETON)
# Author: YourName
# Use for authorized security testing only!

# Colors
G="\e[32m"; R="\e[31m"; Y="\e[33m"; N="\e[0m"

function banner() {
  echo -e "${G}
 __          __  _               ____  _                 
 \ \        / / | |             |  _ \| |                
  \ \  /\  / /__| |__  _ __ ___ | |_) | | __ _ _   _ ___ 
   \ \/  \/ / _ \ '_ \| '__/ _ \|  _ <| |/ _\` | | | / __|
    \  /\  /  __/ |_) | | | (_) | |_) | | (_| | |_| \__ \\
     \/  \/ \___|_.__/|_|  \___/|____/|_|\__,_|\__, |___/
                                               __/ |    
                                              |___/     
${N}"
}

function menu() {
  clear
  banner
  echo -e "${Y}
  1. Crack Hash (MD5/SHA1/SHA256)
  2. Brute Force PIN
  3. Dictionary Attack
  4. Crack SSH/FTP Password
  5. Update Wordlists
  6. About
  99. Exit
${N}"
  read -p "king_bless> " opt
  case $opt in
    1) crack_hash ;;
    2) brute_pin ;;
    3) dict_attack ;;
    4) network_crack ;;
    5) update_wordlists ;;
    6) about ;;
    99) exit ;;
    *) echo -e "${R}Invalid option${N}"; sleep 1; menu ;;
  esac
}

function crack_hash() {
  echo -e "${Y}Enter hash:${N}"
  read hash
  echo -e "${Y}Hash type? (md5/sha1/sha256):${N}"
  read type
  echo -e "${Y}Path to wordlist:${N}"
  read wordlist
  for pass in $(cat $wordlist); do
    case $type in
      md5) cmp=$(echo -n $pass | md5sum | awk '{print $1}') ;;
      sha1) cmp=$(echo -n $pass | sha1sum | awk '{print $1}') ;;
      sha256) cmp=$(echo -n $pass | sha256sum | awk '{print $1}') ;;
      *) echo "Unknown type"; menu ;;
    esac
    if [ "$cmp" == "$hash" ]; then
      echo -e "${G}Found: $pass${N}"
      break
    fi
  done
  read -p "Enter to return"; menu
}

function brute_pin() {
  echo -e "${Y}Enter 4/6 digit (e.g., 4):${N}"
  read digits
  echo -e "${Y}Command to test PIN (e.g., adb ...):${N}"
  read cmd
  max=$((10**digits-1))
  for i in $(seq -w 0 $max); do
    echo "Trying $i"
    eval "$cmd $i" # e.g., adb shell input ...
  done
  read -p "Enter to return"; menu
}

function dict_attack() {
  echo -e "${Y}Target file/service? (e.g., zip file, http):${N}"
  read target
  echo -e "${Y}Path to wordlist:${N}"
  read wordlist
  # Implement logic here (ex: unzip -P $pass $target)
  echo -e "${Y}Not implemented in skeleton.${N}"
  read -p "Enter to return"; menu
}

function network_crack() {
  echo -e "${Y}Service (ssh/ftp):${N}"
  read service
  echo -e "${Y}Target ip:port:${N}"
  read target
  echo -e "${Y}Username:${N}"
  read user
  echo -e "${Y}Wordlist:${N}"
  read wordlist
  # Example with hydra
  hydra -l $user -P $wordlist $target $service
  read -p "Enter to return"; menu
}

function update_wordlists() {
  echo -e "${Y}Downloading top 10k wordlist...${N}"
  wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt -O wordlists/top10k.txt
  echo -e "${G}Downloaded to wordlists/top10k.txt${N}"
  read -p "Enter to return"; menu
}

function about() {
  echo "king_bless - Password Cracking Multi Tool"
  echo "For authorized security testing only!"
  read -p "Enter to return"; menu
}

menu