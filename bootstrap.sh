#!/usr/bin/env bash

# All done with the system python3
pip3_os="/usr/bin/python3 -m pip"

# Install xcode command line tools
xcode-select -p &>/dev/null || \
  (echo "Installing Command Line Tools" && xcode-select --install)

# upgrade pip to latest version
echo "Upgrading pip"
/usr/bin/python3 -m pip install --user --upgrade pip

pkg_list=$($pip3_os list)
# Install ansible related packages if needed
echo "Now installing required packages"
for pkg in ansible ansible-lint paramiko
do
  [[ "$pkg_list" =~ ${pkg}[[:space:]] ]] || \
    ( echo "Installing ${pkg}" && $pip3_os install --user $pkg)
done

echo "Installed all required packpages"

exit 0
