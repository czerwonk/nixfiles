#!/bin/bash
set -e

git_remote=$1
dir=$2

print_usage() {
  echo "This script clones a remote repo checking out the default branch as worktree."
  echo ""
  echo "Usage:"
  echo "./git-worktree-clone.sh git@github.com/my_user/my_repo [ /my/path/to/repo ]"
}

if [[ "$git_remote" == "" ]]; then
  print_usage
  exit 1
fi

if [[ "$dir" == "" ]]; then
  repo_name=$(basename $1 | sed 's|.git||')
  dir=$repo_name
fi

mkdir -p $dir
cd $dir
git clone --bare $git_remote .bare
pushd .bare
default_branch=$(git branch --show-current)
popd
echo "gitdir: .bare" > .git
git worktree add $default_branch
