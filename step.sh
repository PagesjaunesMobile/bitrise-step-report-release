#!/bin/bash
set -ex

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$THIS_SCRIPT_DIR/libs/messages.sh"


if [ -z "$auth_token" ]; then
  msg_error "auth_token not found"
	exit 1
fi

msg_info "Installing Octokit"
cd $THIS_SCRIPT_DIR && bundle install

msg_info "Executing script"
bundle exec ruby "$THIS_SCRIPT_DIR/step.rb"
exit $?