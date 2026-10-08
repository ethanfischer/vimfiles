# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


setopt auto_cd
cdpath=($HOME $HOME/repos $HOME/repos/ICS)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias smxg="cd ~/Repos/ICS/InContext.SMXGo"
alias smxgu="cd ~/Repos/ICS/InContext.SMXGo/unityprojects/smxgo_unityproject"
alias eman="cd ~/Repos/ICS/InContext.Everyman/trunk"
alias lg="lazygit"
#alias slg="sudo lazygit"
alias alie="nvim ~/vimfiles/zshrc"
alias spd="nvim /Users/Shared/repos/ScratchPad/ScratchPad.txt"
alias ssp="sudo nvim /Users/Shared/ScratchPad.txt"
alias vim=nvim
alias e.="open ."
alias src="source ~/.zshrc"
alias vs="open *.sln"
alias psh="git push"

GHOSTTY_CONFIG=~/.config/ghostty/config
ghostty-light() {
  local theme="${1:-Builtin Light}"
  sed -i '' "s/^theme = .*/theme = $theme/" "$GHOSTTY_CONFIG"
  sed -i '' 's/^background-image/#background-image/' "$GHOSTTY_CONFIG"
  if grep -q '^minimum-contrast' "$GHOSTTY_CONFIG"; then
    sed -i '' 's/^minimum-contrast = .*/minimum-contrast = 3/' "$GHOSTTY_CONFIG"
  else
    sed -i '' "s/^theme = $theme/theme = $theme\\
minimum-contrast = 3/" "$GHOSTTY_CONFIG"
  fi
  echo "Ghostty theme -> $theme (background image disabled, minimum-contrast set for legibility). Reload with Cmd+Shift+, "
}
ghostty-dark() {
  local theme="${1:-iterm-hotkey}"
  sed -i '' "s/^theme = .*/theme = $theme/" "$GHOSTTY_CONFIG"
  sed -i '' 's/^#background-image/background-image/' "$GHOSTTY_CONFIG"
  sed -i '' '/^minimum-contrast = /d' "$GHOSTTY_CONFIG"
  echo "Ghostty theme -> $theme (background image restored, minimum-contrast removed). Reload with Cmd+Shift+, "
}
alias pl="git pull"
alias chm="git checkout master"
alias wchm="git checkout main"
alias lp="git log --pretty=oneline"
alias c="git commit"
alias status="git status"
alias sta="git add . ; git stash"
alias stp="git stash pop"
alias smxgd="cd ~/Library/Application\ Support/InContext\ Solutions/SMX\ GO\ \(LOCAL\)/"
alias ch-="git checkout -"
alias pss="git push -u origin HEAD"
alias ch="git checkout $*"
mm() {
  local branch
  branch=$(git ls-remote --symref origin HEAD 2>/dev/null | awk '/^ref:/{sub("refs/heads/","",$2); print $2; exit}')
  [ -z "$branch" ] && branch=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@')
  [ -z "$branch" ] && branch=main
  git fetch origin "$branch" && git merge FETCH_HEAD
}
alias wmm=mm
alias nuke="git reset --hard ; git clean -fd"
alias insta="adb install unitybuild.apk"
alias build="dotnet build perfaware/part2/HaversineProcessor/HaversineProcessor.sln"
alias run="perfaware/part2/HaversineProcessor/HaversineProcessor/bin/Debug/net7.0/HaversineProcessor"
alias pat='security find-generic-password -a "$USER" -s azure-devops-pat -w | pbcopy'
alias ib="xcodebuild -project "unitybuild/Unity-iPhone.xcodeproj" -scheme "Unity-iPhone" -sdk iphoneos build PROVISIONING_PROFILE_SPECIFIER='SMX Go' DEVELOPMENT_TEAM='3644B598RN'"
#alias inst="xcodebuild -project 'unitybuild/Unity-iPhone.xcodeproj' -scheme 'Unity-iPhone' -sdk iphoneos build PROVISIONING_PROFILE_SPECIFIER='SMX Go' DEVELOPMENT_TEAM='3644B598RN' && ios-deploy --bundle /Users/ethanfischer/Library/Developer/Xcode/DerivedData/Unity-iPhone-fjaixfekrmctfegofxkmdtfonveo/Build/Products/Debug-iphoneos/SMXGOLOCAL.app && notif && say 'installed' && big INSTALLED"
alias inst="xcodebuild -project 'unitybuild/Unity-iPhone.xcodeproj' \ CODE_SIGN_IDENTITY="" \ CODE_SIGNING_REQUIRED=NO \ CODE_SIGN_ENTITLEMENTS="" \ CODE_SIGNING_ALLOWED=YES \ DEVELOPMENT_TEAM='3644B598RN' \ -allowProvisioningUpdates \ build && ios-deploy --bundle /Users/ethanfischer/Library/Developer/Xcode/DerivedData/Unity-iPhone-fjaixfekrmctfegofxkmdtfonveo/Build/Products/Debug-iphoneos/SMXGOLOCAL.app && notif && say 'installed' && big INSTALLED"
alias notif="osascript -e 'display notification \"iOS Install Finished\" with title \"iOS Install Finished\"'"
alias smxgcl="rm -rf '/Users/ethanfischer/Library/Application Support/InContext Solutions/SMX GO (LOCAL)'"
alias matrix="cmatrix"
alias train="sl"
alias big="figlet $*"
alias bonsai="cbonsai -l --life=75"
alias aquarium="asciiquarium"
alias cs="gh copilot suggest $*"
alias ce="gh copilot explain $*"
azb() {
  current_branch=$(git branch --show-current)
  repo_name=$(git config --get remote.origin.url | awk -F '/' '{print $NF}' | sed 's/.git//g')
  pipeline_id=$(az pipelines list --output tsv --query "[?name=='$repo_name'].id | [0]" 2>/dev/null)
  build_result=$(az pipelines run --id "$pipeline_id" --branch "$current_branch" --output table 2>/dev/null)
  build_id=$(echo "$build_result" | grep -E '^[0-9]+' | awk '{print $1}')
  open "https://incontextsolutions.visualstudio.com/ICS/_build/results?buildId=$build_id&view=results"
}
amlb() {
    azml
}
azml() {
  current_branch=$(git branch --show-current)
  build_result=$(az pipelines run --id 145 --branch "$current_branch" --output table 2>/dev/null)
  build_id=$(echo "$build_result" | grep -E '^[0-9]+' | awk '{print $1}')
  open "https://incontextsolutions.visualstudio.com/ICS/_build/results?buildId=$build_id&view=results"
}
alias cportal="cd InContext.ClientPortal"
alias cpl="cd InContext.ClientPortal"
alias ptl="cd InContext.Portal"
alias ref="git reflog"
alias lsdate="ls -ltr"
alias lsd="ls -ltr"
alias notify='tput bel; afplay /System/Library/Sounds/Hero.aiff & terminal-notifier -title "Terminal" -message "Done with task! Exit status: $?"'
#alias cc='env -u TERM_PROGRAM -u TERM_PROGRAM_VERSION TERM=xterm-256color claude' # fixes this regression https://github.com/anthropics/claude-code/issues/16727
#alias ccr='env -u TERM_PROGRAM -u TERM_PROGRAM_VERSION TERM=xterm-256color claude --resume'
#alias ccc='env -u TERM_PROGRAM -u TERM_PROGRAM_VERSION TERM=xterm-256color claude --continue'
alias cleanmymac='ncdu /'
alias amlprod='export ICS_TOOLS_KEY="$(security find-generic-password -a "$USER" -s ics-tools-key -w)"
az account set --subscription "5dcd112c-4999-44be-88d3-8f71332c6893"
export AZURE_RESOURCE_GROUP="computer-vision"
export AZURE_WORKSPACE="MultiStageCV-Prod"
export AZURE_COMPUTE_CLUSTER="fallback-gpu-nd40"
export AZURE_ENVIRONMENT_NAME="train-classification"
export AZURE_ENVIRONMENT_VERSION="1"
export AZURE_SUBSCRIPTION_ID="5dcd112c-4999-44be-88d3-8f71332c6893"
export AZURE_DATASTORE="datasets_prod"
export MODEL_SEGMENT_NAME="sweetsnacks-USA-307.1"
export SHOPPERMX_PRODUCTS_BASE_URL="https://app.shoppermx.com"
export SHOPPERMX_THUMBNAILS_BASE_URL="https://prod-smx-everyman.azurewebsites.net"
export INCONTEXT_PORTAL_API_URL="https://prod-ics-portal-app.azurewebsites.net"'
alias amldev='export ICS_TOOLS_KEY="$(security find-generic-password -a "$USER" -s ics-tools-key -w)"
az account set --subscription "06c91f00-f9e6-48b2-beb5-62e618ed6e5b"
export AZURE_RESOURCE_GROUP="dev-vision"
export AZURE_WORKSPACE="Sauron-Dev-III"
export AZURE_COMPUTE_CLUSTER="NVIDIATeslaV100-8x"
export AZURE_ENVIRONMENT_NAME="train-classification"
export AZURE_ENVIRONMENT_VERSION="1"
export AZURE_SUBSCRIPTION_ID="06c91f00-f9e6-48b2-beb5-62e618ed6e5b"
export AZURE_DATASTORE="datasets_dev"
export MODEL_SEGMENT_NAME="sweetsnacks-USA-792.1"
export SHOPPERMX_PRODUCTS_BASE_URL="https://dev-app.shoppermx.com"
export SHOPPERMX_THUMBNAILS_BASE_URL="https://dev-everyman-centralus-incontext-everyman.azurewebsites.net"
export INCONTEXT_PORTAL_API_URL="https://dev-app.shoppermx.com"
export SAVE_ALL_TRANSFORMS=true'

