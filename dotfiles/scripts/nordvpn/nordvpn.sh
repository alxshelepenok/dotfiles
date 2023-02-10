#!/bin/bash

if [ "$1" == "-e" ];
then
  nordvpn connect germany
elif [ "$1" == "-d" ];
then
  nordvpn disconnect
fi

nordvpn set autoconnect enabled germany
nordvpn set killswitch enabled
nordvpn settings
