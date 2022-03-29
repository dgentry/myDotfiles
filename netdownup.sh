#!/bin/bash
ifconfig eno2
sudo ifconfig eno2 down
ifconfig eno2
sleep 1000
ifconfig eno2
sudo ifconfig eno2 up
sleep 1
ifconfig eno2
