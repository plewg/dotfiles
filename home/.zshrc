# zmodload zsh/zprof

export ZSH="${HOME}/External/.oh-my-zsh"
export GPG_TTY="$(tty)"
export NVM_DIR="${HOME}/.nvm"
export DISABLE_SPRING="true"
export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export LESS="-F -R"
export RAILS_LOG_LEVEL="warn"
export EDITOR="nvim"

#shellcheck disable=SC1091
[ -s "${HOME}/.profile.private" ] && . "${HOME}/.profile.private"

PATH="${HOME}/.local/bin:${PATH}"
export PATH

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HISTSIZE=1000000
SAVEHIST=1000000
plugins=(z)
DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fpath=(
    "$HOME/.zcompletions"
    "$(brew --prefix)/share/zsh-completions"
    "$(brew --prefix)/share/zsh/site-functions"
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
# bindkey -e # emacs
# bindkey '^H' backward-kill-word
bindkey "^X\\x7f" backward-kill-line
# if [[ "$OSTYPE" == darwin* ]]; then
#     if [[ "$TERM" == 'xterm'* ]]; then
#         bindkey '\e^[OA' beginning-of-line # alt + up
#         bindkey '\e^[OB' end-of-line       # alt + down
#         bindkey '\e(' kill-word            # alt + delete
#     fi
# fi

alias ll='ls -lah'
alias dc="docker compose"
alias op_us="op item edit 'AWS Access Key' 'default region=us-east-1'"
alias op_uk="op item edit 'AWS Access Key' 'default region=eu-west-2'"
alias rg="rg --hidden --glob '!.git'"

doit() {
    declare dir="$1"
    dir="$(fzf -1 -q "$dir" <<< "$(find "${HOME}/Projects" "${HOME}/Work" "${HOME}/External" -type d -mindepth 1 -maxdepth 1 -print0 | xargs -0 grealpath --relative-to="$HOME")")"
    [ -d "${HOME}/${dir}" ] && cd "${HOME}/${dir}" || return 1
}

if which mise > /dev/null; then
    eval "$(mise activate zsh)"
fi

# if which rbenv > /dev/null; then
#     eval "$(rbenv init - zsh)"
# fi
# if which nodenv > /dev/null; then
#     eval "$(nodenv init -)"
# fi
eval "$(direnv hook zsh)"

# [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"                   # This loads nvm
# [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion" # This loads nvm bash_completion
[ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"

# zprof
