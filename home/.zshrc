# zmodload zsh/zprof

export ZSH="${HOME}/.oh-my-zsh"
export GPG_TTY="$(tty)"
export NVM_DIR="${HOME}/.nvm"
export DISABLE_SPRING="true"
export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export LESS="-F -R"
export RAILS_LOG_LEVEL="warn"

#shellcheck disable=SC1091
[ -s "${HOME}/.profile.private" ] && . "${HOME}/.profile.private"

PATH="/opt/homebrew/bin:${PATH}"
PATH="/opt/homebrew/sbin:${PATH}"
if [[ "$HOST" == "work-paige" ]]; then
    PATH="/opt/homebrew/opt/postgresql@12/bin:${PATH}"
    PATH="/opt/homebrew/opt/python@3.10/libexec/bin:${PATH}"
else
    PATH="/opt/homebrew/opt/ruby@2.7/bin:${PATH}"
fi

PATH="${HOME}/.local/bin:${PATH}"
export PATH

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HISTSIZE=1000000
SAVEHIST=1000000
plugins=(git jira)
DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fpath=(
    "$(brew --prefix)/share/zsh-completions"
    "$(brew --prefix)/share/zsh/site-functions"
    $fpath
)

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
alias y="yarn"
alias gcan="git commit --amend --no-edit"
alias gca="git commit --amend"
alias gan="git add -N ."
alias dc="docker compose"
alias p="pnpm"

doit() {
    declare dir="$1"
    if [[ -z "$dir" || ! -d "${HOME}/Projects/${dir}" ]]; then
        #shellcheck disable=SC2038
        dir="$(fzf -q "$dir" <<< "$(find "${HOME}/Projects" -type d -mindepth 1 -maxdepth 1 | xargs basename)")"
    fi

    if [[ -z "$dir" ]]; then
        return 1
    fi
    cd "${HOME}/Projects/${dir}" || return 1
}

# zprof

if which rbenv > /dev/null; then
    eval "$(rbenv init - zsh)"
fi
if which nodenv > /dev/null; then
    eval "$(nodenv init -)"
fi
eval "$(direnv hook zsh)"

[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"  # This loads nvm
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
source /Users/paige/.config/op/plugins.sh
