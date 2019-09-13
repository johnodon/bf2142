#!/bin/bash

echo "---BF2 Check---"
cd /serverfiles
if [ ! -f "/serverfiles/bf2142-linuxded-1.10.112.0-installer.rar" ]; then
    echo "---BF2142 source not found, downloading!---"
    wget -nc -q --show-progress --progress=bar:force:noscroll ftp://ftp.bf-games.net/server-files/bf2142/bf2142-linuxded-1.10.112.0-installer.rar
fi
if [ ! -f "/serverfiles/bf2142-linuxded-1.10.112.0-installer.sh" ]; then
    echo "---BF2142 installer not found, extracting!---"
    unrar e -r /serverfiles/bf2142-linuxded-1.10.112.0-installer.rar
fi
if [ ! -f "/serverfiles/bf2142/start.sh" ]; then
    echo "---BF2142 server files not found, installing!---"
    chmod +x /opt/scripts
    /opt/scripts/extract
fi

echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find /serverfiles/bf2142 -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd /serverfiles/bf2142
rm -rf /serverfiles/bf2142/start.sh
cp /opt/scripts/start.sh /serverfiles/bf2142/start.sh
chmod +x /serverfiles/bf2142/start.sh
./start.sh
