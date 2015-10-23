# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

ZSH_THEME="waltsu"

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
export PATH=$PATH:/usr/local/opt/posgresql/bin:/opt/local/bin:/opt/local/sbin:/Users/valtteri/.rvm/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/texlive/2013/bin/universal-darwin

export WORKON_HOME=$HOME/waltsu/.virtualenvs
export EDITOR=vim
source /usr/local/bin/virtualenvwrapper.sh

ulimit -n 1200
export SBT_OPTS=-XX:MaxPermSize=256m

export LC_ALL=fi_FI.UTF-8
export LANG=fi_FI.UTF-8

### Added by the Heroku Toolbelt
export PATH="/Users/waltsu/.nvm/v0.8.22/bin:$PATH"
export PATH="/Users/waltsu/.rvm/gems/ruby-2.1.0/bin:$PATH"

export JAVA7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home
export JAVA8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home

[[ -s /Users/waltsu/.nvm/nvm.sh ]] && . /Users/waltsu/.nvm/nvm.sh && nvm use 0.12
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm use 2.1.5

function at_image
{
  scp ci.tuntivirta.com:/tmp/$1 /tmp/
  open /tmp/$1
  sleep 2
  rm /tmp/$1
}

alias rallymode='cp ../../waltsu/authorization.yml config/authorization.yml && cp ../../waltsu/development.rb config/environments/development.rb'
alias grb='for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ci %cr" $branch | head -n 1` \\t$branch; done | sort -r'
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
