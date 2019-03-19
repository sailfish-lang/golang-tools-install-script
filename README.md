# sailfish-lang-install-script

Bash script to automate Sailfish language tools single user installation (Linux) or even removal.
Latest filename for download at the time of this writting was for version 0.1.0 of Sailfish. Feel free to change the variables on the beggining to match whatever version you need.

Tested with:

* Ubuntu 18.04 (3/19/2019)

## Installation

Download with wget or clone the repository

```shell
wget https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh
```

## Installation examples

To install:
```shell
bash sailfishinstall.sh --install
```

## Uninstall

```shell
bash sailfishinstall.sh --remove
```

## Notes

The script will create a `.sailfish` folder in your home directory, adding the needed variables for easy compilation.

`$HOME/.sailfish folder is your where Sailfish will be installed to.`

## Test

The following should return a help message if all was installed correctly:
`sailfishc`