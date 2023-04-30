#!/usr/bin/env bash

set -e

declare repo_dir
repo_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# go to repo directory
cd "$repo_dir"

# install nk
curl -fsSL 'https://raw.githubusercontent.com/ciiqr/nk/HEAD/install.sh' | bash

# add to path
export PATH="${HOME}/.nk/bin:${PATH}"

# provision
echo '==> provision'
nk provision
