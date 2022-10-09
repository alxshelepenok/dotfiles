#!/bin/bash

if [ "$1" == "-e" ];
then
  nordvpn set killswitch disabled
  nordvpn connect germany
  nordvpn set killswitch enabled
  nordvpn settings
elif [ "$1" == "-d" ];
then
  nordvpn set killswitch disabled
  nordvpn disconnect
  nordvpn set killswitch enabled
  nordvpn settings
fi
