#!/usr/bin/env bash

## Install Homebrew for Mac OS X
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Install Python3
brew install python3

## Install Python's Seaborn library - required for Seaborn.jl wrapper for use later
pip3 install seaborn

## Install Julia for Mac OS X
brew cask install julia
