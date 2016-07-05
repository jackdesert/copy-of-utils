#! /bin/sh

# Copy this executable to /etc/pm/sleep.d (symbolic links are not executed)

#    sudo cp ~/.utils/on_resume.sh /etc/pm/sleep.d && sudo chmod +x /etc/pm/sleep.d/on_resume.sh

# My intent in running this script is to set keyboard attributes when resuming

# Source: http://askubuntu.com/questions/92218/how-to-execute-a-command-after-resume-from-suspend


#sleep 3 && \

xset r rate 240 60
setxkbmap -option "caps:escape"
echo `date` >> /tmp/rate
