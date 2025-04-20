#!/usr/bin/env bash

source ./env.sh

echo -e "${YELLOW}This script will setup a gpg keyring in $GNUPGHOME and a gopass fs store in $PASSWORD_STORE_DIR${RESET}"
read -p "Press any key..."

echo -e "${YELLOW}Create default key${RESET}"
mkdir -m 700 gpg
echo -e "8\nq\n3072\n0\ny\ndefault\ndefault@example.com\n\no\n" | script -q -c 'gpg --expert --full-generate' /dev/null

read -p "Press any key..."

echo -e "${YELLOW}Setup gopass store${RESET}"
gopass setup --storage fs

echo -e "${YELLOW}Create secret in gopass${RESET}"
gopass generate secret 24

read -p "Press any key..."

echo -e "${YELLOW}Create recipient1 without encryption${RESET}"
echo -e "8\ne\nq\n3072\n0\ny\nRecipient1\nrecipient1@example.com\n\no\n" | script -q -c 'gpg --expert --full-generate' /dev/null

read -p "Press any key..."

echo -e "${YELLOW}Create recipient2 with encryption${RESET}"
echo -e "8\nq\n3072\n0\ny\nRecipient2\nrecipient2@example.com\n\no\n" | script -q -c 'gpg --expert --full-generate' /dev/null

read -p "Press any key..."
