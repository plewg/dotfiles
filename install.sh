#!/usr/bin/env bash

set -e

declare repo_dir
repo_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# go to repo directory
cd "$repo_dir"

# args
declare machine="$1"
if [[ -z "$machine" ]]; then
    echo 'missing required argument: <machine>' >&2
    echo '  - laptop-paige' >&2
    echo '  - work-paige' >&2
    exit 1
fi

# install nk
curl -fsSL 'https://raw.githubusercontent.com/ciiqr/nk/HEAD/install.sh' | bash

# add to path
export PATH="${HOME}/.nk/bin:${PATH}"

# configure machine
echo '==> configure machine'
nk var set machine "$machine"

# provision
echo '==> provision'
nk provision
