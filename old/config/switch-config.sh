#!/usr/bin/env bash

sudo rm -rf /etc/nixos/*

sudo cp -r ~/Templates/config/* /etc/nixos/

echo "Nixos config copy in /etc/nixos/"

sudo nixos-rebuild switch
