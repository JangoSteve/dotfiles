alias rs="rails s"
alias rc="rails c"
alias ber="bundle exec rspec"
alias test="ruby -Itest"
alias bet="bundle exec rake test"

start(){
  local foreman=false
  if [ -f ./Procfile.dev ];
  then
    echo "Procfile.dev detected"
    local command="foreman start -f Procfile.dev -p 3000"
    foreman=true
  elif [ -f ./Procfile ];
  then
    echo "Procfile detected"
    local command="foreman start -p 3000"
    foreman=true
  elif [ -f ./config/boot.rb ]
  then
    echo "No Procfiles detected, falling back to rails"
    local command="rails server"
  elif [ -f ./config.ru ]
  then
    echo "Rack app detected"
    local command="rackup config.ru"
  elif [ -f ./package.json ]
  then
    echo "NPM app detected"
    local command="npm start"
  else
    echo "Could not detect app type, do nothing"
  fi
  if [[ -f Gemfile && ! $foreman ]];
  then
    command="bundle exec $command"
  fi
  echo "> $command"
  $command
}
