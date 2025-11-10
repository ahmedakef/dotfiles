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

# sparc
alias sparc="sparc sync"

# bazel
alias t="bazel test ...:all"
alias b="bazel build ...:all"
alias gg="gazelle ."


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
            "") autossh -M 0 $1 -t "if tmux -qu has; then tmux -qu attach; else EDITOR=emacs tmux -qu new; fi";;
            *) autossh -M 0 $1 -t "if tmux -qu has -t $2; then tmux -qu attach -t $2; else EDITOR=emacs tmux -qu new -s $2; fi";;
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


# bazel
alias bb="bazel build '...'"
# executes bazel test '...' and tries to capture the interesting parts of the output and print them again at the end in red
bt() {
    testOutput="$(bazel test '...' --norun_validations --color=yes 2>&1 | tee /dev/stderr)" # tee to stderr to print the output as it's happening but also capture it in a variable

    highlightedPart=""
    highlighting="false"

    while read -r line; do
        if [[ $line == *"Use --verbose_failures to see the command lines of failed build steps"* ]]; then
            break
        fi

        if [[ $highlighting == "true" ]]; then
            highlightedPart+="$line\n"
        fi

        if [[ $line == *"Use --sandbox_debug to see verbose messages from the sandbox and retain the sandbox build root for debugging"* ]]; then
            highlightedPart="" # if we see the same line again, we need to reset the substring
            highlighting="true"
        fi
    done <<< "$testOutput"

    if [ ! -z "$highlightedPart" -a "$highlightedPart" != " " ]; then # not empty and not space
        RED='\033[0;31m'
        NC='\033[0m' # No Color
        printf "\n\n${RED}${highlightedPart}${NC}"
    fi

    # if bt received "--skip-fix" argument, skip fixing the errors to not get into an infinite loop, probably not the best bash way, but it works ay...
    if [[ $1 == "--skip-fix" ]]; then
        return
    fi


    if [[ $highlightedPart == *"missing strict dependencies"* ]]; then
        printf "\nMissing dependencies detected... Running gazelle...\n"
        gazelle
        printf "\nRe-executing bazel test...\n"
        bt --skip-fix
    fi
}

alias bg="gazelle"
# gazelle on changed directories
bgi() {
    modifiedDirsStr="$(git status --porcelain | cut -f 3 -d ' ' | tr '\n' '\0' | xargs -0 -n1 dirname | uniq | tr '\n' ' ')"
    modifiedDirs=($modifiedDirsStr)
    printf "detected modified dirs: %s\n" "${modifiedDirs[@]}"
    gazelle "${modifiedDirs[*]}"
}

alias bt_debug="bazel test --cache_test_results=no --sandbox_debug '...' --test_env=GO_TEST_WRAP_TESTV=1"
alias btr1="bt_debug --@io_bazel_rules_go//go/config:race"
alias btr10="btr1 --runs_per_test=10"
alias btr100="btr1 --runs_per_test=100"
alias btr1000="btr1 --runs_per_test=1000"
alias btr="btr1 && btr10 && btr100 && btr1000"
alias bta="btra_base --test_output=all"
alias btra="btra_base --@io_bazel_rules_go//go/config:race --runs_per_test=10 --test_output=all"


# prettier ls
alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"
