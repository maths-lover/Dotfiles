#!/bin/zsh

##################
# Plugin Manager #
##################

local znap=$gitdir/zsh-snap/znap.zsh

# Auto install znap if it isn't already installed
if ! [[ -r $znap ]]; then
  mkdir -p $gitdir
  git -C $gitdir clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git
fi

. $znap
