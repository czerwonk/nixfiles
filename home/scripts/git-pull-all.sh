#!/usr/bin/env bash
# Pull every git repository below the current directory.
# On a merge/rebase conflict: print a warning and abort the pull for that repo.

set -u

RED=$'\e[31m'; YELLOW=$'\e[33m'; GREEN=$'\e[32m'; RESET=$'\e[0m'
failed=()

while IFS= read -r -d '' gitdir; do
    repo="$(dirname "$gitdir")"
    echo "==> $repo"

    if git -C "$repo" pull; then
        echo "${GREEN}ok${RESET}"
        continue
    fi

    # Pull failed: abort any merge/rebase it left behind
    if git -C "$repo" rev-parse -q --verify MERGE_HEAD >/dev/null; then
        git -C "$repo" merge --abort
        echo "${RED}WARNING: merge conflict in $repo – pull aborted${RESET}" >&2
    elif [ -d "$gitdir/rebase-merge" ] || [ -d "$gitdir/rebase-apply" ]; then
        git -C "$repo" rebase --abort
        echo "${RED}WARNING: rebase conflict in $repo – pull aborted${RESET}" >&2
    else
        echo "${YELLOW}WARNING: pull failed in $repo (see output above)${RESET}" >&2
    fi
    failed+=("$repo")
done < <(find . -type d -name .git -prune -print0 | sort -z)

if [ ${#failed[@]} -gt 0 ]; then
    echo
    echo "${RED}Pull failed/aborted in ${#failed[@]} repo(s):${RESET}" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi

echo "All repositories up to date."
