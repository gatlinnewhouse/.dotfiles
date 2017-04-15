#!/bin/sh
printf "\n"
printf "Cleaning GCC cache... \n"
printf "============================== \n"
printf "\n"
ccache -c
printf "\n"
printf "============================== \n"
printf "\n"
printf "\n"
printf "Cleaning browser profiles... \n"
printf "============================== \n"
printf "\n"
browser-vacuum
printf "\n"
printf "============================== \n"
printf "\n"
printf "\n"
printf "Clean the pacaur package cache \n"
printf "============================== \n"
printf "\n"
pacaur -Sc
printf "\n"
printf "============================== \n"
