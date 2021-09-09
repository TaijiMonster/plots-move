#!/bin/bash
i="0"

while [ $i -lt 4 ]
do
        clear
        # read transfer folder
        source remote.sh

        # check disk space
        availSpace=$(df $TARGETd2 | awk 'NR==2 { print $4 }')
        availSpace2=$(df -h $TARGETd2 | awk 'NR==2 { print $4 }')
        availSpaceBackup=$(df $TARGET2d2 | awk 'NR==2 { print $4 }')
        availSpaceBackup2=$(df -h $TARGET2d2 | awk 'NR==2 { print $4 }')
        filesNumberd1=$(find $PLOT_PATHd1. -type f -ls | wc -l)
        filesNumberd2=$(find $PLOT_PATHd2. -type f -ls | wc -l)
        filesNumber=$(( $filesNumberd1 + $filesNumberd2 ))
        if (( availSpace < ( $reqSpace * $filesNumber ) )) || (( $availSpace < $reqSpace )); then
                outSpaced2=$(( $outSpaced2+1 ))
                if (( $outSpaced2 < 6 )); then #PRIMARY space out of space send notification for 5 times
                        echo "NOT ENOUGH SPACE" >&2
                        DISCORD="*** $MACHINE (Job 2) WARNING NOTIFICATION #$outSpaced2*** $TARGETd1 - PRIMARY RAN OUT OF SPACE !!! *** WARNING ***"
                        source discord.sh "$DISCORD"
                fi
        # second destination copy target
        while [ $i -lt 4 ]
        do
                for FILE in $PLOT_PATHd2*.plot;
                do
                        # check if there's quit loop command
                        if (( QUITd2 == 0 )); then
                                echo -e "***$VERSION***\nUsing *BACKUP DESTINATION* $TARGET2d2 - CHANGE PRIMARY DESTINATION IMMEDIATELY !!!"
                                rclone move --ignore-checksum --transfers=1 --no-traverse --progress --include "*.plot" $PLOT_PATHd2 $TARGET2d2
                                clear
                                break
                        else
                                echo "QUIT COMMAND INVOKED BY USER !!!"
                                exit 1
                        fi
                done
                countd2=$(( $countd2+1 ))
                echo -e "***$VERSION***\nRUN#$countd2 No BACKUP job | SOURCE: $PLOT_PATHd2 | DEST: $TARGET2d2, wait 30 seconds | BACKUP Space Available: $availSpaceBackup2"
                echo ""
                REFRESH=$(date -d "+30 seconds")
                echo "Next refresh at $REFRESH"
                sleep 30
                clear
                break
        done
        else
                for FILE in $PLOT_PATHd2*.plot;
                do
                    if (( availSpace > ( $reqSpace * $filesNumber ) )) || (( $availSpace > $reqSpace )); then # additional check to avoid there's plot immediately after current transfer and destination ran out of space
                        outSpaced2=0
                        countd2=0
                        echo -e "***$VERSION***\n$availSpace2 - ENOUGH PRIMARY SPACE -> Moving file to $TARGETd2 from $PLOT_PATHd1"

                        # check if there's quit loop command
                        if (( QUITd2 == 0 )); then
                                rclone move --ignore-checksum --transfers=1 --no-traverse --progress --include "*.plot" $PLOT_PATHd2 $TARGETd2
                                clear
                        else
                                echo "QUIT COMMAND INVOKED BY USER !!!"
                                exit 1
                        fi

                        # check space pre notification
                        if (( availSpaceBackup < ( reqSpace*5 ) )) && [ "$TARGETd2" = "$TARGET2d2" ]; then
                                echo "LESS THAN 5 PLOTS' PRIMARY SPACE AVAILABLE - $availSpace2" >&2
                                DISCORD2="*** $MACHINE (Job 2) PRE-WARNING *** $TARGETd1 LEFT LESS THAN 5 PLOTS' SPACE !!! *** PRE-WARNING ***"
                                source discord.sh "$DISCORD2"
                        fi
                        clear
                    fi
                done
                clear
                echo -e "***$VERSION***\nNo PRIMARY job | SOURCE: $PLOT_PATHd2 | DEST: $TARGETd2, wait 30 seconds | Space Available: $availSpace2 | BACKUP Space $TARGET2d2: $availSpaceBackup2"
                echo ""
                REFRESH=$(date -d "+30 seconds")
                echo "Next refresh at $REFRESH"
                sleep 30
                clear
        fi
done
