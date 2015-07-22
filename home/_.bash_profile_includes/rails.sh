alias rs="rails s"
alias rc="rails c"
alias ber="bundle exec rspec"
alias test="ruby -Itest"
alias bet="bundle exec rake test"
rake() {
    if [[ $@ == "db:migrate" ]]; then
        command rake db:migrate && say -vz "migration complete"
    else
        command rake "$@"
    fi
}
