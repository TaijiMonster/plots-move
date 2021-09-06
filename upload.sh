#!/bin/bash

while [ true ]
do
        clear
        # read transfer folder
        source remote.sh

        # check disk space
        availSpace=$(df $TARGETd1 | awk 'NR==2 { print $4 }')
        availSpace2=$(df -h $TARGETd1 | awk 'NR==2 { print $4 }')
        availSpaceBackup=$(df -h $TARGET2d1 | awk 'NR==2 { print $4 }')
        if (( $availSpace < $reqSpace )); then
                outSpaced1=$(( $outSpaced1+1 ))
                if (( $outSpaced1 < 6 )); then # PRIMARY space out of space send notification for 5 times
                        echo "NOT ENOUGH PRIMARY SPACE" >&2
                        DISCORD="*** $MACHINE WARNING NOTIFICATION #$outSpaced1*** $TARGETd1 - PRIMARY RAN OUT OF SPACE !!! *** WARNING ***"
                        source discord.sh "$DISCORD"
                fi
        # second destination copy target
        do
                for FILE in $(ls $PLOT_PATHd1 -p | grep -v / | head -1)                
                do
                        # check if there's quit loop command
                        if (( QUITd1 == 0 )); then
                                echo -e "***$VERSION***\nDEST Folder ==> PRIMARY: $TARGETd1 BACKUP: $TARGET2d1\nUsing *BACKUP DESTINATION* $TARGET2d1 - CHANGE PRIMARY DESTINATION IMMEDIATELY !!!"
                                rclone move --ignore-checksum --transfers=1 --no-traverse --progress $PLOT_PATHd1$FILE $TARGET2d1
                                clear
                                break
                        else
                                echo "QUIT COMMAND INVOKED BY USER !!!"
                                exit 1
                        fi
                countd1=$(( $countd1+1 ))
                echo -e "***$VERSION***\nRUN#$countd1 No BACKUP job | SOURCE: $PLOT_PATHd1 | DEST: $TARGET2d1, wait 30 seconds | BACKUP Space Available: $availSpaceBackup"
                echo ""
                REFRESH=$(date -d "+30 seconds")
                echo "Next refresh at $REFRESH"
                sleep 30
                clear
                break
        done
        else
                for FILE in $(ls $PLOT_PATHd1 -p | grep -v / | head -1)                
                do
                    if (( $availSpace > $reqSpace )); then # additional check to avoid there's plot immediately after current transfer and destination ran out of space
                        outSpaced1=0
                        countd1=0
                        echo -e "***$VERSION***\nDEST Folder ==> PRIMARY: $TARGETd1 BACKUP: $TARGET2d1\n$availSpace2 - ENOUGH PRIMARY SPACE -> Moving file to $TARGETd1 from $PLOT_PATHd1"

                        # check if there's quit loop command
                        if (( QUITd1 == 0 )); then
                                rclone move --ignore-checksum --transfers=1 --no-traverse --progress $PLOT_PATHd1$FILE $TARGETd1
                                clear
                        else
                                echo "QUIT COMMAND INVOKED BY USER !!!"
                                exit 1
                        fi

                        # check space pre notification, if you do not add/change your backup's target destination, the notification will continue
                        if (( availSpace < ( reqSpace*5 ) )) && [ "$TARGETd1" = "$TARGET2d1" ]; then
                                echo "LESS THAN 5 PLOTS' PRIMARY SPACE AVAILABLE - $availSpace2" >&2
                                DISCORD2="*** $MACHINE PRE-WARNING *** $TARGETd1 LEFT LESS THAN 5 PLOTS' SPACE !!! *** PRE-WARNING ***"
                                source discord.sh "$DISCORD2"
                        fi
                        clear
                    fi
                done
                clear
                echo -e "***$VERSION***\nNo PRIMARY job | SOURCE: $PLOT_PATHd1 | DEST: $TARGETd1, wait 30 seconds | Space Available: $availSpace2 | BACKUP Space $TARGET2d1: $availSpaceBackup"
                echo ""
                REFRESH=$(date -d "+30 seconds")
                echo "Next refresh at $REFRESH"
                sleep 30
                clear
        fi
done