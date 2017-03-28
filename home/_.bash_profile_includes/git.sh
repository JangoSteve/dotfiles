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
alias gfe="git fetch"
alias gf="git fetch" # slightly shorter version
alias grs="git remote -v"
alias grl="git remote -v" # I forget it's "show" and not "list"
alias grh="git reset HEAD"
alias gdi="git diff"
alias gitsum='git log --pretty=format:"* %s" --author `git config user.email`'
alias gsu="gitsum"
alias gtr="git log --graph --pretty=oneline --abbrev-commit"
