#!/bin/zsh

() {
  local gitdir="$ZDOTDIR/zsh_tools"

  local files=
  for file in $ZDOTDIR/rc.d/<->-*.zsh(n); do
    . $file
  done
} "$@"

