alias t="bazel test ...:all"
alias b="bazel build ...:all"
alias gg="gazelle ."


# from Eimantas
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
