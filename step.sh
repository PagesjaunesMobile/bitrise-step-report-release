#!/bin/bash
set -ex

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$THIS_SCRIPT_DIR/libs/messages.sh"


if [ -z "$auth_token" ]; then
  msg_error "auth_token not found"
	exit 1
fi

export DEST_BRANCH="feat/reportRelease"
git fetch origin develop
git branch $DEST_BRANCH
git checkout $DEST_BRANCH
git rebase -p origin/develop
if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/develop)" ]; then
  set +e && git push origin --delete $DEST_BRANCH && set -e
  git push origin $DEST_BRANCH
  msg_info "Installing Octokit"
  cd $THIS_SCRIPT_DIR && gem install gitlab
  msg_info "Executing script"
  ruby "$THIS_SCRIPT_DIR/step.rb"
fi
exit $?