function pr() {
  # Try to create a new PR
  pr_output=$(az repos pr create 2>&1)
  echo "Pr output $pr_output"

  if [[ $pr_output == *"TF401179"* ]]; then
    # If PR already exists, fetch the existing PR ID
    pr_id=$(az repos pr list --status active | jq -r '.[0].pullRequestId')
  else
    # If a new PR is created, parse the PR ID from the output
    pr_id=$(echo $pr_output | jq -r '.pullRequestId')
  fi

  echo "Pr id $pr_id"
  # Get the repo name from the remote origin URL
  repo=$(git config --get remote.origin.url | awk -F '/' '{print $NF}' | sed 's/.git//g')

  echo "repo $repo"
  # Construct the URL of the PR
  pr_url="https://incontextsolutions.visualstudio.com/ICS/_git/$repo/pullrequest/$pr_id"

  echo "pr_url $pr_url"
  # Open the PR in the browser
  open $pr_url
}

ics() {
    if [ $# -eq 0 ]; then
        cd ~/repos/ICS
        return
    fi

    cd "InContext.$1"
}

v() {
    vim $(fd "$1")
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=$PATH:~/Android/Sdk/platform-tools
export PATH=$PATH:~/Library/Android/sdk/platform-tools


# Change cursor shape for vi-mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne "\e[2 q"
  elif [[ ${KEYMAP} == main ]]; then
    echo -ne "\e[6 q"
  fi
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
KEYTIMEOUT=1
#end change cursor shape for vi-mode

# accept autosuggestions
bindkey "^[[Z" autosuggest-accept
# End accept autosuggestions
export PATH=$PATH:/Users/ethanfischer/Library/Android/sdk/emulator
export PATH=$PATH:/Users/ethanfischer/Library/Android/sdk/tools
export PATH=$PATH:/Users/ethanfischer/Library/Android/sdk/platform-tools

#homebrew
export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew/Homebrew"


export HAXE_STD_PATH="/opt/homebrew/lib/haxe/std"


#NOTES:
# ncdu: great commandline tool for cleaning disk space on mac. Install with homebrew
#
# Needed for Claude Code
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/vimfiles/bin:$PATH"


# Work Claude Code via ICS Claude for Teams (OAuth login via /login).
# claude-narrow caps the measure per-process, so vim/lazygit keep the full window
# and `margin` can stay at laptop. Override with: CLAUDE_COLUMNS=999 cc
_ccwork() {
    claude-narrow "$@"
}
cc()  { _ccwork "$@"; }
ccr() { _ccwork --resume "$@"; }
ccc() { _ccwork --continue "$@"; }


# iTerm2 side margins are a global pixel value, so fullscreen text width has to be
# retuned by hand when switching between laptop screen and external monitor.
# Contrary to the docs, this applies live -- no iTerm2 restart.
ITERM_MARGIN_LAPTOP=0
ITERM_MARGIN_MONITOR=700

margin() {
    local domain=com.googlecode.iterm2 current target
    current=$(defaults read "$domain" TerminalMargin 2>/dev/null) || current=5
    case "$1" in
        "")
            if [ "$current" -ge "$ITERM_MARGIN_MONITOR" ]; then
                target=$ITERM_MARGIN_LAPTOP
            else
                target=$ITERM_MARGIN_MONITOR
            fi
            ;;
        laptop)  target=$ITERM_MARGIN_LAPTOP ;;
        monitor) target=$ITERM_MARGIN_MONITOR ;;
        <->)     target=$1 ;;
        *)       print -u2 "usage: margin [laptop|monitor|<pixels>]"; return 1 ;;
    esac
    defaults write "$domain" TerminalMargin -int "$target"
    print "TerminalMargin: $current -> $target"
}


