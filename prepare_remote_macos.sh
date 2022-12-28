#!/usr/bin/env bash

# This command requires that the remote terminal emulator has full disk access
# So grant full disk access to Terminal, iTerm, Warp or wahtever you are using
# prior running this script!
[[ "$(sudo systemsetup -getremotelogin)" =~ Off ]] \
  && sudo systemsetup -setremotelogin On \
  || echo "Remote login is already enabled"

echo "Checking Xcode CLI tools"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
if ! xcode-select -p &> /dev/null; then
  echo "Xcode CLI tools not found. Installing them..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    tail -n 1 | sed 's/^[^C]* //')
  softwareupdate -i "$PROD" --verbose;
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
else
  echo "Xcode CLI tools OK"
fi
