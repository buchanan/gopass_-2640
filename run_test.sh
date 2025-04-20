#!/usr/bin/env bash

source ./env.sh

echo -e "${YELLOW}Cleaning up from previous runs${RESET}"
rm secrets-checksum.txt
echo "y"|script -q -c 'gopass recipients rm recipient1@example.com' /dev/null
echo "y"|script -q -c 'gopass recipients rm recipient2@example.com' /dev/null
read -p "Press any key..."
clear

echo -e "${YELLOW}Show keys in keyring${RESET}"
gpg --list-keys
read -p "Press any key..."

echo -e "\n\n${YELLOW}Show gopass recipients${RESET}"
gopass recipients
read -p "Press any key..."

echo -e "\n\n${YELLOW}Check secret status${RESET}"
gpg -d store/secret.gpg
read -p "Press any key..."

echo -e "\n\n${YELLOW}Adding recipient1 key missing encrypt flag${RESET}"
echo "y"|script -q -c 'gopass recipients add recipient1@example.com' /dev/null

echo -e "\n\n${YELLOW}Show gopass recipients${RESET}"
gopass recipients

echo -e "\n\n${YELLOW}Adding recipient2 key with encrypt flag${RESET}"
echo "y"|script -q -c 'gopass recipients add recipient2@example.com' /dev/null

echo -e "\n\n${YELLOW}Show gopass recipients${RESET}"
gopass recipients
read -p "Press any key..."

echo -e "\n\n${YELLOW}Checking keys the secret is encrypted with\n - Secret should be encrypted for default and recipient2${RESET}"
gpg -d store/secret.gpg
read -p "Press any key..."

echo -e "\n\n${YELLOW}Generate file hash prior to fsck${RESET}"
sha256sum store/*.gpg|tee secrets-checksum.txt
read -p "Press any key..."

echo -e "\n\n${YELLOW}Running gopass fsck --decrypt${RESET}"
gopass fsck --decrypt
read -p "Press any key..."

echo -e "\n\n${YELLOW}Verify file was changed by fsck${RESET}"
sha256sum -c secrets-checksum.txt
if [[ $? != 0 ]]; then
	echo -e "${YELLOW}Failed checksum shows the file was re-encrypted${RESET}"
fi
read -p "Press any key..."

echo -e "\n\n${YELLOW}Checking keys the secret is encrypted with${RESET}"
gpg -d store/secret.gpg
