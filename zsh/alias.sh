# General
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export DOTFILES_DIR="$HOME/Personal/dotfiles"
export PATH=$PATH:$HOME/go/bin
export EDITOR="vim"
alias python=python3
alias vi=vim
if [[ "$(uname)" == "Linux" ]]; then
  alias cat=batcat
else
  alias cat=bat
fi
# set -o vi

# rust
alias rd="cargo run"
alias ch="cargo check"

# Package Manager
alias i="brew install"
alias u="brew upgrader"
alias q="brew search"

# git
alias gn="git --no-pager"
alias m="gco main"
alias gan="git commit --verbose --all --amend --no-edit"
alias glod="git --no-pager log -n 8 --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"



#generate numbers
gen() {
    n=$1
    for ((i=0; i<$2; i++)); do
        echo $n
        ((n*=2))
    done
}
#generate numbers and convert units
genu() {
  n=$1
  for ((i=0; i<$2; i++)); do
    if [[ $n -gt 60000 ]]; then
      printf "%.2fm\n" "$((n / 1000.0 / 60.0))"
    elif [[ $n -gt 1000 ]]; then
      printf "%.2fs\n" "$((n / 1000.0))"
    else
      echo "$n ms"
    fi
    ((n *= 2))
  done
}

# ts = text split
ts() {
    python3 -c "print(' '.join('$1'.split('_')), end='')" | pbcopy
}

# tj = text Join
tj() {
    python3 -c "print('_'.join('$*'.split(' ')), end='')"
}


# usage rtmux hostname usage name
rtmux() {
        case "$2" in
            "") autossh -M 0 $1 -t "if tmux -qu has; then tmux -qu attach; else EDITOR=vim tmux -qu new; fi";;
            *) autossh -M 0 $1 -t "if tmux -qu has -t $2; then tmux -qu attach -t $2; else EDITOR=vim tmux -qu new -s $2; fi";;
        esac
    }


# probably if installed using package manager
# if [[ "$(uname)" == "Linux" ]]; then
#     if [[ ! -e /usr/local/bin/fd ]]; then
#         ln -s $(which fdfind) /usr/local/bin/fd
#     fi
# fi


# alias r="go build -o bin && ./bin"


alias cdtemp="cd $(mktemp -d)"

# git stuff
alias absorb="GIT_SEQUENCE_EDITOR=: git absorb --and-rebase"
alias slabsorb="sl absorb --apply-changes"
alias mend="git commit --all --amend --no-edit && sparc 1"
alias land="arc stack --disable-rebase-check --nounit"
fixup() {
    COMMIT=$(git log HEAD ^origin/main --reverse --format="%H" | sed -n $1p) # get nth commit from a reversed git log
    git commit --all --fixup=$COMMIT
    GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash $COMMIT~1
}


alias gbc="git branch --show-current | tee >(tr -d '\n' | pbcopy)" # copy the current branch name to the clipboard (and still print it)
# git branch's parent
gbp() {
	git show-branch -a 2>/dev/null \
	| sed "s/].*//" \
	| grep "\*" \
	| grep -v "$(git rev-parse --abbrev-ref HEAD)" \
	| head -n1 \
	| sed "s/^.*\[//" \
	| tee >(tr -d '\n' | pbcopy)
}



# prettier ls
alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"


