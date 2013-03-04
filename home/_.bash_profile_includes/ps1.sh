############################################

# Modified from emilis bash prompt script

# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1

#

# Modified for Mac OS X by

# @corndogcomputer

# Modified further by

# @jangosteve

###########################################

# From https://gist.github.com/31631
# TODO: Look into git completion commands like __git_ps1
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

# Idea from http://blog.ubrio.us/nix/best-bash-prompt/
# Modified with help from @bigeasy
function parse_last_status {
  RET=$?; [ $RET -eq 0 ] && echo -e "\033[01;36m" || echo -e "\033[01;31m"
}

function prompt_command {
  # Fill with minuses
  # (this is recalculated every time the prompt is shown in function prompt_command):

  # create a $fill of all screen width minus the time string and a space:
  let fillsize=${COLUMNS}-20
  fill=""
  while [ "$fillsize" -gt "0" ]
  do
    # Fill with hyphens
    fill="-$fill"
    let fillsize=${fillsize}-1
  done

  # If this is an xterm set the title to name of dir
  case "$TERM" in
    xterm*|rxvt*)
    bname=`basename "${PWD/$HOME/~}"`
    echo -ne "\033]0;${bname}\007"
    ;;
    *)
    ;;
  esac
}

reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
prompt_style=$reset_style
command_style=$reset_style'\[\033[1;29m\]' # bold black

PROMPT_COMMAND=prompt_command

export -f parse_git_branch
export -f parse_last_status
export CLICOLOR=1
export PS1="$status_style"'$fill \d \t\n'"\[\$(parse_last_status)\]\W \[\033[33m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "
export SUDO_PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[0m\]'

# Reset color for command output
# (this one is invoked every time before a command is executed)
trap 'echo -ne "\033[00m"' DEBUG
