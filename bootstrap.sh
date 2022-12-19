#!/usr/bin/env bash

# All done with the system python3
pip3_os="/usr/bin/python3 -m pip"

echo "Checking Xcode CLI tools"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
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

echo ""

# upgrade pip to latest version
echo "Upgrading pip"
$pip3_os install --user --upgrade pip

pkg_list=$($pip3_os list)
# Install ansible related packages if needed
echo "Now installing required packages"
for pkg in ansible ansible-lint molecule paramiko yamllint; do
  [[ "$pkg_list" =~ ${pkg}[[:space:]] ]] || \
    ( echo "Installing ${pkg}" && $pip3_os install --user $pkg)
done

if [ "$SHELL" = /bin/zsh ]; then
  shell_config=~/.zshrc
else
  shell_config=~/.bashrc
fi

if [ ! -f "$shell_config" ]; then
  touch "$shell_config"
fi

if ! grep "Library/Python" ~/.zshrc &>/dev/null; then
  echo "export PATH=~/Library/Python/3.9/bin/:$PATH" >> "$shell_config"
fi

echo "Installed all required packpages"

if ! command -v ansible &>/dev/null; then
  echo "Now run: source $shell_config"
fi

exit 0
