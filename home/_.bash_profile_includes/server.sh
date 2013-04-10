alias apache_restart="/usr/sbin/apachectl restart"
alias pow_restart="touch tmp/restart.txt"

showport(){
  local port=$1
  lsof -i tcp:$port
}
