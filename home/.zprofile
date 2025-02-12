
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="${HOME}/.nk/bin:${PATH}"

if which mise > /dev/null; then
    eval "$(mise activate zsh --shims)"
fi
