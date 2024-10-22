# On macos it appears to need the `function` part
function werklife() {
  # Life Logger
  # Use this to log events in your life so you can remember when they happened
  # If you want to include any quotes (single or double) in your phrase,
  # escape them.
  local LOGFILE=~/.secret-targetsmart/werklife.log
  local current_date_and_time=$(date +'%Y%m%d_%H%M')
  # Note the $* means "all the arguments passed in"
  echo "$current_date_and_time $*" >> $LOGFILE
}

# Alias for grepping the life logs. (mem is short for memory) (Make sure you put something to grep)
alias mem='cat ~/.secret-targetsmart/werklife.log | grep -i'
# Show all (no grep)
alias mema='cat ~/.secret-targetsmart/werklife.log'
