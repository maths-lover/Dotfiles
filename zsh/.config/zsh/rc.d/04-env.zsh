#!/bin/zsh

#########################
# Environment Variables #
#########################

# Default editor
export EDITOR=nvim
export VISUAL=neovide

# -U ensures only unique entries exist
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath # -T creates tied pair

# For citrix-workspace
export ICAROOT=$HOME/dev/seagate/tools/citrix-workspace

# thefuck
eval $(thefuck --alias)

# For GO
export GOPATH=$HOME/dev/go
export GOBIN=$HOME/dev/go/bin

# For nodejs nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm for $HOME in each $path entry.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# $PATH and $path (and also $FPATH and $fpath, etc.) are "tied" to each other.
# Modifying one will also modify the other.
# Note that each value in an array is expanded separately. Thus, we can use ~

path=(
  $path
  $HOME/dev/flutter/bin(N) #(N): NULL if directory doesn't exist
  $HOME/dev/androidTools/android-studio/bin(N)
  $HOME/dev/androidTools/Sdk/cmdline-tools/latest/bin(N)
  $HOME/dev/androidTools/Sdk/platform-tools(N)
  $GOBIN(N)
  $HOME/.cargo/bin(N)
)

fpath=(
  $ZDOTDIR/functions
  $fpath
  ~/.local/bin
)
