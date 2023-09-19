# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
# zstyle ':omz:update' mode auto      # update automatically without asking
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
alias smxg="cd ~/repos/ics/InContext.SMXGo"
alias smxgu="cd ~/repos/ics/InContext.SMXGo/unityprojects/smxgo_unityproject"
alias lg="lazygit"
alias aliase="nvim ~/.zshrc"
alias sp="nvim ~/Documents/Notes/ScratchPad.txt"
alias vim=nvim
alias e.="nautilus ."
alias src="source ~/.zshrc"
alias ics="cd ~/Repos/ICS"
alias vs="open *.sln"
alias psh="git push"
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
alias mm="git checkout master ; git pull ; git checkout - ; git merge master"
alias wmm="git checkout main ; git pull ; git checkout - ; git merge main"
alias nuke="git reset --hard ; git clean -fd"



function pr() {
  # Try to create a new PR
  pr_output=$(az repos pr create 2>&1)

  if [[ $pr_output == *"TF401179"* ]]; then
    # If PR already exists, fetch the existing PR ID
    pr_id=$(az repos pr list --status active | jq -r '.[0].pullRequestId')
  else
    # If a new PR is created, parse the PR ID from the output
    pr_id=$(echo $pr_output | jq -r '.pullRequestId')
  fi

  # Get the repo name from the remote origin URL
  repo=$(git config --get remote.origin.url | awk -F '/' '{print $NF}' | sed 's/.git//g')

  # Construct the URL of the PR
  pr_url="https://incontextsolutions.visualstudio.com/ICS/_git/$repo/pullrequest/$pr_id"

  # Open the PR in the browser
  xdg-open $pr_url
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



setopt auto_cd
cdpath=($HOME $HOME/repos $HOME/repos/ICS)

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




export PATH=$PATH:~/Android/Sdk/platform-tools