# ── git worktrees ────────────────────────────────────────────────────────────
# Worktrees live in a sibling <repo>-worktrees/ dir. Every command below works
# from inside the main clone, inside any worktree, or from the -worktrees dir
# itself (which is not a repo, so plain git commands fail there).
WT_SUFFIX="-worktrees"

_wt_main() {
    local common dir
    if common=$(git rev-parse --git-common-dir 2>/dev/null); then
        common=${common:A}
        [[ ${common:t} == .git ]] && print -r -- ${common:h} || print -r -- $common
        return 0
    fi
    dir=${PWD:A}
    while [[ $dir != / ]]; do
        if [[ $dir == *$WT_SUFFIX && -d ${dir%$WT_SUFFIX}/.git ]]; then
            print -r -- ${dir%$WT_SUFFIX}
            return 0
        fi
        dir=${dir:h}
    done
    print -u2 "wt: run this from a repo, a worktree, or a *$WT_SUFFIX directory"
    return 1
}

_wt_base_branch() {
    local b
    if b=$(git -C "$1" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null); then
        print -r -- ${b#origin/}
        return
    fi
    for b in main master; do
        git -C "$1" show-ref --verify --quiet "refs/remotes/origin/$b" && { print -r -- $b; return }
    done
    print -r -- main
}

_wt_paths() {
    git -C "$1" worktree list --porcelain | awk '/^worktree /{print substr($0, 10)}'
}

_wt_pick() {
    _wt_paths "$1" | fzf --query="${2:-}" --select-1 --exit-0 --height=40% --reverse
}

# wt                      list worktrees
# wt <branch>             new worktree off latest origin/main, or check out an existing branch
# wt -b <base> <branch>   base it on something other than main
# wt <branch> <dir>       override the directory name
wt() {
    local base="" branch dir main root dest
    while [[ $1 == -* ]]; do
        case $1 in
            -b) base=$2; shift 2 ;;
            -h|--help) print "usage: wt [-b base] <branch> [dir]"; return 0 ;;
            *)  print -u2 "wt: unknown flag $1"; return 1 ;;
        esac
    done

    main=$(_wt_main) || return 1
    [[ -z $1 ]] && { git -C "$main" worktree list; return 0 }

    branch=$1
    dir=${2:-${branch//\//-}}
    root="${main}${WT_SUFFIX}"
    dest="$root/$dir"
    [[ -e $dest ]] && { print -u2 "wt: $dest already exists"; return 1 }
    [[ -z $base ]] && base=$(_wt_base_branch "$main")
    mkdir -p "$root"

    if git -C "$main" show-ref --verify --quiet "refs/heads/$branch"; then
        git -C "$main" worktree add "$dest" "$branch" || return 1
    elif git -C "$main" ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
        git -C "$main" fetch --quiet origin "$branch" &&
        git -C "$main" worktree add --track -b "$branch" "$dest" "origin/$branch" || return 1
    else
        print "fetching origin/$base ..."
        git -C "$main" fetch --quiet origin "$base" || return 1
        git -C "$main" worktree add -b "$branch" "$dest" FETCH_HEAD || return 1
    fi

    cd "$dest"
    git status --short --branch
}

wtl() {
    local main; main=$(_wt_main) || return 1
    git -C "$main" worktree list | while IFS= read -r line; do
        local wtpath=${line%% *}
        local bt=$(stat -f %B "$wtpath" 2>/dev/null || print 0)
        local created=$(stat -f "%SB" -t "%Y-%m-%d %H:%M" "$wtpath" 2>/dev/null || print "?")
        printf '%s\t%s  %s\n' "$bt" "$created" "$line"
    done | sort -rn -k1,1 | cut -f2-
}

wtcd() {
    local main dest
    main=$(_wt_main) || return 1
    dest=$(_wt_pick "$main" "$1") || return 1
    [[ -n $dest ]] && cd "$dest"
}

wtm() {
    local main; main=$(_wt_main) || return 1
    cd "$main"
}

wtrm() {
    local main dest branch
    main=$(_wt_main) || return 1
    dest=$(_wt_pick "$main" "$1") || return 1
    [[ -z $dest ]] && return 1
    [[ ${dest:A} == ${main:A} ]] && { print -u2 "wt: that's the main clone"; return 1 }

    branch=$(git -C "$dest" branch --show-current)
    [[ ${PWD:A} == ${dest:A}(|/*) ]] && cd "$main"
    git -C "$main" worktree remove "$dest" || return 1
    print "removed $dest"
    if [[ -n $branch ]]; then
        read -q "?delete local branch $branch? [y/N] "
        print
        [[ $REPLY == y ]] && git -C "$main" branch -D "$branch"
    fi
}

wtprune() {
    local main; main=$(_wt_main) || return 1
    git -C "$main" worktree prune -v
}
