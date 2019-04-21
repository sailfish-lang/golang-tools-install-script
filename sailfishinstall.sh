#!/bin/bash
set -e

VERSION="0.2.0"

print_help() {
    echo "Usage: bash sailfishinstall.sh OPTIONS"
    echo -e "\nOPTIONS:"
    echo -e "  --install\t\tInstall version $VERSION of Sailfish"
    echo -e "  --remove\tRemove currently installed version"
}

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    # assume Zsh
    shell_profile="zshrc"
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    # assume Bash
    shell_profile="bashrc"
fi

if [ "$1" == "--install" ]; then
    DFILE="$VERSION.tar.gz"
elif [ "$1" == "--remove" ]; then
    rm -rf "$HOME/.sailfish/"
    rm -rf "$HOME/sailfish/"
    sed -i '/# Sailfish/d' "$HOME/.${shell_profile}"
     sed -i '/alias sailfishc/d' "$HOME/.${shell_profile}"
    echo "Sailfish removed."
    exit 0
elif [ "$1" == "--help" ]; then
    print_help
    exit 0
else
    print_help
    exit 1
fi

if [ -d "$HOME/.sailfish" ] || [ -d "$HOME/sailfish" ]; then
    echo "The 'sailfish' or '.sailfish' directories already exist. Exiting."
    exit 1
fi

echo "Downloading $DFILE ..."
wget https://github.com/sailfish-lang/sailfishc/archive/$DFILE -O /tmp/sailfish.tar.gz


if [ $? -ne 0 ]; then
    echo "Download failed! Exiting."
    exit 1
fi

echo "Extracting File..."
tar -C "$HOME" -xzf /tmp/sailfish.tar.gz

echo "Compiling file..."
cd "$HOME/sailfishc-$VERSION"
make

echo "Setting up environment"
mv "$HOME/sailfishc-$VERSION" "$HOME/.sailfish"
touch "$HOME/.${shell_profile}"
{
    echo '# Sailfish'
    echo 'alias sailfishc=$HOME/.sailfish/sailfishc'
} >> "$HOME/.${shell_profile}"

echo -e "\nSailfish $VERSION was installed.\nMake sure to relogin into your shell or run:"
echo -e "\n\tsource $HOME/.${shell_profile}\n\nto update your environment variables."
echo "Tip: Opening a new terminal window usually just works. :)"
rm -f /tmp/sailfish.tar.gz
