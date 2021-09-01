#!/usr/bin/env bash
VERSION="TaijiMonster Transfer 1.00"

# Your machine name
MACHINE="plotter-1"

# For dual cpu machine with 2 temporary final folders
PLOT_PATHd1="/mnt/nvme/final1/"
PLOT_PATHd2="/mnt/nvme/final2/"

# For local/remote transfer, recommended max 2 transfer per drive/destination but best is 1 transfer per drive/destination
TARGETd1="/mnt/disk-s9-9/"
TARGET2d1="/mnt/disk-s9-9/"
TARGETd2="/mnt/disk-s9-9/"
TARGET2d2="/mnt/disk-s9-9/"

# Choose your plot's size
#reqSpace=106400000 #k32
#reqSpace=11500000 #k29
reqSpace=51600000 #k31

# As rclone runs pretty fast, CTRL-C wont help and causes many partial transfer, if you want to stop the transfer you can set this to 1
QUITd1=0 #For Job 1
QUITd2=0 #For Job 2


echo "DEST Folder ==> (1) PRIMARY: $TARGETd1 BACKUP: $TARGET2d1 | (2) PRIMARY: $TARGETd2 BACKUP: $TARGET2d2"