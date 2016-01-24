#!/usr/bin/env bash

###################################
####  Developer Initial On Mac ####
###################################

# Xcode
echo "Installing Xcode..."
xcode-select --install

# Home Brew
echo "Installing Home Brew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
