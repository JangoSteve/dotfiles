# Output the argument string to the terminal with a bunch of minuses as a divider
# E.g.:
#   $ note "Starting work"
#   $ ---------- Starting work ----------
#   $
note(){
  DEFAULT_COLOR="\033[0;0m"
  ORANGE="\033[0;33m"
  RED="\033[0;31m"
  YELLOW="\033[1;33m"
  GREEN="\033[0;32m"
  LIGHT_PURPLE="\033[1;34m"
  WHITE="\033[1;37m"
  PURPLE="\033[1;35m"
  CYAN="\033[1;36m"
  BLUE="\033[0;34m"
  LIGHT_GRAY="\033[0;37m"
  DARK_GRAY="\033[1;30m"
  GRAY="\033[0;90m"
  BLACK="\033[0;30m"

  local mystr=$1
  # Create a $fill of all screen width minus the length of the argument string divided by 2:
  let mystrlen=${COLUMNS}-${#mystr}-2
  let fillsize=$((${mystrlen}/2))
  fill=""
  while [ "$fillsize" -gt "0" ]
  do
    # Fill with hyphens
    fill="-$fill"
    let fillsize=${fillsize}-1
  done

  # Add one more minus to the end to fill prompt if $mystrlen above was an odd number
  out="$YELLOW$fill $mystr $fill"
  [ $((${mystrlen}%2)) -ne 0 ] && out="$out-"

  echo -e "$out"
}
