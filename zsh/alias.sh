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


# ${0:A:h} means: take $0 (the script path) → make it absolute/canonical → strip the filename to get the directory.
source "${0:A:h}/alias/brew.sh"
source "${0:A:h}/alias/git.sh"
source "${0:A:h}/alias/numbers.sh"
source "${0:A:h}/alias/text.sh"
source "${0:A:h}/alias/bazel.sh"



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


alias cdtemp="cd $(mktemp -d)"



# prettier ls
unalias ls 2>/dev/null
ls() {
    eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions "$@"
}
