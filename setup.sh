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

sudo apt-get update
sudo apt-get install hydra pnscan grep wget bzip2 --yes
wget downloads.skullsecurity.org/passwords/rockyou.txt.bz2
bzip2 -d rockyou.txt.bz2
chmod +x login.sh


