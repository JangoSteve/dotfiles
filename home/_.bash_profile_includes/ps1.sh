############################################

# Modified from emilis bash prompt script

# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1

#

# Modified for Mac OS X by

# @corndogcomputer

# Modified further by

# @jangosteve

###########################################
# Fill with minuses

# (this is recalculated every time the prompt is shown in function prompt_command):

fill="--- "


reset_style='\[\033[00m\]'

status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color

prompt_style=$reset_style

command_style=$reset_style'\[\033[1;29m\]' # bold black

# Prompt variable:

# From https://gist.github.com/31631
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
export -f parse_git_branch
export CLICOLOR=1
export PS1="$status_style"'$fill \d \t\n'"\[\033[36m\]\W \[\033[33m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "
export SUDO_PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[0m\]'
#PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u@\h:\w\$'"$command_style "


# Reset color for command output

# (this one is invoked every time before a command is executed):

trap 'echo -ne "\033[00m"' DEBUG


function prompt_command {


# create a $fill of all screen width minus the time string and a space:

let fillsize=${COLUMNS}-20

fill=""

while [ "$fillsize" -gt "0" ]

do

  fill="-${fill}" # fill with underscores to work on

  let fillsize=${fillsize}-1

done


# If this is an xterm set the title to user@host:dir

case "$TERM" in

  xterm*|rxvt*)

  bname=`basename "${PWD/$HOME/~}"`

  echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"

  ;;

  *)

  ;;

esac


}

PROMPT_COMMAND=prompt_command
