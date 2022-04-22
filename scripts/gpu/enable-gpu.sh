#!/bin/sh

mv /etc/modprobe.d/disable-nvidia.conf /etc/modprobe.d/disable-nvidia.conf.disable

echo -n 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
sleep 1

echo -n on > /sys/bus/pci/devices/0000\:00\:01.0/power/control
sleep 1

echo -n 1 > /sys/bus/pci/rescan

modprobe nvidia 
