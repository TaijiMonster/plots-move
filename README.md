# Taiji Monster Plot Transfer 2.0
## Plots Move Tool - Single Temporary Final Destination
Automate your plot transfer from temporary final folder to farming folder - support both local and remote. 
NO MORE troubles on stop/start plotting tool or keep changing config.yaml, NO MORE troubles on staring at farming drive space availability as you will be notified via Discord; set your plotting tool to infinite, whenever PRIMARY destination is full, it will transfer to BACKUP destination, you only need to edit remote.sh to add/change target destination.

***YOU MUST HAVE rclone, tmux/screen (optional) installed and a Discord Webhook***

## HOW TO USE?
***PLEASE DO A CLEAN INSTALLATION IF YOU ARE UPGRADING FROM V1.0 - SEE BELOW***
1) `git clone https://github.com/TaijiMonster/plots-move.git`
2) `cd plots-move`
3) `cp remote.sh.default remote.sh`
4) `cp discord.sh.default discord.sh`
5) Edit `nano remote.sh`, simple self explanatory notes in the file
6) Edit `nano discordALERT.sh`, put in your own Discord webhook
7) `sudo chmod +x *.sh`
8) Create a new tmux/screen session [OPTIONAL]
9) Start the transfer `./upload.sh`

## Clean Installation from V1.0
1) `rm -rf ~/plots-move`
2) `git clone https://github.com/TaijiMonster/plots-move.git`
3) `cd plots-move`
4) `cp remote.sh.default remote.sh`
5) `cp discord.sh.default discord.sh`
6) Edit `nano remote.sh`, simple self explanatory notes in the file
7) Edit `nano discordALERT.sh`, put in your own Discord webhook
8) `sudo chmod +x *.sh`
9) Create a new tmux/screen session [OPTIONAL]
10) Start the transfer `./upload.sh`

## Things to Note
1) You DO NOT need to setup/create a rclone configuration
2) Moving of transfer of plot will move to BACKUP destination when PRIMARY destination ran out of space or is less than required K size plot space you chosen in remote.sh
3) Only one plot will be transfer/move at anytime/per rclone session
4) Discord notification will not stop if you do not set a BACKUP destination folder
5) If PRIMARY destination folder ran out of space, Discord will send you 5 notifications, make sure you have a BACKUP destination entered in remote.sh
6) Please DO NOT enable your destination folder in config.yaml until it is fully filled with plots else it will affect your farming read time, YOU MIGHT BE LOSING REWARDS!

Let me know if there's any issue.
