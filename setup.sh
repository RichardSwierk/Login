#!/bin/bash
#Group: Hive

echo ''
echo '   ░█─░█ ▀█▀ ░█──░█ ░█▀▀▀'
echo '   ░█▀▀█ ░█─ ─░█░█─ ░█▀▀▀' 
echo '   ░█─░█ ▄█▄ ──▀▄▀─ ░█▄▄▄' 
echo '            ____'
echo '           /    \'
echo '      ____/      \____'
echo '     /    \      /    \'
echo '    /      \____/      \'
echo '    \      /    \      /'
echo '     \____/      \____/'
echo '     /    \      /    \'
echo '    /      \____/      \'
echo '    \      /    \      /'
echo '     \____/      \____/'
echo '          \      /'
echo '           \____/'
echo ''
sleep 2

if ls | grep login.sh

sudo apt-get update
sudo apt-get install hydra pnscan grep --yes
chmod +x login.sh



