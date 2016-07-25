#!/bin/bash

# Specify how many seconds it takes to go from current volume to zero
SECONDS_TO_DROP_10_DB=30

if [ -z "$1" ];then
  echo 'Please supply minutes to wait before suspend'
  exit 1
fi

# Sleep for specified number of minutes
MINUTES_TO_SLEEP=$1
SECONDS_TO_SLEEP=`echo "$1 * 60" | bc`

echo "Music will continue for $1 lovely minutes"
sleep $SECONDS_TO_SLEEP

current_volume()
{
  echo `amixer get 'Master' | grep 'Mono: Playback' | awk '{ print $3 }'`
}

START_VOLUME=`current_volume`
RAW_VALUE_FOR_10_DB=13
INTERVAL=`echo "scale=4; $SECONDS_TO_DROP_10_DB/$RAW_VALUE_FOR_10_DB" | bc`

# amixer stores volume as a 7-bit integer (128 values)
# So one integer is the smallest difference you can apply

echo 'Reducing volume'

# Volume on my laptop is undetectable when set less than 40
until [ `current_volume` -le 40 ]; do
  amixer set -q 'Master' 1-
  sleep $INTERVAL
done

echo 'Sweet Dreams'

sudo pm-suspend
