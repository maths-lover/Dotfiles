#/bin/zsh

###############
# Main prompt #
###############

# znap eval starship 'starship init zsh --print-full-init'
# znap prompt
# znap source romkatv/powerlevel10k


setopt TRANSIENT_RPROMPT

# If we're not on an SSH connection, then remove the outer margin of the right
# side of the prompt.
[[ -v SSH_CONNECTION ]] ||
  ZLE_RPROMPT_INDENT=0
