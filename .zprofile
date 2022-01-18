alias k=kubectl
alias tf=terraform
alias stree='open -a SourceTree'

gitdefaultbranch() {
     git remote show origin | grep "HEAD branch" | sed 's/.*: //'
}
gitbranch() {
     git fetch origin && git checkout --no-track -b $1 origin/$(gitdefaultbranch)
}
gitpush() {
     git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}
gitpr() {
     if [[ "$(git remote get-url origin)" == *"gitlab.com"* ]]; then
         REPO_NAME="$(git remote get-url origin | sed 's|^git@gitlab.com:||' | sed 's|.git$||')"
         open "https://gitlab.com/${REPO_NAME}/-/merge_requests/new?merge_request%5Bsource_branch%5D=$(git branch --show-current)"
     else
         git browse -- compare/$(git branch --show-current)'?quick_pull=1'
     fi
}
pushpr() {
     gitpush && gitpr
}

gitco() {
     git stash && git checkout $1 && git pull; git stash pop
}

gitreversecherrypickme() {
     git checkout $1 && git reset --hard $2 && git cherry-pick origin/$1
}

# larrrrrge history via https://unix.stackexchange.com/a/273863/255152
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

