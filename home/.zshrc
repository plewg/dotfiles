# zmodload zsh/zprof

export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$(tty)

PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"
PATH="/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH
export LESS="-F -R"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HISTSIZE=1000000
SAVEHIST=1000000

plugins=(git jira)

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

# zprof

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export DISABLE_SPRING=true
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"
