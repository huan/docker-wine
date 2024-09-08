#!/bin/sh
set -euxo pipefail
# NOTE: Can only run on aarch64 (since box64 can only run on aarch64)
# box64 runs wine-amd64, box86 runs wine-i386.

box86=""
box64=""
if [ "$TARGETPLATFORM" == "linux/arm64" ]; then
   box86="box86"
   box64="box64"
fi

# Install wrapper script for box86 & box64
cat << EOF > /usr/local/bin/wine
#!/bin/sh
WINEPREFIX=/home/user/.wine WINEARCH=win32 $box86 /home/user/wine/bin/wine \$@
EOF
cat << EOF > /usr/local/bin/wine64
#!/bin/sh
WINEPREFIX=/home/user/.wine64 WINEARCH=win64 $box64 /home/user/wine/bin/wine64 \$@
EOF
cat << EOF > /usr/local/bin/wineserver
#!/bin/sh
WINEPREFIX=/home/user/.wine64 WINEARCH=win64 $box64 /home/user/wine/bin/wineserver \$@
EOF
cat << EOF > /usr/local/bin/winetricks64
WINE=wine64 WINEPREFIX=/home/user/.wine64
wine64 $box64 /home/user/wine/bin/winetricks \$@
EOF

ln -s /home/user/wine/bin/wineboot /usr/local/bin/wineboot
ln -s /home/user/wine/bin/winecfg /usr/local/bin/winecfg
chmod +x /usr/local/bin/wine /usr/local/bin/wine64 /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver /usr/local/bin/winetricks64
