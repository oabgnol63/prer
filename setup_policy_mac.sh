#!/bin/bash
set -e
echo "Setting macOS scroll bars to Always"
defaults write -g AppleShowScrollBars -string Always
echo -n "AppleShowScrollBars="
defaults read -g AppleShowScrollBars
