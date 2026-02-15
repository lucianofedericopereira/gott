#!/bin/sh
# install.sh — deploy gott to your system
# Usage: sudo sh install.sh [PREFIX]
#
# Default PREFIX is /usr/local. The binary lands at PREFIX/bin/gott.

set -e

PREFIX="${1:-/usr/local}"
BIN="$PREFIX/bin"

if [ "$(id -u)" -ne 0 ] && [ "$PREFIX" = "/usr/local" ]; then
    echo "Note: installing to /usr/local requires root. Run: sudo sh install.sh"
    exit 1
fi

echo "Installing gott to $BIN ..."
mkdir -p "$BIN"
install -m 755 gott "$BIN/gott"
echo "Done. gott installed at $BIN/gott"
echo ""
echo "Remember to set your author identity:"
echo '  export GOT_AUTHOR="Your Name <you@example.com>"'
