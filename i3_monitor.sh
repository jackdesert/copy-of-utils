#!/bin/bash
# Source: https://faq.i3wm.org/question/5312/how-to-toggle-onoff-external-and-internal-monitors.1.html
# run `xrandr` to see connected displays


# Set these two variables based on the displays listed when you run `xrandr`
INTERNAL_OUTPUT="LVDS"
EXTERNAL_OUTPUT="DisplayPort-2"
EXTERNAL_ROTATION="--rotate left"



FILE=/tmp/monitor_mode.dat

# if we don't have a file, start at zero
if [ ! -f "$FILE" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="external"
        COMMAND="xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto $EXTERNAL_ROTATION"
elif [ $monitor_mode = "external" ]; then
        monitor_mode="internal"
        COMMAND="xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off"
elif [ $monitor_mode = "internal" ]; then
        monitor_mode="clones"
        COMMAND="xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --auto $EXTERNAL_ROTATION --same-as $INTERNAL_OUTPUT"
else
        monitor_mode="all"
        COMMAND="xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --auto $EXTERNAL_ROTATION --above $INTERNAL_OUTPUT"
fi
echo "${monitor_mode}" > $FILE
echo writing "$monitor_mode" to $FILE
echo running command: $COMMAND
$COMMAND


# Test
# xrandr --output 'LVDS' --off --output 'DisplayPort-2' --auto --rotate 'left'
