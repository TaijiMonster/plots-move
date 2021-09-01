# Plots Move Tool
Automate your plot transfer from temporary final folder to farming folder - support both local and remote.

***YOU MUST HAVE rclone, tmux/screen (optional) installed and a Discord Webhook***

## HOW TO USE?
1) `git clone https://github.com/TaijiMonster/plots-move.git`
2) `cd plots-move`
3) `cp remote.sh.default remote.sh`
4) Edit `nano remote.sh`, simple self explanatory notes in the file
5) Edit `nano discord.sh`, put in your own Discord webhook
6) `sudo chmod +x *.sh`
7) Create a tmux/screeen session with 2 panes
8) `./upload1.sh` # On first pane
9) `./upload2.sh` # On second pane

Let me know if there's any issue.
