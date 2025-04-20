This is a simple gopass setup to troubleshoot an issue in gopass
https://github.com/gopasspw/gopass/issues/2640

The setup.sh script will create a gpg keyring in the local directory with a default RSA key a recipient1 RSA key which is missing the encryption attribute and a recipient2 RSA key with the encryption attribute. It will also establish a gopass fs store in the local directory.

The run_test.sh script will first do some cleanup allowing it to be run multiple times. It will then create a gopass secret and add recipient1 and recipient2 to the password store and then run gopass fsck --decrypt to re-encrypt the store.
