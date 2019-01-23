#!/bin/sh

# homebrew
echo "Checking homebrew packages..."
brew update > /dev/null;
new_packages=$(brew outdated --quiet)
num_packages=$(echo $new_packages | wc -w)

if [ $num_packages -gt 0 ]; then
	echo "New package updates available:"
    for package in $new_packages; do
	echo "   * $package";
    done
else
    echo "No new package updates available."
fi

if [ $num_packages -gt 0 ]; then
	echo "Do you wish to install these updates?"
	select yn in "Yes" "No"; do
	    case $yn in
		Yes ) echo "Installing homebrew packages..."; brew upgrade; break;;
		No ) break;;
	    esac
	done
fi

echo "Cleaning up old homebrew packages..."
brew cleanup > /dev/null;

# macOS
echo "Checking macOS updates..."
software_update=$(softwareupdate -l | tail +4)

if [ "$software_update" != "No new software available." ]; then
	echo "Do you wish to install these updates?"
	select yn in "Yes" "No"; do
	    case $yn in
		Yes ) echo "Downloading and installing macOS packages..."; softwareupdate -iaR | tail +5; break;;
		No ) exit;;
	    esac
	done
fi
