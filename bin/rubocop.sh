#!/usr/bin/env bash

# Inspired by http://takemikami.com/2018/01/30/RubocopPullRequestCI.html

BASE_REMOTE=origin
BASE_BRANCH=develop

git fetch $BASE_REMOTE $BASE_BRANCH

diff_list=()
commit_list=`git --no-pager log --no-merges $BASE_REMOTE/$BASE_BRANCH...HEAD | grep -e '^commit' | sed -e "s/^commit \(.\{8\}\).*/\1/"`

for f in `git --no-pager diff $BASE_REMOTE/$BASE_BRANCH...HEAD --name-only`; do
  for c in $commit_list; do
    diffs=`git --no-pager blame --follow --show-name -s $f | grep $c | sed -e "s/^[^ ]* *\([^ ]*\) *\([0-9]*\)*).*$/\1:\2/"`
    for ln in $diffs; do
      diff_list+=("$ln")
    done
  done
done

err_count=0
err_lines=()

while read line; do
  for m in ${diff_list[@]}; do
    if [[ "$line" =~ "$m" ]]; then
      err_count=$(($err_count + 1))
      err_lines+=("$line")
      break
    fi
  done
done < <(bundle exec rubocop --format emacs)

if [ $err_count -ne 0 ]; then
  echo -e "\033[31m$err_count Lint Errors\033[0;39m"
  echo -e "\033[31m-----------------------------------\033[0;39m\n"
  printf '\033[31m%s\n' "${err_lines[@]}"
  echo -e "\033[31mPlease resolve them before merging.\033[0;39m"
  exit 1
fi
