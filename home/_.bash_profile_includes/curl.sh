fileFromUrl(){
  echo `echo "$@" | sed 's/.*\(\/\)\([^\/]*$\)/\2/'`
}

curlo(){
  local url=$1
  local file="$(fileFromUrl $url)"
  echo "downloading $url > ./$file"
  echo $(curl $url -o ./$file)
}
