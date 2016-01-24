#!/usr/bin/env bash

# generate gpg on mac

echo "Installing gpg"
brew install gpg

echo "GPG version: "
gpg --version

echo "Generate key..."
gpg --key-gen

echo "list all gpg keys: "
gpg --list-keys

echo "You can upload pub key use this command: "
echo  "gpg --keyserver hkp://pool.sks-keyservers.net --send-keys [pubkey]"