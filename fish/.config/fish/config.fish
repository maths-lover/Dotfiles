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

if test -d $HOME/.cargo/bin
	fish_add_path -a $HOME/.cargo/bin
end

if test -d $HOME/dev/flutter/bin
	fish_add_path -a $HOME/dev/flutter/bin
end

if test -d $HOME/dev/android/cmdline-tools/tools/bin
	fish_add_path -a $HOME/dev/android/cmdline-tools/tools/bin
end

if test -d $HOME/dev/android/cmdline-tools/bin
	fish_add_path -a $HOME/dev/android/cmdline-tools/bin
end

if test -d $HOME/dev/android
	fish_add_path -a $HOME/dev/android
end

if test -d $HOME/dev/android/platform-tools
	fish_add_path -a $HOME/dev/android/platform-tools
end

if test -d $HOME/dev/android/emulator
	fish_add_path -a $HOME/dev/android/emulator
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
	set GPG_TTY (tty)
	set ANDROID_SDK "$HOME/dev/android"
end
