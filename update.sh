#!/bin/sh
# Update Homebrew and macOS
# Forked from https://github.com/imwally/scripts/blob/master/whatsnew

# Homebrew
echo "Checking homebrew packages...\n"
brew update > /dev/null;
new_packages=$(brew outdated --quiet)
num_packages=$(echo $new_packages | wc -w)

if [ $num_packages -gt 0 ]; then
	echo "New package updates available:"
    for package in $new_packages; do
	echo "   * $package";
    done
	echo "\n"
else
    echo "No new package updates available.\n"
fi

if [ $num_packages -gt 0 ]; then
	echo "Do you wish to install these updates?"
	select yn in "Yes" "No"; do
	    case $yn in
		Yes ) echo "\nInstalling homebrew packages..."; brew upgrade; break;;
		No ) break;;
	    esac
	done
fi

echo "Cleaning up old homebrew packages...\n"
brew cleanup > /dev/null;

# Update Mac App Store apps
# Done via https://github.com/mas-cli/mas
echo "Upgrading macOS App Store apps...\n"
mas_upgrade=$(mas upgrade | grep Everything)

if [ "$mas_upgrade" != "Everything is up-to-date" ]; then
	echo "Upgrading App Store apps...\n"
else
	echo "No App Store updates available.\n"
fi

# macOS
echo "Checking macOS updates...\n"
mac_update=$(softwareupdate -l 2>&1 | head -1)

if [ "$mac_update" != "No new software available.\n" ]; then
	echo "Updates found."
	echo "Do you wish to install these updates? This will restart your Mac."
	select yn in "Yes" "No"; do
	    case $yn in
		Yes ) echo "Downloading and installing macOS packages..."; softwareupdate -iaR | tail +5; break;;
		No ) exit;;
	    esac
	done
else
	echo "No macOS updates available."
fi
