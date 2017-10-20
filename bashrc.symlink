# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source ~/.sensible.bash

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

set -o vi
# Still allow alt+. to insert last argument.
bind -m vi-command ".":insert-last-argument

alias r='fc -s'

export TERM=screen-256color

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

export VISUAL=vim
export EDITOR=vim

# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

fh() {
  cat $HOME/.history/* | grep -v -e '#.*' | fzf +s --tac | writecmd
}

if [[ "$(uname -a)" =~ "Darwin" && -f ~/.bashrc.osx ]]; then
  . ~/.bashrc.osx
fi

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

export FZF_DEFAULT_COMMAND='ag --hidden  -g ""'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/private/tmp/google-cloud-sdk/path.bash.inc' ]; then source '/private/tmp/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/private/tmp/google-cloud-sdk/completion.bash.inc' ]; then source '/private/tmp/google-cloud-sdk/completion.bash.inc'; fi
