
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="${HOME}/.nk/bin:${PATH}"

if type mise > /dev/null; then
    eval "$(mise activate zsh --shims)"
fi
