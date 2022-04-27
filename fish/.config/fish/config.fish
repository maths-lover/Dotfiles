#--------------------------------------#
#       Maths Lover's fish config      #
#--------------------------------------#

if test -d $HOME/bin
	fish_add_path -a $HOME/bin
end

if test -d $HOME/.local/bin
	fish_add_path -a $HOME/.local/bin
end

if test -d $HOME/dev/go/bin
	fish_add_path -a $HOME/dev/go/bin
end

function fish_hybrid_key_bindings --description "Vi-style bindings that inherit emacs-style bindings in all modes"
	for mode in default insert visual
		fish_default_key_bindings -M $mode
	end
	fish_vi_key_bindings --no-erase
end

if status is-interactive
	# Commands to run in interactive sessions can go here
	set fish_greeting
	set EDITOR "nvim"
	set VISUAL "neovide --multigrid"
	starship init fish | source
	set -g fish_key_bindings fish_hybrid_key_bindings
end
