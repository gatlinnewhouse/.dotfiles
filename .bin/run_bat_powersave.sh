#!/bin/sh

if [[ "$(cat /sys/class/power_supply/AC/online)" == "0" ]]
then
        echo "On battery power..."
        # Disable Ethernet 
        #   Refer to ifconfig for your ethernet interface name
        #
        ip link set enp0s25 down
        # Run TLP in battery mode
        #
        tlp bat
        # Set backlight to 15%
        intelbacklight -set 732.3
        # Tune powertop 
        #   Run powertop --calibrate first
        #   https://wiki.archlinux.org/index.php/powertop
        #
        powertop --auto-tune
        # Set CPU to powersave
        cpupower frequency-set -g powersave
        # Disable CPU Core 4-11 (4/6 phys cores) on battery mode
        #   This applies for an Intel i7-8750H (6 cores, 12 threads)
        #   For my Intel i7-4750HQ (4 cores, 8 threads), so I turn off
        #   four threads to save power
        #
        #echo 0 | sudo tee /sys/devices/system/cpu/cpu11/online
        #echo 0 | sudo tee /sys/devices/system/cpu/cpu10/online
        #echo 0 | sudo tee /sys/devices/system/cpu/cpu9/online
        #echo 0 | sudo tee /sys/devices/system/cpu/cpu8/online
        echo 0 | tee /sys/devices/system/cpu/cpu7/online
        echo 0 | tee /sys/devices/system/cpu/cpu6/online
        echo 0 | tee /sys/devices/system/cpu/cpu5/online
        echo 0 | tee /sys/devices/system/cpu/cpu4/online
else
        echo "On AC power..."
        # Run TLP in AC mode
        #
        tlp ac
        # Set backlight to 100%
        intelbacklight -set 4882
        # Enable CPU Core 4-11 (4/6 phys cores) on AC mode
        #   This applies for an Intel i7-8750H (6 cores, 12 threads)
        #   For my Intel i7-4750HQ (4 cores, 8 threads), so I turn on
        #   four threads for performance
        #
        #echo 1 | sudo tee /sys/devices/system/cpu/cpu11/online
        #echo 1 | sudo tee /sys/devices/system/cpu/cpu10/online
        #echo 1 | sudo tee /sys/devices/system/cpu/cpu9/online
        #echo 1 | sudo tee /sys/devices/system/cpu/cpu8/online
        echo 1 | tee /sys/devices/system/cpu/cpu7/online
        echo 1 | tee /sys/devices/system/cpu/cpu6/online
        echo 1 | tee /sys/devices/system/cpu/cpu5/online
        echo 1 | tee /sys/devices/system/cpu/cpu4/online
        # Cpu set to performance
        cpupower frequency-set -g performance
fi
