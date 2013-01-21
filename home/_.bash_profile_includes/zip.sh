zipe(){

  if [ -z "$2" ]
  then
    local source=$1
    local dest="zip-encrypted-$(date +%s).zip"
  else
    local dest=$1
    local source=$2
  fi

  echo "Zipping encrypted file to $dest"
  echo -e "$(zip -er "$dest" "$source" -x "*.DS_Store")"
}
