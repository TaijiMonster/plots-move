# Plots Move Tool - Single Temporary Final Destination
Automate your plot transfer from temporary final folder to farming folder - support both local and remote.

***YOU MUST HAVE rclone, tmux/screen (optional) installed and a Discord Webhook***

## HOW TO USE?
1) `git clone https://github.com/TaijiMonster/plots-move.git`
2) `cd plots-move`
3) `cp remote.sh.default remote.sh`
4) Edit `nano remote.sh`, simple self explanatory notes in the file
5) Edit `nano discord.sh`, put in your own Discord webhook
6) `sudo chmod +x *.sh`
7) Create a new tmux/screen session [OPTIONAL]
8) `./upload1.sh`

Let me know if there's any issue.
