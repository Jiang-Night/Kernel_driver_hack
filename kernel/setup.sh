#!/bin/sh
set -eux

GKI_ROOT=$(pwd)

echo "[+] GKI_ROOT: $GKI_ROOT"

if test -d "$GKI_ROOT/common/drivers"; then
	DRIVER_DIR="$GKI_ROOT/common/drivers"
elif test -d "$GKI_ROOT/drivers"; then
	DRIVER_DIR="$GKI_ROOT/drivers"
else
	echo '[ERROR] "drivers/" directory is not found.'
	echo '[+] You should modify this script by yourself.'
	exit 127
fi

test -d "$GKI_ROOT/Kernel_driver_hack" || git clone https://github.com/Jiang-Night/Kernel_driver_hack
cd "$GKI_ROOT/Kernel_driver_hack"
git stash
if [ "$(git status | grep -Po 'v\d+(\.\d+)*' | head -n1)" ]; then
	git checkout main
fi
git pull
if [ -z "${1-}" ]; then
    git checkout "$(git describe --abbrev=0 --tags)"
else
    git checkout "$1"
fi
cd "$GKI_ROOT"

echo "[+] GKI_ROOT: $GKI_ROOT"
echo "[+] Copy Kernel_driver_hack driver to $DRIVER_DIR"

cd "$DRIVER_DIR"
if test -d "$GKI_ROOT/common/drivers"; then
	if test -d "$GKI_ROOT/common/drivers/khack"; then
		echo "[+] Exiting folder exists"
	else
		ln -sf "../Kernel_driver_hack/kernel" "khack"
	fi
elif test -d "$GKI_ROOT/drivers"; then
	if test -d "$GKI_ROOT/drivers/khack"; then
		echo "[+] Exiting folder exists"
	else
		ln -sf "../Kernel_driver_hack/kernel" "khack"
	fi
fi
cd "$GKI_ROOT"

echo '[+] Add driver to Makefile'

DRIVER_MAKEFILE=$DRIVER_DIR/Makefile
DRIVER_KCONFIG=$DRIVER_DIR/Kconfig
grep -q "khack" "$DRIVER_MAKEFILE" || printf "obj-\$(CONFIG_KERNEL_HACK) += khack/\n" >> "$DRIVER_MAKEFILE"
grep -q "khack" "$DRIVER_KCONFIG" || sed -i "/endmenu/i\\source \"drivers/khack/Kconfig\"" "$DRIVER_KCONFIG"

echo '[+] Done.'