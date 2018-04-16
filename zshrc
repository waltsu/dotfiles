# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="waltsu"

# Kubernetes info to right side of the prompt
autoload -U colors; colors
source /Users/waltsu/.oh-my-zsh/zsh-kubectl-prompt/kubectl.zsh
RPROMPT='($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"
# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13
# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"
# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git node npm bundler)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH="/Users/waltsu/sdk/platform-tools:/Users/waltsu/sdk/tools:$PATH"
export PATH="/usr/local/Cellar/git/2.14.1/bin:$PATH"

export WORKON_HOME=$HOME/.virtualenvs
export EDITOR=vim
source /usr/local/bin/virtualenvwrapper.sh

ulimit -n 1200
export SBT_OPTS=-XX:MaxPermSize=256m

export LC_ALL=fi_FI.UTF-8
export LANG=fi_FI.UTF-8

alias grb='for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ci %cr" $branch | head -n 1` \\t$branch; done | sort -r'

alias pepify="pep8radius --in-place --ignore=E501,E128,E301,E303,E111,W601,W191"
alias pepdiff="pep8radius --diff --ignore=E501,E128,E301,E303,E111,W601,W191"
alias vim="/usr/local/bin/vim"
alias k="kubectl"

prod-utils() {
  kubectl run -ti --rm --restart=Never utils-valtteri --image=wolt/utils --context=prod --image-pull-policy=Always -- bash
}

dev-utils() {
  kubectl run -ti --rm --restart=Never utils-valtteri --image=wolt/utils --context=dev --image-pull-policy=Always -- bash
}

export NVM_DIR="/Users/waltsu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export CDPATH=.:~/workspace # Comma separated list
nvm use 7
