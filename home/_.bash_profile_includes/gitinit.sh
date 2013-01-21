git init
echo "web: bundle exec rails server" > Procfile.sample
cp Procfile.sample Procfile
echo "port: 5000" > .foreman
echo "ENV: development" > .env
echo ".foreman\n.env\nProcfile" > .gitignore
