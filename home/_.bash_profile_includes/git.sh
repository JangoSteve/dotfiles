alias gco="git checkout"
__git_complete gco _git_checkout
#complete -o default -o nospace -F _git_checkout gco
alias gst="git status"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gpr="git pull --rebase"
alias gpl="git pull"
alias gpu="git push"
__git_complete gpu _git_push
#complete -o default -o nospace -F _git_push gpu
alias gri="git rebase -i"
alias gre="git rebase"
alias gad="git add"
alias gcl="git clone"
alias gme="git merge"
__git_complete gme _git_checkout
alias glo="git log"
alias gbl="git branch -l"
alias gbla="git branch -a"
alias gbw='git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias gfe="git fetch"
alias gf="git fetch" # slightly shorter version
alias grs="git remote -v"
alias grl="git remote -v" # I forget it's "show" and not "list"
alias grh="git reset HEAD"
alias gdi="git diff --word-diff"
alias gitsum='git log --pretty=format:"* %s" --author `git config user.email`' #myself
alias gitover="git log --all --oneline --no-merges" # everyone, aka git "overview"
alias gittoday="git log --since=00:00:00 --all --no-merges --oneline --author `git config user.email`"
alias gsu="gitsum"
alias gtr="git log --graph --pretty=oneline --abbrev-commit"
alias gitgraph="git log --graph --all --decorate --stat --date=iso"
alias gsl="git shortlog -sn"
alias gitchange="git log --oneline --no-merges `git describe --abbrev=0 --tags`..HEAD"
alias gitupstream=`git rev-parse --abbrev-ref --symbolic-full-name @{u}`
alias gitupcoming="git fetch \$gitupstream && git log --oneline --no-merges HEAD..\$gitupstream"
alias gitlocal="git fetch \$gitupstream && git log --oneline --no-merges \$gitupstream..HEAD"
