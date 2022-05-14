#!/usr/bin/env bash

# This command requires that the remote terminal emulator has full disk access
[[ "$(sudo systemsetup -getremotelogin)" =~ Off ]] && sudo systemsetup -setremotelogin On
