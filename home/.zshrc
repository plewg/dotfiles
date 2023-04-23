# zmodload zsh/zprof

export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$(tty)

PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"
PATH="/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"
PATH="$HOME/.scripts:$PATH"
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
bindkey -e # emacs
bindkey '^H' backward-kill-word
if [[ "$OSTYPE" == darwin* ]]; then
    if [[ "$TERM" == 'xterm'* ]]; then
        bindkey '\e^[OA' beginning-of-line # alt + up
        bindkey '\e^[OB' end-of-line       # alt + down
        bindkey '\e(' kill-word            # alt + delete
    fi
fi

alias ll='ls -lah'
alias y="yarn"
alias gcan="git commit --amend --no-edit"
alias gca="git commit --amend"
alias gan="git add -N ."
alias dc="docker compose"

# Functions
until_failure()
{
    declare retCode=0
    declare temp="`mktemp`"
    declare count=0

    while [[ "$retCode" == "0" ]]; do
        "$@" >"$temp" 2>&1
        retCode="$?"

        clear
        cat "$temp"
        if [[ $temp != *$'\n' ]]; then
            echo
        fi

        if [[ "$retCode" == "0" ]]; then
            ((count++))
            tput setab 2
            echo -n "$count runs without failure"
            tput sgr0
            echo ": $@"
        fi
    done

    tput setab 1
    echo -n "$count runs without failure"
    tput sgr0
    echo ": $@"
}

while_failing()
{
    declare retCode=1
    declare temp="`mktemp`"
    declare count=0

    while [[ "$retCode" != "0" ]]; do
        "$@" >"$temp" 2>&1
        retCode="$?"

        clear
        cat "$temp"

        if [[ "$retCode" != "0" ]]; then
            ((count++))
            tput setab 1
            echo -n "$count runs without success"
            tput sgr0
            echo ": $@"
        fi
    done

    tput setab 2
    echo -n "$count runs without success"
    tput sgr0
    echo ": $@"
}

pr()
{
    declare base_url
    base_url=$(git config --get remote.origin.url)
    base_url=${base_url%\.git} # remove .git from end of string

    # Fix git@github.com: URLs
    base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

    # Fix git://github.com URLS
    base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}

    declare branch
    branch="$(git br --show-current)"

    declare target
    if [[ -n "$1" ]]; then
        target="$1...${branch}"
    else
        target="$branch"
    fi

    encoded_title=$(ruby -e "require 'erb'; include ERB::Util; puts url_encode(ARGV.first)" "$branch")

    open "${base_url}/compare/${target}?expand=1&title=${encoded_title}"
}

# zprof

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export DISABLE_SPRING=true
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"
