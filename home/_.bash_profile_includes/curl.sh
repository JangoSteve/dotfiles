# TODO: Look into replacing this with
# * dirname
# * basename
# * curl -O

fileFromUrl(){
  echo `echo "$@" | sed 's/.*\(\/\)\([^\/]*$\)/\2/'`
}

curlo(){
  local url=$1
  local file="$(fileFromUrl $url)"

  if [ -z "$2" ]
    then
      local dest="./"
    else
      local dest="$2"
  fi

  echo "downloading $url > $dest$file"
  echo $(curl -L $url -o $dest$file)
}
