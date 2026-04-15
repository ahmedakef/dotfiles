alias gn="git --no-pager"
alias m="gco main"
alias gan="git commit --verbose --all --amend --no-edit"
alias glod="git --no-pager log -n 8 --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"

# by eimantas

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
