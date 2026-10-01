#!/bin/zsh

set -euo pipefail

project_dir=${0:A:h}
exec /usr/bin/ruby "$project_dir/scripts/install.rb"

