# General
export DOTFILES_DIR="/Users/aakef/Personal/dotfiles"
export PATH=$PATH:/Users/aakef/go/bin/
export EDITOR="vim"
alias python=python3
alias vi=vim
set -o vi

# Package Manager
alias i="brew install"
alias u="brew upgrade"
alias q="brew search"

# git
alias m="gco main"
alias gan="git commit --verbose --all --amend --no-edit"
alias glod="git --no-pager log -n 5 --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"

# arc
alias s="gco main && arc tidy && git pull && arc cascade -hc main && arc sync --dependencies main && gco -"
alias af="arc flow"
alias at="arc tidy"
alias ad="arc diff --add-all --noautoland --apply-patches --amend-autofixes --allow-untracked --message"
alias add="arc diff --add-all --noautoland  --apply-patches --amend-autofixes --allow-untracked"
alias ac="arc cascade -hc main"
alias al="arc lint --apply-patches"

aff() {
    branchName=$(tj "$*")
    arc flow "$branchName"
    echo -n "$*" | pbcopy
}


# bazel
alias t="bazel test ...:all"
alias b="bazel build ...:all"
alias gg="gazelle ."


# ts = text split
ts() {
    python3 -c "print(' '.join('$1'.split('_')), end='')" | pbcopy
}

# tj = text Join
tj() {
    python3 -c "print('_'.join('$*'.split(' ')), end='')"
}
