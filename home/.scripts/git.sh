#!/usr/bin/env bash

set -e

git::usage() {
    echo 'usage: '
    echo '  ~/.scripts/git.sh cmb <message> [<options>...]'
    echo '  ~/.scripts/git.sh anp <file>...'
    echo '  ~/.scripts/git.sh anpa'
    echo '  ~/.scripts/git.sh repo [<file>]'
    echo '  ~/.scripts/git.sh admins'
    echo '  ~/.scripts/git.sh wip'
    echo '  ~/.scripts/git.sh clone-all <who> [<directory>] [--[no-]archived]'
    echo '  ~/.scripts/git.sh rebase-self'
    echo '  ~/.scripts/git.sh rebase-default'
}

git::cmb() {
    git cm "[$(git branch --show-current | sed -E 's/^([A-Z]{1,}-[0-9]{1,}).*$/\1/')] $1" "${@:2}"
}

git::anp() {
    git -c "advice.addEmptyPathspec=false" add -N --ignore-removal "$@"
    git add -p "$@"
}

git::anpa() {
    git -c "advice.addEmptyPathspec=false" add -N --ignore-removal .
    git add -p .
}

git::anpu() {
    git::anp -u "$@"
}

git::repo() {
    if [[ "$#" -gt 1 ]]; then
        echo 'usage: git repo [<file>]'
        echo '   ie. git repo'
        echo '   ie. git repo package.json'
        return 1
    fi

    declare file="$1"
    declare -a browse_args=()

    # get default branch name
    declare default_branch
    default_branch="$(
        git rev-parse \
            --abbrev-ref \
            --symbolic-full-name \
            remotes/origin/HEAD \
            | cut -d/ -f2
    )"

    # get branch name
    declare branch
    branch="$(git branch --show-current)"

    # append branch arg
    if [[ "$branch" != "$default_branch" ]]; then
        browse_args+=('--branch' "$branch")
    fi

    # append file arg
    if [[ -n "$file" ]]; then
        browse_args+=("$file")
    else
        # get repo root
        declare root
        root="$(git rev-parse --show-toplevel)"

        # get relative pwd path
        declare relative_pwd="${PWD#"$root"}"

        # if not in root, append pwd
        if [[ -n "$relative_pwd" ]]; then
            browse_args+=('.')
        fi
    fi

    # open manually so it doesn't print "Opening ... in your browser"
    open "$(op plugin run -- gh browse --no-browser "${browse_args[@]}")"
}

git::admins() {
    declare repo
    repo="$(op plugin run -- gh repo view --json 'nameWithOwner' -q '.nameWithOwner')"

    # TODO: technically could be more than 100... (we'd need to paginate then...)
    op plugin run -- gh api "/repos/${repo}/collaborators?per_page=100" \
        -q '.[] | select(.permissions.admin == true) | .login'
}

git::wip() {
    # stage changes
    git anpa

    # commit
    declare git_email
    git_email="$(git config user.email)"
    if [[ "$(git log -1 --pretty='%ae: %B')" == "${git_email}: wip" ]]; then
        git commit --amend --no-edit --no-verify
    else
        git cm 'wip' --no-verify
    fi
}

git::clone_all::usage() {
    # TODO: maybe option to delete repos that don't exist? (for backup script...)
    echo "usage: git clone-all <who> [<directory>] [--[no-]archived]"
    echo "   ie. git clone-all pentible ~/pentible"
    echo "   ie. git clone-all ciiqr ~/ciiqr"
    echo "  <directory>       will default to ./{who}"
    echo "  --[no-]archived   if not specified will include both archived and not archived repos"
}

git::clone_all::parse_cli_args() {
    declare -a positional=()

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --archived)
                archived='true'
                ;;
            --no-archived)
                archived='false'
                ;;
            -h | --help)
                git::clone_all::usage
                exit 0
                ;;
            -*)
                echo "$0: unrecognized option $1" 1>&2
                git::clone_all::usage 1>&2
                return 1
                ;;
            *)
                positional+=("$1")
                ;;
        esac
        shift
    done

    # ensure expected number of positional args
    if [[ "${#positional[@]}" -lt 1 || "${#positional[@]}" -gt 2 ]]; then
        echo "git clone-all: unexpected number of positional arguments, got ${#positional[@]} expected 1-2" 1>&2
        git::clone_all::usage 1>&2
        return 1
    fi

    # assign positional args
    who="${positional[0]}"
    directory="${positional[1]:-./${who}}"
}

git::pr() {
    if ! gh pr view --web >/dev/null; then
        gh pr create --web
    fi
}

git::clone_all() {
    declare who
    declare directory
    declare archived=''

    git::clone_all::parse_cli_args "$@"

    # determine list args
    declare -a gh_repo_list_args=()
    if [[ "$archived" = 'true' ]]; then
        gh_repo_list_args+=('--archived')
    elif [[ "$archived" = 'false' ]]; then
        gh_repo_list_args+=('--no-archived')
    fi

    # list all repos
    declare -a repositories=()
    while read -r repo; do
        repositories+=("$repo")
    done <<<"$(
        op plugin run -- gh repo list "$who" \
            --limit '10000' \
            --json 'name' \
            --jq '.[].name' \
            "${gh_repo_list_args[@]}"
    )"

    # make sure directory exists
    mkdir -p "$directory"

    # clone repos in parallel
    parallel \
        --jobs '32' \
        "op plugin run -- gh repo clone '${who}/{}' '${directory}/{}'" \
        ::: "${repositories[@]}"
}

git::rebase_self() {
    git rebase -i "$(git merge-base HEAD origin/HEAD)" "$@"
}

git::rebase_default() {
    git rebase -i origin/HEAD "$@"
}

git::main() {
    case "$1" in
        cmb)
            git::cmb "${@:2}"
            ;;
        anp)
            git::anp "${@:2}"
            ;;
        anpa)
            git::anpa # "${@:2}"
            ;;
        anpu)
            git::anpu "${@:2}"
            ;;
        repo)
            git::repo "${@:2}"
            ;;
        admins)
            git::admins # "${@:2}"
            ;;
        wip)
            git::wip # "${@:2}"
            ;;
        clone-all)
            git::clone_all "${@:2}"
            ;;
        rebase-self)
            git::rebase_self "${@:2}"
            ;;
        rebase-default)
            git::rebase_default "${@:2}"
            ;;
        *)
            git::usage
            return 1
            ;;
    esac
}

git::main "$@"
