# zmodload zsh/zprof

export ZSH="${HOME}/External/ohmyzsh"
GPG_TTY="$(tty)"
export GPG_TTY
export NVM_DIR="${HOME}/.nvm"
export DISABLE_SPRING="true"
export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
export LESS="-F -R"
export EDITOR="nvim"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export PRETTIERD_DEFAULT_CONFIG="${HOME}/.prettierrc.toml"
export COLORTERM="truecolor"
export TURBO_TELEMETRY_DISABLED=1
export TERM="alacritty"

#shellcheck disable=SC1091
[[ -s "${HOME}/.profile.private" ]] && . "${HOME}/.profile.private"

PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
export PATH

# shellcheck disable=SC2034
ZSH_THEME="robbyrussell"
# shellcheck disable=SC2034
CASE_SENSITIVE="true"
HISTSIZE=1000000
# shellcheck disable=SC2034
SAVEHIST=1000000
# shellcheck disable=SC2034
plugins=(z)
# shellcheck disable=SC2034
DISABLE_AUTO_UPDATE=true

source "${ZSH}/oh-my-zsh.sh"
zstyle ':completion:*' rehash true

if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    # shellcheck disable=SC1094
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    # shellcheck disable=SC1094
    source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if type brew >/dev/null; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

    fpath=(
        "$(brew --prefix)/share/zsh-completions"
        "$(brew --prefix)/share/zsh/site-functions"
        ${fpath[@]}
    )
fi

fpath=(
    "$HOME/.zcompletions"
    ${fpath[@]}
)

# shellcheck disable=SC2034
ZSH_DISABLE_COMPFIX="true"
autoload -U compinit && compinit

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
unsetopt nomatch
unsetopt autocd

# Key Bindings
# NOTE: run `bindkey` to see all keybindings
bindkey '^H' backward-kill-word

alias ll='ls -lah'
alias dc="docker compose"

doit() {
    declare dir="$1"
    if type grealpath >/dev/null; then
        dir="$(fzf -1 -q "$dir" <<<"$(find "${HOME}/Projects" "${HOME}/Work" "${HOME}/External" -type d -mindepth 1 -maxdepth 1 -print0 | xargs -0 grealpath --relative-to="$HOME")")"
    else
        dir="$(fzf -1 -q "$dir" <<<"$(find "${HOME}/Projects" "${HOME}/Work" "${HOME}/External" -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 realpath --relative-to="$HOME")")"
    fi
    [[ -d "${HOME}/${dir}" ]] && cd "${HOME}/${dir}" || return 1
}

if type mise >/dev/null; then
    eval "$(mise activate zsh)"
fi

if [[ -f "$HOME/.config/op/plugins.sh" ]]; then
    source "$HOME/.config/op/plugins.sh"
fi

# zprof
