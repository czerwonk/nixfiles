#!/bin/bash

fail_check() {
  echo $1
  exit 2
}

check_repo() {
  git branch -a 2>/dev/null | \
    cut -c 3- | \
    perl -p -e 's#remotes/origin/##' | \
    awk '{ print $1; }' | \
    grep -v "remotes" | \
    sort | \
    uniq -c | \
    awk '{ if($1=="2") { print $2; } ; }' | \
    while read b ; do { [ ! -z "$(git cherry remotes/origin/$b $b 2>/dev/null)" ] && fail_check "$(basename $(pwd)): branch ${b} has unpushed commits" ; } ; done
  git branch -a 2>/dev/null | \
    cut -c 3- | \
    perl -p -e 's#remotes/origin/##' | \
    awk '{ print $1; }' | \
    grep -v "remotes" | sort | uniq -c | \
    awk '{ if($1=="1") { print $2; } ; }' | \
    while read b ; do { [ -z "$(git branch -a | cut -c 3- | awk -v branch="remotes/origin/${b}" '{ if($1==branch) { print $1; } ; }')" ] && fail_check "$(basename $(pwd)): branch ${b} does not exist on remote origin" ; } ; done
  [ ! -z "$(git status --porcelain -uno 2>/dev/null)" ] && fail_check "$(basename $(pwd)): working directory is dirty"
  [ ! -z "$(git status --porcelain -uall 2>/dev/null | perl -n -e 'm/^\?\?/ && print')" ] && fail_check "$(basename $(pwd)): working directory contains untracked files"
  [ ! -z "$(git stash list 2>/dev/null)" ] && fail_check "$(basename $(pwd)): there are existing stashes" ; 
  git status 1>/dev/null 2>&1 || fail_check "$(basename $(pwd)): WARNING, not a git repository"
  [ -z "$(git remote -v 2>/dev/null | grep '^origin')" ] && fail_check "$(basename $(pwd)): WARNING: there's no remote called origin"
}

echo "Git Worktree it"
dir=$1
if [[ ! -d "$dir/.git" ]]; then
  echo "Could not find git checkout in $dir"
  exit 1
fi

echo "Checkout directory: $dir"
pushd $dir
DIR=$(pwd)

echo "Checking repository state..."
check_repo
set -e

echo "Determine current checkout branch"
BRANCH=`git branch --show-current`

echo "Determine origin"
ORIGIN=`git remote show origin -n | awk '/Fetch URL: (.*)/ { print $3 }'`

echo "Delete old checkout at $DIR"
popd
rm -rf $DIR
mkdir $DIR
pushd $DIR

echo "Clone bare repo from origin"
git clone --bare $ORIGIN .bare
echo "gitdir: .bare" > .git

echo "Checkout current branch as worktree"
git worktree add $BRANCH
