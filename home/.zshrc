# zmodload zsh/zprof

export ZSH="${HOME}/External/ohmyzsh"
export GPG_TTY="$(tty)"
export NVM_DIR="${HOME}/.nvm"
export DISABLE_SPRING="true"
export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
export LESS="-F -R"
export EDITOR="nvim"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export COLORTERM=truecolor

#shellcheck disable=SC1091
[ -s "${HOME}/.profile.private" ] && . "${HOME}/.profile.private"

PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/.local/share/bob/nvim-bin:${PATH}"
export PATH

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HISTSIZE=1000000
SAVEHIST=1000000
plugins=(z)
DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh
zstyle ':completion:*' rehash true

if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
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

ZSH_DISABLE_COMPFIX="true"
autoload -U compinit && compinit

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
unsetopt nomatch

# Key Bindings
# NOTE: run `bindkey` to see all keybindings
bindkey '^H' backward-kill-word

alias ll='ls -lah'
alias dc="docker compose"
alias rg="rg --hidden --glob '!.git'"

doit() {
    declare dir="$1"
    dir="$(fzf -1 -q "$dir" <<< "$(find "${HOME}/Projects" "${HOME}/Work" "${HOME}/External" -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 realpath --relative-to="$HOME")")"
    [ -d "${HOME}/${dir}" ] && cd "${HOME}/${dir}" || return 1
}

if type mise >/dev/null; then
    eval "$(mise activate zsh)"
fi

if [[ -f "$HOME/.config/op/plugins.sh" ]]; then
    source "$HOME/.config/op/plugins.sh"
fi

# zprof
