#!/bin/zsh

# Set HISTFILE to tell in what file to save cmdline history
HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history

# Just in case if the parent of $HISTFILE doesn't exist, create it
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

# Max number of entries to keep in history file
SAVEHIST=$((1000 * 1000))

# Max number of history to keep in memory
HISTSIZE=$((1.2 * SAVEHIST))

# Use modern file-locking mechanisms, for better safety & performance
setopt HIST_FCNTL_LOCK

# Keep only most recent copy of each duplicate entry in history
setopt HIST_IGNORE_ALL_DUPS

# Auto sync history between concurrent sessions
setopt SHARE_HISTORY
