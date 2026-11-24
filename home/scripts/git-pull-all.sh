#!/usr/bin/env bash
# Pull every git repository below the current directory.
# On a merge/rebase conflict: print a warning and abort the pull for that repo.

set -u

RED=$'\e[31m'; YELLOW=$'\e[33m'; GREEN=$'\e[32m'; RESET=$'\e[0m'

warn() { echo "${2:-$RED}WARNING: $1${RESET}" >&2; }

# Print every repo directory (parent of a .git dir or file), NUL-separated
find_repos() {
    find . -name .git -prune -print0 | sort -z |
        while IFS= read -r -d '' gitpath; do
            printf '%s\0' "$(dirname "$gitpath")"
        done
}

# True if git left a merge/rebase in progress
merge_in_progress()  { git -C "$1" rev-parse -q --verify MERGE_HEAD >/dev/null; }
rebase_in_progress() {
    local gitdir
    gitdir=$(git -C "$1" rev-parse --absolute-git-dir)
    [ -d "$gitdir/rebase-merge" ] || [ -d "$gitdir/rebase-apply" ]
}

# Pull one repo; abort and warn on conflict. Returns non-zero on failure.
pull_repo() {
    local repo=$1
    echo "==> $repo"

    if git -C "$repo" pull; then
        echo "${GREEN}ok${RESET}"
        return 0
    fi

    if merge_in_progress "$repo"; then
        git -C "$repo" merge --abort
        warn "merge conflict in $repo – pull aborted"
    elif rebase_in_progress "$repo"; then
        git -C "$repo" rebase --abort
        warn "rebase conflict in $repo – pull aborted"
    else
        warn "pull failed in $repo (see output above)" "$YELLOW"
    fi
    return 1
}

main() {
    local failed=() repo
    while IFS= read -r -d '' repo; do
        pull_repo "$repo" || failed+=("$repo")
    done < <(find_repos)

    if [ ${#failed[@]} -gt 0 ]; then
        echo
        warn "pull failed/aborted in ${#failed[@]} repo(s):"
        printf '  %s\n' "${failed[@]}" >&2
        exit 1
    fi
    echo "All repositories up to date."
}

main "$@"
